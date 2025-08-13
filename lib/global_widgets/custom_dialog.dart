import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customDialog(BuildContext context, String title, String negBtnTitle,
    String posBtnTitle, Function() onPosCallback,  Function() onNegCallback,) {
  showDialog(
    context: context,
    barrierDismissible: true,
    // curve: Curves.easeInOut,
    // alignment: Alignment.center,
    // animationType: DialogTransitionType.scale,
    // duration: const Duration(milliseconds: 500),
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <Widget>[

        TextButton(
          onPressed: onNegCallback,
          child: Text(
            negBtnTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        TextButton(
          onPressed: onPosCallback,
          child: Text(
            posBtnTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
