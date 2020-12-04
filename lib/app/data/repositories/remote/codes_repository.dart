import 'package:covid_app/app/data/models/Code.dart';
import 'package:covid_app/app/data/providers/remote/codes_api.dart';
import 'package:get/get.dart';

class CodesRepository {
  final CodesAPI _codesAPI = Get.find<CodesAPI>();

  Future<bool> updateCode({Code code}) => _codesAPI.updateCode(code: code);
}