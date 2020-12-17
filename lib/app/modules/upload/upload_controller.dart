import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/data/repositories/remote/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  final ContactRepository _contactRepository = Get.find<ContactRepository>();
  final DBRepository _dbRepository = Get.put<DBRepository>(DBRepository());
  List<Contact> _contacts = List<Contact>();
  bool _delete = false;
  bool _loading = false;

  get delete => _delete;
  get loading => _loading;

  set setDelete(bool value) {
    _delete = value;
    update(['upload']);
  }

  set setLoading(bool value) {
    _loading = value;
    update(['upload']);
  }

  void uploadContacts() async {
    setLoading = true;
    List<Contact> tmpContact = await _dbRepository.getAllContacts();
    print('pre-pre: $tmpContact');
    _contacts = tmpContact
        .where((Contact contact) => contact.shared == 1).toList();
    print('ahahaha: $_contacts');
    final res = await _contactRepository.uploadContacts(contacts: _contacts);
    print('1: $res');
    if (res) {
      print('2');
      Get.snackbar('Contactos compartidos con éxito', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'La información de tus contactos fue compartida con el equipo de estudios, gracias.'),
          icon: Icon(Icons.check, color: Colors.greenAccent));
      if (delete) {
        await _dbRepository.deleteAllContacts();
      } else {
        for (Contact contact in _contacts) {
          contact.shared = 1;
          await _dbRepository.updateContact(contact: contact);
        }
      }
    } else {
      Get.snackbar('Error al compartir', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'Ha ocurrido un error al compartir los contactos, intenta nuevamente.'),
          icon: Icon(Icons.warning, color: Colors.redAccent));
    }
    setLoading = false;
  }
}
