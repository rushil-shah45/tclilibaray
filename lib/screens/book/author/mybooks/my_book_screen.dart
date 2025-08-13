import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/components/my_book_shimmer.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'controller/my_book_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

class MyBookScreen extends StatefulWidget {
  const MyBookScreen({super.key});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  MyBookController controller = Get.find();

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.getMyBook();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              "My Books",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getMyBook();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? const MyBookShimmer()
                  : CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16.w, right: 16.w, bottom: 10.h),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomBtn(
                                    width: Get.width / 5,
                                    text: "Add New",
                                    callback: () {
                                      Get.toNamed(Routes.addBookScreen);
                                    },
                                  ),
                                ),
                              ),
                              controller.booksModel == null
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          border: Border.all(
                                              color: Colors.grey.shade100),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 60.w),
                                            SizedBox(
                                              child: Text(
                                                "Publisher",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 30.w),
                                            SizedBox(
                                              child: Text(
                                                "ISBN",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 35.w),
                                            SizedBox(
                                              child: Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              controller.booksModel == null
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 110.h),
                                      child: const CustomGifImage(),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: SizedBox(
                                        width: Get.width,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .booksModel!.books.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.bookDetailsScreen,
                                                    arguments: [controller
                                                        .booksModel!
                                                        .books[index]
                                                        .id, ""]);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.grey.shade100,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width / 3.8,
                                                      child: Text(
                                                        "${controller.booksModel?.books[index].title}",
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    SizedBox(
                                                      width: Get.width / 5.8,
                                                      child: Text(
                                                        "${controller.booksModel?.books[index].publisher}",
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    SizedBox(
                                                      width: Get.width / 3.7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          controller
                                                                      .booksModel
                                                                      ?.books[
                                                                          index]
                                                                      .isbn10 ==
                                                                  ''
                                                              ? const Text(
                                                                  "N/A")
                                                              : Text(
                                                                  "${controller.booksModel?.books[index].isbn10}",
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                          controller
                                                                      .booksModel
                                                                      ?.books[
                                                                          index]
                                                                      .isbn13 ==
                                                                  ''
                                                              ? const Text(
                                                                  "N/A")
                                                              : Text(
                                                                  "${controller.booksModel?.books[index].isbn13}",
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    SizedBox(
                                                      width: Get.width / 9,
                                                      child: PopupMenuButton(
                                                        onSelected: (value) {
                                                          final val = controller
                                                              .booksModel
                                                              ?.books[index];
                                                          controller
                                                              .onMenuItemSelected(
                                                                  value as int,
                                                                  controller
                                                                      .booksModel!
                                                                      .books[
                                                                          index]
                                                                      .id,
                                                                  val,
                                                                  context);
                                                        },
                                                        offset: Offset(
                                                            Get.width / 10,
                                                            Get.height / 20),
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    8.0),
                                                            topRight:
                                                                Radius.circular(
                                                              8.0,
                                                            ),
                                                          ),
                                                        ),
                                                        itemBuilder: (ctx) => [
                                                          _buildPopupMenuItem(
                                                              'Analytics',
                                                              Options.analytics
                                                                  .index),
                                                          _buildPopupMenuItem(
                                                              'Edit',
                                                              Options
                                                                  .edit.index),
                                                          _buildPopupMenuItem(
                                                              'Delete',
                                                              Options.delete
                                                                  .index),
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
                              SizedBox(height: 16.h),
                            ],
                          ),
                        )
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
