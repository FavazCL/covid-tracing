import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_app/app/data/providers/local/handshakes_api.dart';
import 'package:covid_app/app/data/providers/local/seeds_api.dart';
import 'package:covid_app/app/data/providers/remote/codes_api.dart';
import 'package:covid_app/app/data/repositories/local/handshakes_repository.dart';
import 'package:covid_app/app/data/repositories/local/seeds_repository.dart';
import 'package:covid_app/app/data/repositories/remote/codes_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    // Providers
    Get.put<HandshakesAPI>(HandshakesAPI());
    Get.put<SeedsAPI>(SeedsAPI());
    Get.put<CodesAPI>(CodesAPI());

    // Repositories
    Get.put<HandshakesRepository>(HandshakesRepository());
    Get.put<SeedsRepository>(SeedsRepository());
    Get.put<CodesRepository>(CodesRepository());
  }
}