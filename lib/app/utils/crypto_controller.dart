import 'dart:convert';
import 'dart:typed_data';

import 'package:covid_app/app/data/models/EphId.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:encrypt/encrypt.dart';
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
}
