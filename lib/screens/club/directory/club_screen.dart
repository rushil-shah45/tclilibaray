import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/component/club_shimmers.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/component/my_club_card.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/controllers/club_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'component/club_card.dart';
import 'component/post_card.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClubController clubController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title:  Text("Clubs",  style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),),centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return clubController.getClub();
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Club Directory',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomBtn(
                      width: Get.width / 4.3,
                      text: 'Create Club',
                      size: clubController.isTablet ? 9.sp : 14,
                      callback: () {
                        if (clubController
                                .mainController.userProfileModel?.plan.club ==
                            "2") {
                          Get.snackbar('Warning',
                              'Please upgrade your package to create club');
                          Get.toNamed(Routes.pricing);
                        } else {
                          Get.toNamed(Routes.createClubScreen);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              sliver: SliverToBoxAdapter(
                child: Obx(
                  () => clubController.isLoading.value
                      ? const ClubShimmers()
                      : Column(
                          children: [
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: Get.height / 16,
                                    width: Get.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r)),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'All Clubs',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      child: PopupMenuButton(
                                        icon: Material(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: const Color(0xff28A745),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 3.h,
                                                bottom: 3.h,
                                                left: 5.w),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  clubController
                                                      .selectedValue.value,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        tooltip: "Sort By",
                                        itemBuilder: (context) =>
                                            <PopupMenuEntry>[
                                          ...List.generate(
                                              clubController.sortByList.length,
                                              (index) {
                                            return PopupMenuItem(
                                              value: index,
                                              onTap: () {
                                                clubController
                                                    .changeMenuItem(index);
                                              },
                                              child: Text(
                                                clubController.sortByList[index]
                                                    ["name"],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: clubController.club.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ClubCard(
                                              clubController: clubController,
                                              allClub:
                                                  clubController.club[index]),
                                          Visibility(
                                            visible: index <
                                                clubController.club.length - 1,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width / 25),
                                              child: const Divider(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                children: [
                                  Container(
                                      height: Get.height / 16,
                                      width: Get.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.4),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            topRight: Radius.circular(10.r)),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text('My Clubs',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold))),
                                  Visibility(
                                    child: clubController
                                            .clubModel!.myClubs.isEmpty
                                        ? CustomGifImage(height: Get.height / 7)
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: clubController
                                                .clubModel!.myClubs.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  MyClubCard(
                                                    clubController:
                                                        clubController,
                                                    myClub: clubController
                                                        .clubModel!
                                                        .myClubs[index],
                                                    isOwner: clubController
                                                        .clubModel!
                                                        .myClubs[index]
                                                        .isOwner!,
                                                  ),
                                                  Visibility(
                                                    visible: index <
                                                        clubController
                                                                .clubModel!
                                                                .myClubs
                                                                .length -
                                                            1,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            Get.width / 25,
                                                      ),
                                                      child: const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                children: [
                                  Container(
                                    height: Get.height / 16,
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r)),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Recent activity in my clubs ',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold)),
                                        Visibility(
                                          visible: clubController
                                                  .clubModel!.postsCount !=
                                              0,
                                          child: Text(
                                              '(${clubController.clubModel!.postsCount})',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    child: clubController
                                            .clubModel!.posts.isEmpty
                                        ? CustomGifImage(height: Get.height / 7)
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: clubController
                                                .clubModel!.posts.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  PostCard(
                                                      clubController:
                                                          clubController,
                                                      post: clubController
                                                          .clubModel!
                                                          .posts[index]),
                                                  Visibility(
                                                      visible: index !=
                                                          clubController
                                                                  .clubModel!
                                                                  .posts
                                                                  .length -
                                                              1,
                                                      child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      Get.width /
                                                                          25),
                                                          child: const Divider(
                                                              color: Colors
                                                                  .grey))),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
