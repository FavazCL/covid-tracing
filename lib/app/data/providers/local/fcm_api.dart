import 'dart:convert';
import 'dart:typed_data';

import 'package:covid_app/app/data/models/Report.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMApi {
  final FirebaseMessaging _messaging = Get.find<FirebaseMessaging>();
  final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());
  final SharedPrefsController _prefs =
      Get.put<SharedPrefsController>(SharedPrefsController());
  Report _report;

  void configure() {
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        try {
          // 0. Parseamos los string a objectos.
          message['data']['ephId'] = json.decode(message['data']['ephId']);
          message['data']['reportDate'] =
              int.parse(message['data']['reportDate']);
          _report = Report.fromJson(message['data']);

          // 1. Veritificar que el ephId recibido no sea del emisor.
          var emisor = false;
          var decode = json.decode(_prefs.ephids);
          for (var ephId in decode) {
            if (_report.ephId.data.toString() == ephId['data'].toString()) {
              emisor = !emisor;
              break;
            }
          }
          print('emisor: $emisor');

          if (!emisor) {
            // 2. Caso que no sea del emisor, se empieza la verificación.
            _cryptoController.compareEphIds(_report);
          }
        } catch (e) {
          print('Error on onMessage: $e');
        }
      },
      onBackgroundMessage: null,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void fcmSubscribe() {
    _messaging.subscribeToTopic('reports');
  }

  void fcmUnSubscribe() {
    _messaging.unsubscribeFromTopic('reports');
  }
}
