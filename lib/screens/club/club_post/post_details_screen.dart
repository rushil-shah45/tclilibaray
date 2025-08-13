import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/components/comment_card.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/components/post_details_shimmers.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/controllers/post_details_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

import '../../../core/utils/custom_image.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostDetailsController postDetailsController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            return postDetailsController.getPostDetails();
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                sliver: SliverToBoxAdapter(
                  child: Obx(
                    () => postDetailsController.isLoading.value
                        ? const PostDetailsShimmer()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postDetailsController.postDetailsModel!.title,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.clubDetails,
                                      arguments: postDetailsController
                                          .postDetailsModel!.club.id);
                                },
                                child: Text(
                                  postDetailsController
                                      .postDetailsModel!.club.title,
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomBtn(
                                      width: Get.width / 3.4,
                                      text: 'Start new topic',
                                      callback: () {
                                        Get.toNamed(Routes.clubNewTopicScreen,
                                            arguments: postDetailsController
                                                .postDetailsModel!.club.id);
                                      }),
                                  SizedBox(width: 10.w),
                                  CustomBtn(
                                      width: Get.width / 7,
                                      text: 'Reply',
                                      callback: () {}),
                                  SizedBox(width: 10.w),
                                  CustomBtn(
                                      width: Get.width / 7,
                                      text: 'Back',
                                      callback: () {
                                        Get.back();
                                      }),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Visibility(
                                visible: postDetailsController.postDetailsModel!.image != '',
                                child: Column(
                                  children: [
                                    SizedBox(height: 5.h),
                                    CustomImage(
                                      height: Get.height / 3.h,
                                      width: Get.width.w,
                                      fit: BoxFit.cover,
                                      path: "${RemoteUrls.rootUrl}${postDetailsController.postDetailsModel!.image}",
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Html(
                                  data: postDetailsController
                                      .postDetailsModel!.descriptions),
                              postDetailsController
                                      .postDetailsModel!.comments.isEmpty
                                  ? Center(
                                      child: Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: Text(
                                        "No comments available",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: postDetailsController
                                          .postDetailsModel!.comments.length,
                                      itemBuilder: (context, index) {
                                        return CommentCard(
                                          comment: postDetailsController
                                              .postDetailsModel!
                                              .comments[index],
                                        );
                                      }),
                              Row(
                                children: [
                                  const Icon(Icons.reply_all, size: 24),
                                  SizedBox(width: 10.w),
                                  Text(
                                    postDetailsController
                                        .postDetailsModel!.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Column(
                                  children: [
                                    ToolBar(
                                        toolBarColor:
                                            Colors.grey.withOpacity(0.2),
                                        activeIconColor: primaryColor,
                                        padding: const EdgeInsets.all(8),
                                        iconSize: 20,
                                        controller:
                                            postDetailsController.controller),
                                    QuillHtmlEditor(
                                      controller:
                                          postDetailsController.controller,
                                      isEnabled: true,
                                      minHeight: Get.height / 3.5,
                                      hintTextAlign: TextAlign.start,
                                      padding:
                                          EdgeInsets.only(left: 10.w, top: 5.h),
                                      hintTextPadding: EdgeInsets.zero,
                                      loadingBuilder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Obx(
                                () => postDetailsController.isPosting.value
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Center(
                                        child: CustomBtn(
                                          width: Get.width / 7,
                                          text: 'Send',
                                          callback: () {
                                            postDetailsController.postReply();
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
