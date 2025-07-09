import 'package:get/get.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/favoris_controller.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/search_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavorisController());
    Get.lazyPut(() => RechercheController());
  }
}
