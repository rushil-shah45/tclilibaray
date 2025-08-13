import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.borderRadius,
      required this.onPressed,
      required this.backgroundColor,
      required this.icon});

  final double height;
  final double width;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius.r,
      ),
      child: Center(
        child: IconButton(
          alignment: Alignment.center,
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
