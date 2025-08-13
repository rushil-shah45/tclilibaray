import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.height,
    this.width,
    this.textInputType,
    this.textInputAction,
    this.onChanged,
    required this.controller,
    this.hintText,
    this.maxLines = 1,
    this.minLines,
    this.textAlignVertical,
    this.hintStyle,
    this.borderSide,
    this.borderRadius,
    this.obscureText = false,
    this.isReadOnly = false
  });

  final TextEditingController controller;
  final double? height, width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? minLines;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final bool obscureText;
  final bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Get.height / 14,
      width: width ?? Get.width,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: textInputType,
        textAlignVertical: textAlignVertical,
        textInputAction: textInputAction,
        onChanged: onChanged,
        obscureText: obscureText,
        readOnly: isReadOnly ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(top: 25.h, left: 10.w, right: 10.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: borderSide ?? BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: borderSide ?? BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: borderSide ?? BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
