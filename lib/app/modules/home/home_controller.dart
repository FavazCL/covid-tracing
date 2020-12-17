import 'dart:convert';

import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/models/EphId.dart';
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final DBRepository _dbRepository = Get.put<DBRepository>(DBRepository());
  List<Contact> contacts = List<Contact>();
  List<Handshake> handshakes = List<Handshake>();

  @override
  void onInit() {
    super.onInit();
    //viewHandshakes();
    getAllContacts();
    //deleteContacts();
  }

  void getAllContacts() async {
    contacts = await _dbRepository.getAllContacts();
    update(['home']);
  }

  void deleteContacts() async {
    await _dbRepository.deleteAllContacts();
  }

  viewHandshakes() async {
    var res = await _dbRepository.getAllHandshakes();
     Contact _contact = Contact();
     _contact.createdAt = DateTime.now().millisecondsSinceEpoch;
     _contact.handshakes = res;
     _contact.duration = 15;
     _contact.shared = 0;

    var res2 = await _dbRepository.createContact(contact: _contact);
  }

}