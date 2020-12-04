import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/app/data/models/Report.dart';

class ReportAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createReport({Report report}) async {
    try {
      final res = await _firestore.collection('reports').add(report.toJson());

      if (res.id != null) {
        return true;
      }

      return false;
    } catch (e) {
      print('Error on createReport: $e');
      return false;
    }
  }
}