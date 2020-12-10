import 'package:covid_app/app/data/models/Contact.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {

  List<Contact> _contacts = List<Contact>();

  List<Contact> get contacts => _contacts;

  set setContacts(List<Contact> value) {
    _contacts = value;
    update(['contact']);
  }

  @override
  void onInit() {
    super.onInit();
    setContacts = [
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 16, id: 1.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 28, id: 2.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 55, id: 3.toString()),
       Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 16, id: 1.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 28, id: 2.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 55, id: 3.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 16, id: 1.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 28, id: 2.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 55, id: 3.toString()),
       Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 16, id: 1.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 28, id: 2.toString()),
      Contact(createdAt: DateTime.now().millisecondsSinceEpoch, duration: 55, id: 3.toString()),
    ];
  }

}
