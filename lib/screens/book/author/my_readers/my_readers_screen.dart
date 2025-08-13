import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'components/reader_data.dart';
import 'controller/my_readers_controller.dart';

class MyReadersScreen extends StatefulWidget {
  const MyReadersScreen({super.key});

  @override
  State<MyReadersScreen> createState() => _MyReadersScreenState();
}

class _MyReadersScreenState extends State<MyReadersScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  MyReadersController controller = Get.find();

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.getMyReaders();
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
    return GetBuilder<MyReadersController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              "My Readers",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getMyReaders();
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
                  : CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              controller.readerModel.value.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            border: Border.all(
                                                color: Colors.grey.shade100)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text(
                                            //   "Book Cover",
                                            //   style: TextStyle(
                                            //       fontSize: controller.isTablet
                                            //           ? 10.sp
                                            //           : 12.sp,
                                            //       fontWeight: FontWeight.bold),
                                            // ),
                                            // SizedBox(width: 5.w),
                                            Text(
                                              "Book",
                                              style: TextStyle(
                                                  fontSize: controller.isTablet
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              "Reader Name",
                                              style: TextStyle(
                                                  fontSize: controller.isTablet
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "Total Views",
                                              style: TextStyle(
                                                  fontSize: controller.isTablet
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              controller.readerModel.value.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 140.h),
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
                                              .readerModel.value.length,
                                          itemBuilder: (context, index) {
                                            final readers = controller
                                                .readerModel.value[index];
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade100),
                                              ),
                                              child: ReaderData(
                                                  readersModel: readers),
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
}
