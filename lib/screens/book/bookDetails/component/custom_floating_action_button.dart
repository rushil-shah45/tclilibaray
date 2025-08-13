import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_cover.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

import 'bookfx/src/book_controller.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final int pageCount;
  final List<Uint8List> images;
  final BookController controller;

  const CustomFloatingActionButton({
    super.key,
    required this.child,
    required this.isLoading,
    required this.pageCount,
    required this.images,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      margin: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          TextEditingController newPage = TextEditingController();
          showDialog(
            context: context,
            barrierDismissible: true,
            // curve: Curves.easeInOut,
            // alignment: Alignment.center,
            // animationType: DialogTransitionType.scale,
            // duration: const Duration(milliseconds: 500),
            builder: (BuildContext context) {
              return Center(
                child: AlertDialog(
                  titlePadding: EdgeInsets.only(
                      top: 16.h, left: 16.w, right: 16.w, bottom: 10.h),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Find by page number",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.clear_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.only(
                      top: 10.h, left: 16.w, right: 16.w, bottom: 16.h),
                  content: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "Go to...",
                      hintStyle: greySmallTextStyle,
                      contentPadding: const EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    controller: newPage,
                    style: greySmallTextStyle,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomBtn(
                          width: Get.width / 4.w,
                          text: "Search",
                          callback: () async {
                            if (newPage.text.isNotEmpty) {
                              if (int.parse(newPage.text) < pageCount ||
                                  int.parse(newPage.text) < images.length) {
                                controller.goTo(int.parse(newPage.text));
                                pageNo.value = int.parse(newPage.text);
                              } else {
                                Utils.showSnackBar(
                                  context,
                                  "Available pages are $pageCount",
                                );
                              }
                              Get.back();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        heroTag: null,
        tooltip: 'Go To',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading
                ? Row(
                    children: [
                      LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.white70, size: 20),
                    ],
                  )
                : child,
            const SizedBox(
              width: 10,
            ),
            ValueListenableBuilder(
              valueListenable: pageNo,
              builder: (context, value, child) {
                return Text(
                  "${pageNo.value + 1}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
            Text(
              "/${images.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        // Text(
        //   "Pages loaded ${images.length}",
        //   style: TextStyle(fontSize: 10.sp),
        // ),
      ),
    );
  }
}
