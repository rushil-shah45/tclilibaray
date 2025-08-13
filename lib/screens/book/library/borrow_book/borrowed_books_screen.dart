import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/component/grid_borrowed_container.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/component/grid_issued_container.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/controller/borrowed_book_controller.dart';

class BorrowedBookScreen extends StatefulWidget {
  const BorrowedBookScreen({super.key});

  @override
  State<BorrowedBookScreen> createState() => _BorrowedBookScreenState();
}

class _BorrowedBookScreenState extends State<BorrowedBookScreen> {
  // final ScrollController scrollController = ScrollController();
  // BorrowedBookController controller = Get.find();
  //
  // void _scroll() {
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     controller.loadMoreFiles();
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(_scroll);
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BorrowedBookController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              controller.mainController.userProfileModel?.roleId == 1
                  ? "Borrowed Books"
                  : controller.mainController.userProfileModel?.roleId == 2
                      ? ""
                      : "Issued Books",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getBorrowedBooks();
            },
            child: controller.mainController.userProfileModel?.roleId == 1
                ? Obx(
                    () => controller.isLoading.value
                        ? SizedBox(
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: Get.height / 2.5,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 6,
                                  crossAxisSpacing: 14,
                                ),
                                itemCount: 8,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade400,
                                      highlightColor: Colors.grey.shade300,
                                      child: Container(
                                        height: Get.height / 2.5,
                                        width: Get.width / 2.5,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : controller.borrowedModel.value.isEmpty
                            ? CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                    SliverPadding(
                                        padding: EdgeInsets.only(top: 140.h),
                                        sliver: const SliverToBoxAdapter(
                                            child: CustomGifImage()))
                                  ])
                            : CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  GridBorrowedContainer(controller: controller),
                                  SliverToBoxAdapter(
                                    child: SizedBox(height: 10.h),
                                  ),
                                ],
                              ),
                  )
                : controller.mainController.userProfileModel?.roleId == 3
                    ? Obx(
                        () => controller.isLoading.value
                            ? SizedBox(
                                width: Get.width,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: Get.height / 2.5,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 14,
                                    ),
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade400,
                                          highlightColor: Colors.grey.shade300,
                                          child: Container(
                                            height: Get.height / 2.5,
                                            width: Get.width / 2.5,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : controller.issuedModel.value.isEmpty
                                ? CustomScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    slivers: [
                                        SliverPadding(
                                            padding:
                                                EdgeInsets.only(top: 140.h),
                                            sliver: const SliverToBoxAdapter(
                                                child: CustomGifImage()))
                                      ])
                                : CustomScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    slivers: [
                                      GridIssuedContainer(
                                          controller: controller),
                                      SliverToBoxAdapter(
                                          child: SizedBox(height: 10.h)),
                                    ],
                                  ),
                      )
                    : const SizedBox(),
          ),
        );
      },
    );
  }
}
