import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/app/data/providers/local/handshakes_api.dart';
import 'package:covid_app/app/data/providers/local/seeds_api.dart';
import 'package:covid_app/app/data/repositories/local/handshakes_repository.dart';
import 'package:covid_app/app/data/repositories/local/seeds_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    // Providers
    Get.put<HandshakesAPI>(HandshakesAPI());
    Get.put<SeedsAPI>(SeedsAPI());

    // Repositories
    Get.put<HandshakesRepository>(HandshakesRepository());
    Get.put<SeedsRepository>(SeedsRepository());
  }
}