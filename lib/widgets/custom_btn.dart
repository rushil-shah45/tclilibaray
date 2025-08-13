import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      this.size = 14,
      this.height,
      this.width,
      required this.text,
      this.gradient,
      this.color = primaryColor,
      required this.callback,
      this.color2});

  final double? height, width, size;
  final String text;
  final Gradient? gradient;
  final Color color;
  final Color? color2;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
        height: height ?? Get.height / 24,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color,
          gradient: gradient,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color2 ?? Colors.white,
            fontSize: size,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
