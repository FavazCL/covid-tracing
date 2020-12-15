import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/models/EphId.dart';
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:covid_app/app/data/models/Report.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CryptoController extends GetxController {
  static const int EPHID_LENGTH = 16;
  static const String EPHIDS = 'EPHIDS_JSON';
  static const String IVE = 'F0Wlnt0zTvcB6bHW';
  final SharedPrefsController prefs =
      Get.put<SharedPrefsController>(SharedPrefsController());
  EphId _ephId = EphId();
  List<EphId> _ephIds = List<EphId>();

  EphId get ephId => _ephId;
  List<EphId> get ephIds => _ephIds;

  set setEphId(EphId value) {
    _ephId = value;
    update();
  }

  set setEphIds(List<EphId> value) {
    _ephIds = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    _getCurrentEphIds();
  }

  void _getCurrentEphIds() {
    if (prefs.ephids.isNullOrBlank) {
      _createEphId();
    } else {
      var decode = json.decode(prefs.ephids);
      print('decode: $decode');
      for (var ephId in decode) {
        List<int> listInt = List.castFrom(ephId['data']);
        ephId['data'] = Uint8List.fromList(listInt);

        EphId ephIdTmp = EphId.fromJson(ephId);
        _ephIds.add(ephIdTmp);
      }

      _getCurrentEphId();
    }
  }

  void _getCurrentEphId() {
    DateTime currentDay = DateTime.now();

    for (EphId ephId in ephIds) {
      var parseDate = DateTime.fromMillisecondsSinceEpoch(ephId.createdAt);
      int diffDays = currentDay.difference(parseDate).inDays;
      bool isSame = (diffDays == 0 && parseDate.day == currentDay.day);

      if (isSame) {
        print('Son iguales');
        _ephId = ephId;
      } else {
        print('No son iguales');
        print('ephid: ${ephId.data}');
        _createEphId();
      }
    }
  }

  void _createEphId() {
    try {
      final secretKey = SecureRandom(16);
      final dateTime = DateTime.now().millisecondsSinceEpoch;

      _ephId = EphId(createdAt: dateTime, data: secretKey.bytes);
      var encode = json.encode(ephId);

      if (!prefs.ephids.isNullOrBlank) {
        var listEphids = json.decode(prefs.ephids);
        List newListEphids = List();

        for (var item in listEphids) {
          item = json.encode(item);
          newListEphids.add(item);
        }

        newListEphids.add(encode);
        prefs.ephids = newListEphids.toString();
      } else {
        List ephIds = List();
        ephIds.add(encode);
        prefs.ephids = ephIds.toString();
      }

      /* TO DO.. Encriptar
      final key = Key.fromLength(32);
      final iv = IV.fromUtf8(IVE);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encryptBytes(secretKey.bytes, iv: iv);
      */

    } catch (e) {
      print('Error on createEphid: $e');
    }
  }

  void compareEphIds(Report report) async {
    final DBRepository _dbRepository = Get.put<DBRepository>(DBRepository());
    List<Handshake> _handshakes = await _dbRepository.getAllHandshakes();
    Iterable<Handshake> _handshakesFiltered;

    // 0. Mensaje avisando que se esta analizando localmente el contacto.
    Get.snackbar('Analizando...', '',
        snackPosition: SnackPosition.TOP,
        messageText: Text(
            'Verificando si su dispotivo es un contacto estrecho.',
            style: TextStyle(color: Colors.white)),
        colorText: Colors.white,
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.white,
        progressIndicatorValueColor:
            AlwaysStoppedAnimation<Color>(ColorsPalette.primary),
        icon: Icon(Icons.wifi_protected_setup, color: ColorsPalette.primary));

    Future.delayed(Duration(seconds: 4), () async {
      // 1. Obtener todos los handshakes locales que coinciden con el ephId reportado.
      _handshakesFiltered = _handshakes.where((Handshake handshake) =>
          handshake.ephId.data.toString() == report.ephId.data.toString());

      // 2. Filtramos y dejamos solo los de los últimos 14 días.
      _handshakesFiltered = _handshakesFiltered.where((Handshake handshake) =>
          DateTime.fromMillisecondsSinceEpoch(report.reportDate)
              .difference(
                  DateTime.fromMillisecondsSinceEpoch(handshake.timestamp))
              .inDays <=
          14);

      // 3. Filtramos y dejamos solo los que esten dentro del rango de 2 mts.
      _handshakesFiltered = _handshakesFiltered.where((Handshake handshake) =>
          pow(10, ((handshake.txPowerLevel - (handshake.rssi)) / (10 * 2))) <
          2);

      // 4. Filtramos y dejamos solo los que tuvieron un intervalo de tiempo mayor o igual a 15 min.
      var _handshakesList = _handshakesFiltered.toList();
      _handshakesList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      var minutes = 0;
      for (var i = 0; i < _handshakesList.length; i++) {
        if (i + 1 < _handshakesList.length) {
          var diff =
              DateTime.fromMillisecondsSinceEpoch(_handshakesList[i].timestamp)
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                      _handshakesList[i + 1].timestamp));
          minutes += diff.inMinutes;
        }
      }

      // 5. Si se cumple se manda un mensaje avisando que es contacto estrecho o no.
      if (minutes >= 5) {
        // Crear y almacenar localmente un nuevo contacto.
        Contact _contact = Contact();
        _contact.createdAt = DateTime.now().millisecondsSinceEpoch;
        _contact.handshakes = _handshakesList;
        _contact.duration = minutes;
        _contact.shared = 0;

        await _dbRepository.createContact(contact: _contact);
        
        // Notificar alerta de contacto estrecho
        Get.snackbar('Alerta de contacto estrecho!', '',
            snackPosition: SnackPosition.TOP,
            messageText: Text(
                'Tu dispositivo detecto que tuviste un contacto estrecho con el diagnosticado, haz click aquí para ver los pasos a seguir.',
                style: TextStyle(color: Colors.white)),
            colorText: Colors.white,
            onTap: (_) => print('Click: $_'),
            icon: Icon(Icons.warning, color: Colors.redAccent));
      } else {
        Get.snackbar('Resultado del análisis', '',
            snackPosition: SnackPosition.TOP,
            messageText: Text(
                'Tu dispositivo NO tuvo contacto con el diagnosticado, sigue cuidandote.',
                style: TextStyle(color: Colors.white)),
            colorText: Colors.white,
            icon: Icon(Icons.check, color: Colors.greenAccent));
      }
    });
  }
}
