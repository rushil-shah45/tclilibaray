import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

class TermConditionController extends GetxController {
  final MainController mainController;
  bool isTablet = Get.width >= 600;

  TermConditionController(this.mainController);
}
