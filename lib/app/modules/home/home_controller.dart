import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:covid_app/app/data/models/NotificationEphId.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final DBRepository _dbRepository = Get.put<DBRepository>(DBRepository());
  List<Contact> contacts = List<Contact>();
  List<Handshake> handshakes = List<Handshake>();
  List<NotificationEphId> notifications = List<NotificationEphId>();
  static const platform = const MethodChannel('dev/tracing');
  final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());

  @override
  void onInit() {
    super.onInit();
    getAllContacts();
    getAllNotifications();
  }

  void verifyBluetooth() async {
    var res = await platform.invokeMethod(
        'start', <String, dynamic>{'data': _cryptoController.ephId.data});

    if (res) {
      Get.toNamed(AppRoutes.SCAN);
    } else {
      Get.snackbar('Bluetooth desactivado', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'Ha ocurrido un error, debes encender el bluetooth para comenzar a emitir.',
              style: TextStyle(color: Colors.white)),
          colorText: Colors.white,
          icon: Icon(Icons.warning, color: Colors.redAccent));
    }
  }

  void getAllContacts() async {
    contacts = await _dbRepository.getAllContacts();
    print('con: $contacts');
    update(['home']);
  }

  void getAllNotifications() async {
    notifications = await _dbRepository.getAllNotifications();
    print('noti: $notifications');
    update(['home']);
  }

  void deleteContacts() async {
    await _dbRepository.deleteAllContacts();
  }
}
