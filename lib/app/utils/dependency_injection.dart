import 'package:covid_app/app/data/providers/local/db_api.dart';
import 'package:covid_app/app/data/providers/local/handshakes_api.dart';
import 'package:covid_app/app/data/providers/local/seeds_api.dart';
import 'package:covid_app/app/data/providers/remote/codes_api.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/data/repositories/local/handshakes_repository.dart';
import 'package:covid_app/app/data/repositories/local/seeds_repository.dart';
import 'package:covid_app/app/data/repositories/remote/codes_repository.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<CryptoController>(CryptoController());

    // Providers
    Get.put<HandshakesAPI>(HandshakesAPI());
    Get.put<SeedsAPI>(SeedsAPI());
    Get.put<CodesAPI>(CodesAPI());
    Get.put<DBAPI>(DBAPI.db);

    // Repositories
    Get.put<HandshakesRepository>(HandshakesRepository());
    Get.put<SeedsRepository>(SeedsRepository());
    Get.put<CodesRepository>(CodesRepository());
    Get.put<DBRepository>(DBRepository());
  }
}