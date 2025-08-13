import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/models/post_details_model.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: Get.width / 14,
                  width: Get.width / 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 0)),
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 0)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: comment.user.image == null
                        ? Image.asset('assets/images/defaultUser.png')
                        : CachedNetworkImage(
                            imageUrl:
                                '${RemoteUrls.rootUrl}${comment.user.image}',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(comment.user.name),
                SizedBox(width: 20.w),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 5.w),
                    Text(DateFormat('dd MMMM yyyy').format(comment.createdAt)),
                  ],
                ),
              ],
            ),
            Html(
              data: comment.comments,
              style: {
                "body": Style(
                  textAlign: TextAlign.left,
                ),
                "img": Style(
                  height: Height(200.h),
                  width: Width(300.w),
                  alignment: Alignment.centerLeft
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
