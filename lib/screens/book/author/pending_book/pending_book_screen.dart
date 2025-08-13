import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'controller/pending_book_controller.dart';

class PendingBookScreen extends StatelessWidget {
  const PendingBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingBookController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: Text(
              "Pending Books",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getPendingBook();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              height: 40,
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(0.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width,
                          child: ListView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 65,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(0.r),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : controller.booksModel == null
                      ? CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                              SliverPadding(
                                  padding: EdgeInsets.only(top: 140.h),
                                  sliver: const SliverToBoxAdapter(
                                      child: CustomGifImage()))
                            ])
                      : CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    border:
                                        Border.all(color: Colors.grey.shade100),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          "Book",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 60.w),
                                      SizedBox(
                                        child: Text(
                                          "Publisher",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 30.w),
                                      SizedBox(
                                        child: Text(
                                          "ISBN",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 35.w),
                                      SizedBox(
                                        child: Text(
                                          "Action",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount:
                                      controller.booksModel!.books.length,
                                  (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(Routes.bookDetailsScreen,
                                        //     arguments: controller
                                        //         .booksModel!.books[index].id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade100),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: Get.width / 3.8,
                                              child: Text(
                                                "${controller.booksModel?.books[index].title}",
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              width: Get.width / 5.8,
                                              child: Text(
                                                "${controller.booksModel?.books[index].publisher}",
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              width: Get.width / 3.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${controller.booksModel?.books[index].isbn10}",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Visibility(
                                                    visible: controller
                                                            .booksModel
                                                            ?.books[index]
                                                            .isbn13 !=
                                                        '',
                                                    child: Text(
                                                      "${controller.booksModel?.books[index].isbn13}",
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              width: Get.width / 9,
                                              child: PopupMenuButton(
                                                onSelected: (value) {
                                                  final val = controller
                                                      .booksModel?.books[index];
                                                  controller.onMenuItemSelected(
                                                      value as int,
                                                      controller.booksModel!
                                                          .books[index].id,
                                                      val, context);
                                                },
                                                offset: Offset(Get.width / 10,
                                                    Get.height / 20),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(8.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0)),
                                                ),
                                                itemBuilder: (ctx) => [
                                                  _buildPopupMenuItem('View',
                                                      Options.view.index),
                                                  _buildPopupMenuItem('Edit',
                                                      Options.edit.index),
                                                  _buildPopupMenuItem('Delete',
                                                      Options.delete.index),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(height: 16.h),
                            ),
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
