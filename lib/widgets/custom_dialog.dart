import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';

customDialog(
    BuildContext context,
    String title,
    String subTitle,
    String posBtnTitle,
    String negBtnTitle,
    Function() posCallback,
    Function() negCallback) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: pageBackgroundColor,
        child: SizedBox(
          height: Get.height / 3.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width / 20, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width / 20),
                child: Text(
                  subTitle,
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width / 10, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: posCallback,
                      child: Container(
                        height: Get.height / 18,
                        width: Get.width / 4.5,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          posBtnTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    GestureDetector(
                      onTap: negCallback,
                      child: Container(
                        height: Get.height / 18,
                        width: Get.width / 4.5,
                        decoration: BoxDecoration(
                          color: primColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          negBtnTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      );
    },
  );
}
