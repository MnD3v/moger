import 'package:get/get.dart';
import 'package:moger_web/scr/presentation/controllers_bindings/controllers/mes_annonces_controller.dart';

class MesAnnoncesBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => MesAnnoncesController());
  }
}
