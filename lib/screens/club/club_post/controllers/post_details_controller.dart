import 'package:get/get.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/models/post_details_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class PostDetailsController extends GetxController {
  final SettingsRepository settingRepository;
  final LoginController loginController;

  PostDetailsController(this.settingRepository, this.loginController);

  // QuillEditorController controller = QuillEditorController();
  QuillEditorController controller = QuillEditorController();
  PostDetailsModel? postDetailsModel;
  RxBool isLoading = false.obs;
  RxBool isPosting = false.obs;
  int id = 0;
  var token;

  @override
  void onInit() {
    super.onInit();
    getToken();
    id = Get.arguments;
    getPostDetails();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getPostDetails() async {
    isLoading(true);
    final result = await settingRepository.getPostDetails(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      print(error.message);
      isLoading(false);
    }, (data) async {
      postDetailsModel = data;
      isLoading(false);
    });
  }

  void postReply() async {
    isPosting(true);
    String? text = await controller.getText();
    Map<String, dynamic> body = {
      'club_post_id': id.toString(),
      'comments': text.trim(),
    };

    final result = await settingRepository.postReply(
        loginController.userInfo?.accessToken ?? token, body);
    result.fold((error) {
      print(error.message);
      Get.snackbar('Warning', error.message);
      isPosting(false);
    }, (data) async {
      if (data) {
        controller.clear();
        getPostDetails();
      }
      isPosting(false);
    });
  }
}
