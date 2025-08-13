// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../core/utils/constants.dart';
//
// class CustomPasswordField extends StatelessWidget {
//   const CustomPasswordField({
//     super.key,
//     this.textInputAction,
//     required this.textEditingController,
//     this.callback,
//     required this.text,
//     required this.obscureText,
//     required this.toggle,
//     // this.keyboardType
//   });
//
//   final TextEditingController textEditingController;
//   // final TextInputType? keyboardType;
//   final String? Function(String?)? callback;
//   final String text;
//   final bool obscureText;
//   final Function() toggle;
//   final TextInputAction? textInputAction;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: Get.height / 14,
//       width: Get.width,
//       child: TextFormField(
//         controller: textEditingController,
//         validator: callback,
//         // keyboardType: keyboardType ?? TextInputType.text,
//         textInputAction: textInputAction ?? TextInputAction.next,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           suffixIcon: GestureDetector(
//             onTap: toggle,
//             child: obscureText
//                 ? const Icon(
//                     Icons.visibility_off,
//                     color: Colors.black87,
//                   )
//                 : const Icon(
//                     Icons.visibility,
//                     color: Colors.black87,
//                   ),
//           ),
//           filled: true,
//           fillColor: secondaryColor,
//           contentPadding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
//           hintText: text,
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: primaryColor, width: 2),
//               borderRadius: BorderRadius.circular(8)),
//           enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: secondaryColor, width: 0),
//               borderRadius: BorderRadius.circular(8)),
//         ),
//       ),
//     );
//   }
// }
