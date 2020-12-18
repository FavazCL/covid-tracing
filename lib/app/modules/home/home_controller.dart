import 'package:covid_app/app/data/models/Contact.dart';
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
    getAllContacts();
  }

  void getAllContacts() async {
    contacts = await _dbRepository.getAllContacts();
    update(['home']);
  }

  void deleteContacts() async {
    await _dbRepository.deleteAllContacts();
  }

}