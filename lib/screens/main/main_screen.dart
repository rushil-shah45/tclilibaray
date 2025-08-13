import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/screens/main/component/my_bottom_navbar.dart';
import '../setting/repository/setting_repository.dart';
import 'controller/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    return GetBuilder<MainController>(
      builder: (controller) {
        return PopScope(
          onPopInvoked: (a) => a?{}:controller.onBackPressed(context),
          child: Scaffold(
            body: PageView(
              controller: controller.bottomPageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.screenList.map((widget) {
                return KeyedSubtree(key: UniqueKey(), child: widget);
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: redColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const CustomImage(
                path: "assets/images/home.png",
                height: 28,
                color: Colors.white,
              ),
              onPressed: () {
                controller.changePage(0);
                controller.bottomPageController.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBody: true,
            bottomNavigationBar: MyBottomNavigationBar(
              controller: controller,
              pageController: controller.bottomPageController,
              pageIndex: controller.pageIndex.value,
            ),
          ),
        );
      },
    );
  }
}
