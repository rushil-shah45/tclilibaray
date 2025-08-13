import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/club_details_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/club_setting.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/discussion_card.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/join_request_members.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/component/member_card.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/controller/club_details_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import '../../../core/values/colors.dart';

class ClubDetailsScreen extends StatefulWidget {
  const ClubDetailsScreen({super.key});

  @override
  State<ClubDetailsScreen> createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClubDetailsController>(
      builder: (controller) {
        return DefaultTabController(
          initialIndex: controller.selectedMenu.value,
          length: controller.tabMenuList.length,
          animationDuration: const Duration(milliseconds: 800),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
              title: Text(
                "Club Details",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                return controller.getClubDetails();
              },
              child: Obx(
                () => controller.isLoading.value
                    ? const ClubDetailsShimmers()
                    : CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              height: Get.height / 4,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: controller.clubDetailsModel!.club
                                          .covarPhoto.isNotEmpty
                                      ? CachedNetworkImageProvider(
                                          "${RemoteUrls.rootUrl}${controller.clubDetailsModel?.club.covarPhoto}")
                                      : const AssetImage(
                                              'assets/images/no_image.png')
                                          as ImageProvider<Object>,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ///Left image
                                  SizedBox(
                                    height: Get.height / 8,
                                    width: Get.height / 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 16,
                                              offset: const Offset(0, 0)),
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 16,
                                              offset: const Offset(0, 0)),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        child: CustomImage(
                                          path:
                                              "${RemoteUrls.rootUrl}${controller.clubDetailsModel?.club.profilePhoto}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///Right Club Info
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          "${controller.clubDetailsModel?.club.title}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: controller.clubDetailsModel!
                                                    .club.covarPhoto.isNotEmpty
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${controller.clubDetailsModel?.memberCount} ${controller.clubDetailsModel?.memberCount.compareTo(1) == 0 ? 'Member' : 'Members'}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: controller.clubDetailsModel!
                                                  .club.covarPhoto.isNotEmpty
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      controller.clubDetailsModel!.isOwner ==
                                              true
                                          ? Visibility(
                                              visible: controller
                                                      .clubDetailsModel!
                                                      .pendingMembersCount !=
                                                  0,
                                              child: Text(
                                                "${controller.clubDetailsModel!.pendingMembersCount.toString()} Pending Request",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: controller
                                                          .clubDetailsModel!
                                                          .club
                                                          .covarPhoto
                                                          .isNotEmpty
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : Obx(
                                              () => controller.clubDetailsModel!
                                                          .flag ==
                                                      1
                                                  ? controller.isJoinClubLoading
                                                          .value
                                                      ? SizedBox(
                                                          width:
                                                              Get.width / 4.5,
                                                          child: const Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                        )
                                                      : CustomBtn(
                                                          width: Get.width / 5,
                                                          text: "Join Club",
                                                          callback: () {
                                                            customDialog(
                                                                context,
                                                                'Do you want to join the club?',
                                                                'Yes',
                                                                'Cancel', () {
                                                              Navigator.pop(
                                                                  context);

                                                            }, () {
                                                              Navigator.pop(
                                                                  context);
                                                              controller.joinClub(
                                                                  "${controller.clubDetailsModel?.club.id}");
                                                            });
                                                          },
                                                        )
                                                  : controller
                                                          .isLeaveClubLoading
                                                          .value
                                                      ? SizedBox(
                                                          width: controller
                                                                      .clubDetailsModel!
                                                                      .flag ==
                                                                  3
                                                              ? Get.width / 2.3
                                                              : Get.width / 4.5,
                                                          child: const Center(
                                                              child:
                                                                  CircularProgressIndicator()))
                                                      : CustomBtn(
                                                          width: controller
                                                                      .clubDetailsModel!
                                                                      .flag ==
                                                                  3
                                                              ? Get.width / 2.3
                                                              : Get.width / 4.5,
                                                          text: controller
                                                                      .clubDetailsModel!
                                                                      .flag ==
                                                                  3
                                                              ? "X Cancel Join Request"
                                                              : "Leave Club",
                                                          callback: () {
                                                            customDialog(
                                                                context,
                                                                controller.clubDetailsModel!
                                                                            .flag ==
                                                                        3
                                                                    ? 'Are you sure to cancel joining the club?'
                                                                    : 'Are you sure to leave the club?',
                                                                'Yes',
                                                                'Cancel', () {
                                                              Navigator.pop(
                                                                  context);

                                                            }, () {
                                                              Navigator.pop(
                                                                  context);
                                                              controller.leaveClub(
                                                                  "${controller.clubDetailsModel!.club.id}");
                                                            });
                                                          },
                                                        ),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(12),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                color: AppColors.f4f4f4,
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${controller.clubDetailsModel!.memberCount.toString()} ${controller.clubDetailsModel!.memberCount.toString().compareTo('1') == 0 ? 'Member' : 'Members'}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    controller.clubDetailsModel!.members.isEmpty
                                        ? Center(
                                            child: Text(
                                            "No available member",
                                            style: TextStyle(fontSize: 14.sp),
                                          ))
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            itemCount: controller
                                                .clubDetailsModel!
                                                .members
                                                .length,
                                            itemBuilder: (context, index) {
                                              return MembersCard(
                                                controller: controller,
                                                member: controller
                                                    .clubDetailsModel!
                                                    .members[index],
                                              );
                                            },
                                          ),
                                    SizedBox(height: 5.h),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///details body
                          SliverPadding(
                            padding: const EdgeInsets.all(12),
                            sliver: SliverToBoxAdapter(
                              child: TabBar(
                                dividerColor: Colors.black,
                                unselectedLabelColor: Colors.black,
                                labelColor: whiteColor,
                                indicatorColor: redColor,
                                padding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: TextStyle(fontSize: 14.sp),
                                indicator: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.r),
                                      topRight: Radius.circular(5.r)),
                                ),
                                tabs: List.generate(
                                  controller.clubDetailsModel?.flag == 1 ||
                                          controller.clubDetailsModel?.flag == 3
                                      ? 1
                                      : controller.clubDetailsModel?.flag ==
                                                  2 &&
                                              !controller
                                                  .clubDetailsModel!.isOwner
                                          ? 3
                                          : controller.tabMenuList.length,
                                  (index) => Tab(
                                    text: controller.tabMenuList[index],
                                  ),
                                ),
                                onTap: (value) {
                                  controller.tabMenuChange(value);
                                },
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverToBoxAdapter(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                if (controller.selectedMenu.value == 0) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About Club",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Html(
                                        data:
                                            "${controller.clubDetailsModel?.club.aboutClub}",
                                      ),
                                      Text(
                                        "Rules",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Html(
                                        data:
                                            "${controller.clubDetailsModel?.club.rulesClub}",
                                        // style: {
                                        //   "html":
                                        //       Style(fontSize: FontSize(14.sp)),
                                        //   "p": Style(fontSize: FontSize(14.sp)),
                                        // },
                                      ),
                                    ],
                                  );
                                } else if (controller.selectedMenu.value == 1) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: CustomBtn(
                                          width: Get.width / 3.2,
                                          text: 'Start new topics',
                                          callback: () {
                                            Get.toNamed(
                                                Routes.clubNewTopicScreen,
                                                arguments: controller
                                                    .clubDetailsModel?.club.id);
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      const Divider(color: Colors.grey),
                                      controller.clubDetailsModel!.posts.isEmpty
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 40.h),
                                              child: const Center(
                                                  child: CustomGifImage()),
                                            )
                                          : SizedBox(
                                              width: Get.width,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: const ScrollPhysics(),
                                                itemCount: controller
                                                    .clubDetailsModel!
                                                    .posts
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return DiscussionCard(
                                                    controller: controller,
                                                    post: controller
                                                        .clubDetailsModel!
                                                        .posts[index],
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  );
                                } else if (controller.selectedMenu.value == 2) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Visibility(
                                        visible: controller
                                                .clubDetailsModel!.isOwner ==
                                            true,
                                        child: Container(
                                          child: controller.clubDetailsModel!
                                                  .pendingMembers.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No join requests are currently available.",
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Membership Join Requests",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: greenColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          " (${controller.clubDetailsModel?.pendingMembersCount})",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    SizedBox(
                                                      width: Get.width,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const ScrollPhysics(),
                                                        itemCount: controller
                                                            .clubDetailsModel!
                                                            .pendingMembers
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return JoinRequestList(
                                                            controller:
                                                                controller,
                                                            member: controller
                                                                .clubDetailsModel!
                                                                .pendingMembers[index],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      controller
                                              .clubDetailsModel!.members.isEmpty
                                          ? Center(
                                              child: Text(
                                                "No available member",
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "All Members",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        const Color(0xff18A2B8),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                SizedBox(
                                                  width: Get.width,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const ScrollPhysics(),
                                                    itemCount: controller
                                                        .clubDetailsModel!
                                                        .members
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return MembersCard(
                                                        controller: controller,
                                                        member: controller
                                                            .clubDetailsModel!
                                                            .members[index],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                    ],
                                  );
                                }
                                return ClubSetting(controller: controller);
                              }),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
