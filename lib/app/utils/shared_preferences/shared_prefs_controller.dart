import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController extends GetxController {
  static const String PERMISSIONS = 'PERMISSIONS';
  static const String INTRO = 'INTRO';
  static const String SEED = 'SEED';
  static const String EPHIDS = 'EPHIDS';

  static final SharedPrefsController _sharedPreferences =
      SharedPrefsController._internal();

  factory SharedPrefsController() {
    return _sharedPreferences;
  }

  SharedPrefsController._internal();
  SharedPreferences _prefs;

  Future<void> loadPreferences() async {
    _prefs = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }

  bool get permissions => _prefs.getBool(PERMISSIONS) ?? false;
  bool get intro => _prefs.getBool(INTRO) ?? false;
  String get seed => _prefs.getString(SEED) ?? '{}';
  String get ephids => _prefs.getString(EPHIDS) ?? '{}';

  set permissions(bool value) => _prefs.setBool(PERMISSIONS, value);
  set intro(bool value) => _prefs.setBool(INTRO, value);
  set seed(String value) => _prefs.setString(SEED, value);
  set ephids(String value) => _prefs.setString(EPHIDS, value);
}
