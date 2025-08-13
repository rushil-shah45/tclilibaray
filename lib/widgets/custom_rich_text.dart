import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, required this.title, this.star});

  final String title;
  final String? star;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text.rich(
        TextSpan(
          text: title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: star,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
