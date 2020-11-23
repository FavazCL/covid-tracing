import 'dart:convert';

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
  EphId ephId = EphId();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    _getCurrentEphId();
  }

  void _getCurrentEphId() {
    if (prefs.ephids.isNullOrBlank) {
      _createEphId();
    } else {
      var decode = json.decode(prefs.ephids);
      ephId = EphId.fromJson(decode);
    }
  }


  void _createEphId() async {
    try {
      final secretKey = SecureRandom(16);
      final dateTime = DateTime.now().millisecondsSinceEpoch;

      ephId = EphId(createdAt: dateTime, data: secretKey.bytes);
      var encode = json.encode(ephId);

      prefs.ephids = encode.toString();

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
