import 'package:get/get.dart';

class ReportController extends GetxController {

  bool _display = false;

  bool get display => _display;

  set setDisplay(bool value) {
    _display = value;
    update(['report']);
  }

}