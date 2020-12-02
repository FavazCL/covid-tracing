import 'package:covid_app/app/data/models/Report.dart';
import 'package:covid_app/app/data/providers/remote/report_api.dart';
import 'package:get/get.dart';

class ReportRepository {
  final ReportAPI _reportAPI = Get.find<ReportAPI>();

  Future<bool> createReport({Report report}) => _reportAPI.createReport(report: report);
}