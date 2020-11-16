import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CryptoController extends GetxController {

  static const int EPHID_LENGTH = 16;
  static const String SEED = 'SEED_JSON';
  static const String EPHIDS = 'EPHIDS_JSON';
  static const String IVE = 'F0Wlnt0zTvcB6bHW';
  final SharedPrefsController prefs = Get.put<SharedPrefsController>(SharedPrefsController());
  
  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    // Verificar si existe una semilla
    _getSeed();
    // Verificar todos los EphId generados
    _getEphids();
    // Verificar si existe un EphId
    // Crear una semilla
    // Crear un EphId
    _createEphid();
  }

  void _getSeed() {
    print('Current seed: ${prefs.seed}');
  }

  void _getEphids() {
    print('Ephids generated: ${prefs.ephids}');
  }

  void _createEphid() async {
    try {
      final key = Key.fromLength(32);
      final iv = IV.fromUtf8(IVE);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encryptBytes([1,2], iv: iv);

      print('Ephid: ${encrypted.bytes}');
    } catch (e) {
      print('Error on createEphid: $e');
    }
  }
}