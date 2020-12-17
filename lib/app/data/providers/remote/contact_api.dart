import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/app/data/models/Contact.dart';

class ContactAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadContacts({List<Contact> contacts}) async {
    try {
      for (Contact contact in contacts) {
        await _firestore.collection('contacts').add(contact.toJson());
      }
      return true;
    } catch (e) {
      print('Error on createReport: $e');
      return false;
    }
  }
}
