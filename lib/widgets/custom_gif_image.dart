import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGifImage extends StatelessWidget {
  final double? height, width;

  const CustomGifImage({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height,
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/nodata.jpg",
        height: height,
        width: width,
      ),
    );
  }
}
