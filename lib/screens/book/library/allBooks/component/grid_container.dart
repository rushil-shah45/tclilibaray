import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class GridContainer extends StatefulWidget {
  const GridContainer({super.key, required this.controller});

  final AllBooksController controller;

  @override
  State<GridContainer> createState() => _GridContainerState();
}

class _GridContainerState extends State<GridContainer> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: Obx(
        () => MultiSliver(
          children: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: Get.height / 2.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 14),
              delegate: SliverChildBuilderDelegate(
                childCount: widget.controller.booksModel.value.length,
                (BuildContext context, int index) {
                  final model = widget.controller.booksModel.value[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        if (model.isBorrowed == true) {
                          Get.toNamed(Routes.bookDetailsScreen,
                              arguments: [model.id, "" ]);
                        } else {
                          Get.snackbar('Warning',
                              'First, you need to borrow this book.');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: CustomImage(
                                      path:
                                          "${RemoteUrls.rootUrl}${model.thumb}",
                                      height: Get.height / 3.65,
                                      width: Get.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  top: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                height: Get.height / 19.80,
                                                width: Get.width / 10.5,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryGrayColor),
                                                child: const Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {
                                              if (model.isBorrowed == true) {
                                                print("WLOCK FILE 1");
                                                Get.toNamed(
                                                    Routes.bookDetailsScreen,
                                                    arguments: [model.id, ""]);
                                              } else {
                                                print("WLOCK FILE 2");
                                                Get.snackbar('Warning',
                                                    'First, you need to borrow this book.');
                                              }
                                            },
                                            child: Container(
                                              height: Get.height / 19.80,
                                              width: Get.width / 10.5,
                                              decoration: const BoxDecoration(
                                                color: primaryGrayColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {
                                              widget.controller
                                                  .storeFavouriteBook(model.id)
                                                  .then((value) {
                                                setState(() {
                                                  widget.controller
                                                      .getAllBooksData();
                                                });
                                              });
                                            },
                                            child: Container(
                                                height: Get.height / 19.80,
                                                width: Get.width / 10.5,
                                                decoration: const BoxDecoration(
                                                    color: primaryGrayColor,
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                    Icons.favorite_outlined,
                                                    color: model.isFavorite ==
                                                            false
                                                        ? Colors.white
                                                        : Colors.red)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: Get.height / 9.2,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.r),
                                      bottomRight: Radius.circular(10.r))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.title,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 5.h),
                                  CustomBtn(
                                    height: Get.height / 16,
                                    width: Get.width / 5,
                                    text: model.isBorrowed == false
                                        ? 'Borrow'
                                        : 'Borrowed',
                                    size: 14.sp,
                                    color: model.isBorrowed == false
                                        ? primaryColor
                                        : blackGrayColor,
                                    callback: () {
                                      if (model.isBorrowed == false) {
                                        widget.controller
                                            .storeBorrowBook(model.id)
                                            .then((value) {
                                          setState(() {
                                            widget.controller.getAllBooksData();
                                          });
                                        });
                                      } else {}
                                    },
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: widget.controller.gettingMoreData.value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
