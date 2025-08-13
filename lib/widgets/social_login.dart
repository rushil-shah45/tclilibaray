import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';

import '../core/utils/constants.dart';

class SocialLogin extends StatelessWidget {
  final LoginController loginController;

  const SocialLogin({super.key, required this.loginController});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 50.h,
        width: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
            color: googleColor,
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                image: AssetImage('assets/images/google.png'))),
      ),
      // Container(
      //   height: 50.h,
      //   width: 60.h,
      //   margin: EdgeInsets.symmetric(horizontal: 5.w),
      //   decoration: BoxDecoration(
      //     color: facebookColor,
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   child: const Icon(
      //     Icons.facebook,
      //     color: Colors.white,
      //     size: 32,
      //   ),
      // ),
    ]);
  }
}
