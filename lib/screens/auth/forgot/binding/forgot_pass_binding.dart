import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/forgot/controller/forgot_pass_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => ForgotPasswordController(Get.find(), Get.find()));
    // //
  }
}
