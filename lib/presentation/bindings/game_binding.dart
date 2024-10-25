import 'package:catogotchi/presentation/controllers/game_controllers.dart';
import 'package:get/get.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    // Menginisialisasi GameController
    Get.lazyPut<GameController>(() => GameController());
  }
}
