import 'package:covid_app/app/data/models/Contact.dart';
import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:covid_app/app/data/providers/local/db_api.dart';
import 'package:get/get.dart';

class DBRepository {
  final DBAPI _dbapi = Get.find<DBAPI>();

  Future<List<Handshake>> getAllHandshakes() => _dbapi.getAllHandshakes();
  Future<dynamic> getHandshakeById({int id}) => _dbapi.getHandshakeById(id: id);
  Future<dynamic> updateHandshake({Handshake handshake}) => _dbapi.updateHandshake(handshake: handshake);
  Future<dynamic> deleteHandshake({int id}) => _dbapi.deleteHandshake(id: id);
  Future<dynamic> deleteAllHandshakes() => _dbapi.deleteAllHandshakes();

  Future<dynamic> createContact({Contact contact}) => _dbapi.createContact(contact: contact);
  Future<List<Contact>> getAllContacts() => _dbapi.getAllContacts();
  Future<dynamic> updateContact({Contact contact}) => _dbapi.updateContact(contact: contact);  
  Future<dynamic> deleteAllContacts() => _dbapi.deleteAllContacts();
}