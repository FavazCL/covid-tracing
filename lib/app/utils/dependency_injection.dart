import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<FirebaseFirestore>(FirebaseFirestore.instance);
  }
}