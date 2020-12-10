import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SympthomController extends GetxController {
  void launchTEL() async {
    const tel = 'tel:+569 600 600 9000';
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }
}
