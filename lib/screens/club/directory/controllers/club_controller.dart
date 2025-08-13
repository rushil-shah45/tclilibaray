import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/model/club_model.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class ClubController extends GetxController {
  final SettingsRepository settingRepository;
  final LoginController loginController;
  final MainController mainController;

  ClubController(
      this.settingRepository, this.loginController, this.mainController);

  RxBool isLoading = false.obs;
  var token;
  ClubModel? clubModel;
  RxList<Club> club = <Club>[].obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getClub();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getClub() async {
    isLoading(true);
    final result = await settingRepository.getClub(token);
    result.fold((error) {
      print(error.message);
      isLoading(false);
    }, (data) async {
      clubModel = data;
      club.value = data.allClubs;
      isLoading(false);
    });
  }

  RxString selectedValue = "Sort By".obs;
  final List sortByList = [
    {
      "name": "Latest Created",
      "id": "1",
    },
    {
      "name": "Oldest Clubs",
      "id": "2",
    },
    {
      "name": "Most Members",
      "id": "3",
    },
  ];

  Future<void> changeMenuItem(index) async {
    selectedValue.value = sortByList[index]["name"];

    if (selectedValue.value == "Oldest Clubs") {
      club.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (selectedValue.value == "Latest Created") {
      club.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    } else if (selectedValue.value == "Most Members") {
      club.sort((a, b) =>
          int.parse(b.membersCount).compareTo(int.parse(a.membersCount)));
    }
    update();
  }
}
