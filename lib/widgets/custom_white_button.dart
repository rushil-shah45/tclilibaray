import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/constants.dart';

class CustomWhiteButton extends StatelessWidget {
  const CustomWhiteButton(
      {super.key, required this.callback, required this.buttonName});
  final Function() callback;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 55.h,
        width: 250.h,
        decoration: BoxDecoration(
            color: primaryColor,
            // border: Border.all(color: primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(15.r)),
        child: Center(
          child: Text(
            buttonName,
            style: primaryLargeWhiteTextStyle,
          ),
        ),
      ),
    );
  }
}
