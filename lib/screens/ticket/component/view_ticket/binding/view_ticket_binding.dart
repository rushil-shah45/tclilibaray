import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/controller/view_ticket_controller.dart';

class ViewTicketBinding extends Bindings {
  @override
  void dependencies() {
    // //
    Get.lazyPut(() => ViewTicketController(Get.find(), Get.find()));
  }
}
