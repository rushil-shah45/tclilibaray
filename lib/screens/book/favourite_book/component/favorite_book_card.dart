import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';

class FavoriteBookCard extends StatelessWidget {
  const FavoriteBookCard({super.key, required this.favoriteBookModel});

  final Datum favoriteBookModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (favoriteBookModel.book.isBorrowed == true) {
          Get.toNamed(Routes.bookDetailsScreen,
              arguments: [favoriteBookModel.book.id, ""]);
        } else {
          Get.snackbar('Warning',
              'First, you need to borrow this book.');
        }
      },
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width / 3.6,
              child: Text(
                favoriteBookModel.book.title,
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 2.w),
            SizedBox(
              width: Get.width / 3.6,
              child: Text(
                favoriteBookModel.book.publisher,
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 2.w),
            SizedBox(
              width: Get.width / 3.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  favoriteBookModel.book.isbn10 == ''
                      ? const Text("N/A")
                      : Text(
                          favoriteBookModel.book.isbn10,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                  favoriteBookModel.book.isbn13 == ''
                      ? const Text("N/A")
                      : Text(
                          favoriteBookModel.book.isbn13,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
