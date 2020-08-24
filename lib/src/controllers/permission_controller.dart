import 'package:covid_app/src/widgets/error_dialog.dart';
import 'package:get/get.dart';

class PermissionController extends GetxController {
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
    // TO DO..
  }

  Future<void> _getNotification() async {
    // TO DO..
  }

  Future<void> _getBattery() async {
    // TO DO..
  }

  void _verify() {
    if (_location && _notification && _batery) {
      print('Todos los permisos otorgados');
    }
  }
}
