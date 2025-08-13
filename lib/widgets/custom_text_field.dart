import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    this.callback,
    required this.text,
    this.isObscure = false,
    this.textInputAction,
    this.keyboardType,
    this.widget,
    this.color,
    this.borderColor,
  });

  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? callback;
  final String text;
  final Color? color;
  final Color? borderColor;
  final bool isObscure;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 14,
      width: Get.width,
      child: TextFormField(
        controller: textEditingController,
        validator: callback,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next,
        enableSuggestions: true,
        obscureText: isObscure,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: color ?? secondaryColor,
          suffixIcon: widget,
          contentPadding: EdgeInsets.only(top: 25.h, left: 10.w, right: 10.w),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ??  primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(10.r)),
        ),
      ),
    );
  }
}
