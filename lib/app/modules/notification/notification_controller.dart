import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final DBRepository _dbRepository = Get.put<DBRepository>(DBRepository());
  final HomeController _homeController =
      Get.put<HomeController>(HomeController());
  bool _loading = false;

  get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    update(['notification']);
  }

  void deleteNotifications() async {
    setLoading = true;
    final res = await _dbRepository.deleteAllNotifications();

    if (res != null) {
      _homeController.notifications = [];
      Get.snackbar('Notificaciones eliminadas', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text('Las notificaciones fueron eliminadas con éxito.',
              style: TextStyle(color: Colors.white)),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          icon: Icon(Icons.check, color: Colors.greenAccent));
    }

    setLoading = false;
    update(['notification', 'home']);
  }
}
