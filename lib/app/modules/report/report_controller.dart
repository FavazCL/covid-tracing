import 'package:covid_app/app/data/models/Code.dart';
import 'package:covid_app/app/data/models/Report.dart';
import 'package:covid_app/app/data/repositories/remote/codes_repository.dart';
import 'package:covid_app/app/data/repositories/remote/report_repository.dart';
import 'package:covid_app/app/modules/report/local_widgets/success_report.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final ReportRepository _reportRepository = Get.find<ReportRepository>();
  final CodesRepository _codesRepository = Get.find<CodesRepository>();
  final SharedPrefsController prefs =
      Get.put<SharedPrefsController>(SharedPrefsController());
  final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());
  Code _code = Code();
  Report _report = Report();
  bool _display = false;
  bool _loading = false;

  bool get display => _display;
  bool get loading => _loading;
  Code get code => _code;
  Report get report => _report;

  set setDisplay(bool value) {
    _display = value;
    update(['report']);
  }

  set setLoading(bool value) {
    _loading = value;
    update(['report']);
  }

  Future<void> reportCase() async {
    final resCode = await _codesRepository.updateCode(code: code);

    _report.reportDate = DateTime.now().millisecondsSinceEpoch;
    _report.ephId = _cryptoController.ephId;
    
    if (resCode) {
      final resReport = await _reportRepository.createReport(report: report);
      if (resReport) {
        Get.off(SuccessReportUI());
      } else {
        Get.snackbar('Error al reportar', '',
           snackPosition: SnackPosition.TOP,
           messageText: Text('El sistema no ha podido recibir su reporte, intente nuevamente.'),
           icon: Icon(Icons.warning, color: Colors.redAccent));
      }
    } else {
      Get.snackbar('Error al reportar', '',
           snackPosition: SnackPosition.TOP,
           messageText: Text('El código ingresado no es válido, intente nuevamente o solicite uno nuevo.'),
           icon: Icon(Icons.warning, color: Colors.redAccent));
    }

    setLoading = false;
  }
}
