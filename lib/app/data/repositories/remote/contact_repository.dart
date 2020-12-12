import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/providers/remote/contact_api.dart';
import 'package:get/get.dart';

class ContactRepository {
  final ContactAPI _contactAPI = Get.find<ContactAPI>();

  Future<bool> uploadContacts({List<Contact> contacts}) =>
      _contactAPI.uploadContacts(contacts: contacts);
}
