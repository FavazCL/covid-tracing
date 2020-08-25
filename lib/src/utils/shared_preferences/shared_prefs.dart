import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends GetxController {
  static const String PERMISSIONS = 'PERMISSIONS';

  SharedPreferences _sharedPreferences;

  @override
  void onInit() {
    _loadPreferences();
    super.onInit();
  }

  Future<void> _loadPreferences() async {
    _sharedPreferences = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }

  bool get permissions => _sharedPreferences.getBool(PERMISSIONS) ?? false;
  set permissions(bool value) => _sharedPreferences.setBool(PERMISSIONS, value);
}
