import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/component/ticket_view_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/controller/view_ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/widgets/view_attachment_dialog.dart';

class ViewTicket extends GetView<ViewTicketController> {
  const ViewTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewTicketController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Obx(
              () => controller.isLoading.value
                  ? Container()
                  : Text(
                      "Ticket View - ${controller.ticketDetailsModelList.value!.subject}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getUserTicketDetails();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? const TicketViewShimmer()
                  : CustomScrollView(
                      reverse: true,
                      slivers: [
                        MultiSliver(children: [
                          SliverPadding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 16.h, bottom: 65),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: controller.ticketDetails.length,
                                (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: controller
                                                      .ticketDetails[index]
                                                      .fromAdmin ==
                                                  0
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: controller.ticketDetails[index]
                                                      .fromAdmin ==
                                                  0
                                              ? Text.rich(
                                                  TextSpan(
                                                      text: controller
                                                          .ticketDetails[index]
                                                          .user
                                                          .name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: const [
                                                        TextSpan(
                                                          text: '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ]),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.sp))
                                              : Text(
                                                  controller
                                                      .ticketDetails[index]
                                                      .admin
                                                      .name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          alignment: controller
                                                      .ticketDetails[index]
                                                      .fromAdmin ==
                                                  0
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment: controller
                                                        .ticketDetails[index]
                                                        .fromAdmin ==
                                                    0
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              controller.ticketDetails[index]
                                                          .fromAdmin ==
                                                      0
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      5.h),
                                                          alignment: controller
                                                                      .ticketDetails[
                                                                          index]
                                                                      .fromAdmin ==
                                                                  0
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .centerLeft,
                                                          child: Container(
                                                            constraints: BoxConstraints(
                                                                maxWidth: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fromAdmin ==
                                                                      0
                                                                  ? const Color(
                                                                      0xFF6C757D)
                                                                  : const Color(
                                                                      0xFFD2D6DE),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.h,
                                                                    horizontal:
                                                                        5.w),
                                                            // alignment: controller.ticketDetails[index].fromAdmin == 0
                                                            //     ? Alignment.centerRight
                                                            //     : Alignment.centerLeft,
                                                            child: Column(
                                                              crossAxisAlignment: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fromAdmin ==
                                                                      0
                                                                  ? CrossAxisAlignment
                                                                      .end
                                                                  : CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .ticketDetails[
                                                                          index]
                                                                      .message,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: controller.ticketDetails[index].fromAdmin ==
                                                                            0
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .grey
                                                                            .shade700,
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fileNameUploaded !=
                                                                      null,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              5.h),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          viewAttachmentDialog(
                                                                              context,
                                                                              controller.ticketDetails[index],
                                                                              controller);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              left: 5.w,
                                                                              right: 5.w),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.r),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            'View Attachment',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5.h),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2,
                                                              strokeAlign:
                                                                  BorderSide
                                                                      .strokeAlignOutside,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: CustomImage(
                                                              path:
                                                                  "${RemoteUrls.rootUrl}${controller.ticketDetails[index].user.image}",
                                                              height: 35,
                                                              width: 35,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2,
                                                                  strokeAlign:
                                                                      BorderSide
                                                                          .strokeAlignOutside)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: CustomImage(
                                                              path:
                                                                  "${RemoteUrls.rootUrl}${controller.ticketDetails[index].admin.image}",
                                                              height: 35,
                                                              width: 35,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      5.h),
                                                          alignment: controller
                                                                      .ticketDetails[
                                                                          index]
                                                                      .fromAdmin ==
                                                                  0
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .centerLeft,
                                                          child: Container(
                                                            constraints: BoxConstraints(
                                                                maxWidth: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fromAdmin ==
                                                                      0
                                                                  ? const Color(
                                                                      0xFF6C757D)
                                                                  : const Color(
                                                                      0xFFD2D6DE),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.h,
                                                                    horizontal:
                                                                        5.w),
                                                            child: Column(
                                                              crossAxisAlignment: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fromAdmin ==
                                                                      0
                                                                  ? CrossAxisAlignment
                                                                      .end
                                                                  : CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .ticketDetails[
                                                                          index]
                                                                      .message,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: controller.ticketDetails[index].fromAdmin ==
                                                                            0
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .grey
                                                                            .shade700,
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: controller
                                                                          .ticketDetails[
                                                                              index]
                                                                          .fileNameUploaded !=
                                                                      null,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              5.h),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          viewAttachmentDialog(
                                                                              context,
                                                                              controller.ticketDetails[index],
                                                                              controller);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              left: 5.w,
                                                                              right: 5.w),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.r),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            'View Attachment',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              5.h),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
            ),
          ),
          bottomSheet: Obx(
            () => Container(
              // height: AppBar().preferredSize.height,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ashColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 3,
                      offset: const Offset(0, -5))
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 48.h,
                    width: 268.h,
                    child: TextFormField(
                      controller: controller.messageCtrl,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      onFieldSubmitted: (value) {
                        if (value != '') {
                          controller.userTicketReply().then((value) {
                            if (controller.attachment.value.existsSync()) {
                              controller.attachment.value.deleteSync();
                              controller.attachedLength.value = "0";
                            }
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "reply ticket message",
                        hintStyle: const TextStyle(fontSize: 14),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          controller.result =
                              await FilePicker.platform.pickFiles();
                          if (controller.result != null) {
                            controller.setFile(
                                File(controller.result!.files.single.path!));
                            controller.attachedLength.value =
                                "${controller.result?.files.length}";
                          } else {}
                        },
                        child: Container(
                          height: 45.h,
                          width: 45.h,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.attachment,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            controller.attachedLength.value.compareTo('0') != 0,
                        child: Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: hexToColor(button5)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                controller.attachedLength.value,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      if (controller.messageCtrl.text.isNotEmpty) {
                        controller.userTicketReply().then((value) {
                          if (controller.attachment.value.existsSync()) {
                            controller.attachment.value.deleteSync();
                            controller.attachedLength.value = "0";
                          }
                        });
                      } else {
                        Get.snackbar("Warning", 'Please enter your message');
                      }
                    },
                    child: Container(
                      height: 45.h,
                      width: 45.h,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: controller.isSendBtnLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Center(
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
