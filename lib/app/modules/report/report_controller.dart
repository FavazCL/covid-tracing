import 'package:covid_app/app/data/models/Code.dart';
import 'package:covid_app/app/data/repositories/remote/codes_repository.dart';
import 'package:covid_app/app/data/repositories/remote/report_repository.dart';
import 'package:covid_app/app/modules/report/local_widgets/success_report.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final ReportRepository _reportRepository = Get.find<ReportRepository>();
  final CodesRepository _codesRepository = Get.find<CodesRepository>();
  Code _code = Code(id: null, available: null, value: null);
  bool _display = false;
  bool _loading = false;

  bool get display => _display;
  bool get loading => _loading;
  Code get code => _code;

  set setDisplay(bool value) {
    _display = value;
    update(['report']);
  }

  set setLoading(bool value) {
    _loading = value;
    update(['report']);
  }

  Future<void> reportCase() async {
    final res = await _codesRepository.updateCode(code: code);
    
    if (res) {
      Get.off(SuccessReportUI());
    }
  }

}
