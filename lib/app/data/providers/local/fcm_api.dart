import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMApi {
  final FirebaseMessaging _messaging = Get.find<FirebaseMessaging>();

  void configure() {
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
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
