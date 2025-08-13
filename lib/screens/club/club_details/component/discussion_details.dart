import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/widgets/custom_image.dart';

class DiscussionDetails extends StatelessWidget {
  const DiscussionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Topic Name",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        reverse: true,
        slivers: [
          MultiSliver(children: [
            SliverPadding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, top: 16.h, bottom: 65),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 5,
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                                        decoration: BoxDecoration(
                                          // color: const Color(0xFFD2D6DE),
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.h, horizontal: 8.w),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: const CustomImage(
                                                  path: "",
                                                  height: 35,
                                                  width: 35,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rony",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey.shade700,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "07 Mar 2024",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey.shade700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Text("Message details")
                                                // Visibility(
                                                //   visible: controller
                                                //       .ticketDetails[
                                                //   index]
                                                //       .fileNameUploaded !=
                                                //       null,
                                                //   child: Column(
                                                //     children: [
                                                //       SizedBox(
                                                //           height:
                                                //           5.h),
                                                //       GestureDetector(
                                                //         onTap:
                                                //             () {
                                                //           viewAttachmentDialog(
                                                //               context,
                                                //               controller.ticketDetails[index],
                                                //               controller);
                                                //         },
                                                //         child:
                                                //         Container(
                                                //           padding: EdgeInsets.only(
                                                //               left: 5.w,
                                                //               right: 5.w),
                                                //           decoration:
                                                //           BoxDecoration(
                                                //             color:
                                                //             Colors.white,
                                                //             borderRadius:
                                                //             BorderRadius.circular(8.r),
                                                //           ),
                                                //           child:
                                                //           const Text(
                                                //             'View Attachment',
                                                //             style:
                                                //             TextStyle(
                                                //               color: Colors.black,
                                                //               fontWeight: FontWeight.w500,
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       SizedBox(
                                                //           height:
                                                //           5.h),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
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
      bottomSheet: Container(
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
                // controller: controller.messageCtrl,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                onFieldSubmitted: (value) {
                  if (value != '') {
                    // controller.userTicketReply().then((value) {
                    //   if (controller.attachment.value.existsSync()) {
                    //     controller.attachment.value.deleteSync();
                    //     controller.attachedLength.value = "0";
                    //   }
                    // });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Send reply",
                  hintStyle: const TextStyle(fontSize: 14),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    // controller.result =
                    // await FilePicker.platform.pickFiles();
                    // if (controller.result != null) {
                    //   controller.setFile(
                    //       File(controller.result!.files.single.path!));
                    //   controller.attachedLength.value =
                    //   "${controller.result?.files.length}";
                    // } else {}
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
                          "0",
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
                // controller.userTicketReply().then((value) {
                //   if (controller.attachment.value.existsSync()) {
                //     controller.attachment.value.deleteSync();
                //     controller.attachedLength.value = "0";
                //   }
                // });
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
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
