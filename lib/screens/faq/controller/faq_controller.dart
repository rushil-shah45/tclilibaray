import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/faq/model/faq_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class FaqController extends GetxController {
  final SettingsRepository settingsRepository;

  FaqController(this.settingsRepository);

  List<FaqModel> faqModelList = [];
  List<RxBool> isClickToVisible = <RxBool>[].obs;
  RxBool isLoading = false.obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getFaqData();
  }

  Future<void> getFaqData() async {
    isLoading.value = true;
    final result = await settingsRepository.getFaqList();
    result.fold((error) {
      isLoading.value = false;
    }, (data) async {
      faqModelList = data;
      isClickToVisible = List.generate(
          faqModelList.length, (index) => index == 0 ? true.obs : false.obs);
      isLoading.value = false;
    });
  }

  closeAll(index) {
    isClickToVisible = List.generate(faqModelList.length, (index) => false.obs);
    update();
  }
}
