import 'package:covid_app/app/data/models/Handshake.dart';
import 'package:covid_app/app/data/providers/local/db_api.dart';
import 'package:get/get.dart';

class DBRepository {
  final DBAPI _dbapi = Get.find<DBAPI>();

  Future<dynamic> getAllHandshakes() => _dbapi.getAllHandshakes();
  Future<dynamic> getHandshakeById({int id}) => _dbapi.getHandshakeById(id: id);
  Future<dynamic> updateHandshake({Handshake handshake}) => _dbapi.updateHandshake(handshake: handshake);
  Future<dynamic> deleteHandshake({int id}) => _dbapi.deleteHandshake(id: id);
  Future<dynamic> deleteAllHandshakes() => _dbapi.deleteAllHandshakes();
}