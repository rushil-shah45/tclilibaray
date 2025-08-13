import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/screens/notification/component/notification_card.dart';
import 'package:tcllibraryapp_develop/screens/notification/controller/notification_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: Text(
              "Notification",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getNotifications();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: 20,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: controller.isTablet
                                ? EdgeInsets.only(left: 10.w, right: 10.w)
                                : EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : controller.notificationList.value.isEmpty
                      ? CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                              SliverPadding(
                                  padding: EdgeInsets.only(top: 130.h),
                                  sliver: const SliverToBoxAdapter(
                                      child: CustomGifImage()))
                            ])
                      : CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverPadding(
                              padding: controller.isTablet
                                  ? EdgeInsets.symmetric(horizontal: 10.w)
                                  : EdgeInsets.symmetric(horizontal: 15.w),
                              sliver: SliverList.separated(
                                itemCount:
                                    controller.notificationList.value.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 16.h);
                                },
                                itemBuilder: (context, index) {
                                  return NotificationCart(
                                      controller: controller,
                                      notificationModel: controller
                                          .notificationList.value[index]);
                                },
                              ),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}
