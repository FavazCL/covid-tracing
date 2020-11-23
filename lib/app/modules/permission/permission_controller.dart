import 'package:covid_app/app/global_widgets/error_dialog.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class PermissionController extends GetxController {
  final SharedPrefsController sharedPrefs = Get.put(SharedPrefsController());

  RxInt _page = 0.obs;
  bool _location = false;
  bool _notification = false;
  bool _batery = false;

  int get page => _page.value;
  bool get location => _location;
  bool get notification => _notification;
  bool get batery => _batery;

  void changeSlide(int value) {
    this._page.value = value;
  }

  Future<void> selectPermission(int type) async {
    print(type);
    switch (type) {
      case 0:
        await _getLocation();
        break;
      case 1:
        await _getNotification();
        break;
      case 2:
        await _getBattery();
        break;
      default:
        Get.dialog(ErrorDialog(
            title: 'Error de permisos',
            content: 'Ha ocurrido un error al solicitar los permisos, Intente nuevamente.',
            confirmation: 'Aceptar',
            onPressed: () => Get.back()));
    }
  }

  Future<void> _getLocation() async {
    this._location = await Permission.location.request().isGranted;

    if (this._location) {
      update(['permission']);
    }

    _verify();
  }

  Future<void> _getNotification() async {
    this._notification = await Permission.notification.request().isGranted;
    
    if (this._notification) {
      update(['permission']);
    }

    _verify();
  }

  Future<void> _getBattery() async {
    this._batery = await Permission.ignoreBatteryOptimizations.request().isGranted;

    if (this._batery) {
      update(['permission']);
    }

    _verify();
  }

  void _verify() {
    if (this._location && this._notification && this._batery) {
      sharedPrefs.permissions = true;
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
}
