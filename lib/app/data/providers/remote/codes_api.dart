import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/app/data/models/Code.dart';

class CodesAPI {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updateCode({Code code}) async {
    try {
      final res = await _firestore
          .collection('codes')
          .limit(1)
          .where('value', isEqualTo: code.value)
          .get();

      if (res.size == 1) {
        final code = Code.fromDocumentSnapshot(res.docs[0]);

        if (code.available) {
          code.available = false;
          await _firestore
              .collection('codes')
              .doc(code.id)
              .update(code.toJson());
          return true;
        }
        return false;
      }

      return false;
    } catch (e) {
      print('Error on createReport: $e');
      return false;
    }
  }
}
