import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar(
      {super.key,
      required this.height,
      required this.width,
      required this.image,
      this.network = false,
      this.file = false});

  final double height, width;
  final String image;
  final bool network, file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: redColor.withOpacity(.5), width: 4.w),
        borderRadius: BorderRadius.circular(90),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height),
        child: file
            ? Image.file(File(image), fit: BoxFit.cover)
            : network
                ? CachedNetworkImage(
                    height: height,
                    width: width,
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(KImages.avatar),
                  )
                : Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
