import 'package:get/get.dart';
import 'package:linos_dictionary/controllers/words_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WordsController>(WordsController());
  }
}
