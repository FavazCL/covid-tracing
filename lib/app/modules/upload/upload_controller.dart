import 'package:covid_app/app/data/repositories/remote/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  final ContactRepository _contactRepository = Get.find<ContactRepository>();
  bool _delete = false;

  get delete => _delete;

  set setDelete(bool value) {
    _delete = value;
    update(['upload']);
  } 

  void uploadContacts() async {
    final res = await _contactRepository.uploadContacts();

    if (res) {
      Get.snackbar('Contactos compartidos con éxito', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'La información de tus contactos fue compartida con el equipo de estudios, gracias.'),
          icon: Icon(Icons.check, color: Colors.greenAccent));
    } else {
      Get.snackbar('Error al compartir', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'Ha ocurrido un error al compartir los contactos, intenta nuevamente.'),
          icon: Icon(Icons.warning, color: Colors.redAccent));
    }
  }
}
