import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/audio_manager.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_cover.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_details_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/bookfx/youtube_video_book.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/video_manager.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';

import '../../../widgets/custom_btn.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  // late WebViewController webViewController;

  // BookDetailsController controller = Get.find();
//   Future<void> secureScreen() async {
//     await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
//   }
//
//
//   Future<void> blockOIS()async{
//     try{
//       await ScreenProtector.preventScreenshotOn();
//     }catch(e){
// print(e);
//     }
//
//   }
//
//   Future<void> unbLockOIS()async{
//     await ScreenProtector.preventScreenshotOff();
//   }
  @override
  void initState() {
    super.initState();
    // secureScreen();
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(
    //       'https://www.youtube.com/watch?v=lNQJNImBsKY'));
  }

  @override
  void dispose() {
    // unbLockOIS();
    // //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasSubmittedReview = false;

    return GetBuilder<BookDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Book Details"),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                return controller.getBookDetails();
              },
              child: Obx(
                () => controller.isLoading.value
                    ? const BookDetailsShimmer()
                    : controller.bookDetails.value == null
                        ? const Center(
                            child: Text(
                              "First, you need to borrow this book",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.only(top: 5.h),
                                sliver: SliverToBoxAdapter(
                                  child: controller.bookDetails.value?.book.fileType == 'pdf'
                                      ? BookCover(controller: controller, isBookForSale: false, bookForSaleTitle: "", onBookForSaleChange: (value) {})
                                      : controller.bookDetails.value?.book.fileType == 'audio'
                                          ? AudioPlayerWidget(controller: controller)
                                          : controller.bookDetails.value?.book.fileType == 'video'
                                              ? Container(
                                                  width: Get.width,
                                                  color: Colors.grey.shade200,
                                                  child: VideoManager(controller: controller),
                                                )
                                              : controller.bookDetails.value?.book.fileType == 'url'
                                                  ? YoutubeVideoBookWidget(
                                                      youtubeVideoLink: controller.bookDetails.value?.book.fileDir ?? "",
                                                    )
                                                  : const Text(""),
                                ),
                              ),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Text(
                                                controller.bookDetails.value!.book.title,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Text(
                                                "Authors: ${controller.bookDetails.value!.book.author?.name} ${controller.bookDetails.value!.book.author?.lastName}",
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Text(
                                                "Publisher: ${controller.bookDetails.value!.book.publisher}",
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Text(
                                                "Publish Years: ${controller.bookDetails.value!.book.publisherYear}",
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null && controller.bookDetails.value!.book.edition != ''
                                            ? Text(
                                                "Edition: ${controller.bookDetails.value!.book.edition}",
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null && controller.bookDetails.value!.book.pages != 0
                                            ? Text(
                                                "Pages: ${controller.bookDetails.value!.book.pages}",
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null && controller.bookDetails.value!.book.isbn10 != ''
                                            ? Text(
                                                "ISBN10: ${controller.bookDetails.value!.book.isbn10}",
                                                style: greyTextStyle,
                                              )
                                            : const Text("N/A", style: TextStyle(color: Color(0xff808080), fontSize: 16)),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null && controller.bookDetails.value!.book.isbn13 != ''
                                            ? Text(
                                                "ISBN13: ${controller.bookDetails.value!.book.isbn13}",
                                                style: greyTextStyle,
                                              )
                                            : const Text("ISBN13: N/A", style: TextStyle(color: Color(0xff808080), fontSize: 16)),
                                      ),
                                      Visibility(
                                        visible: controller.bookDetails.value != null && controller.bookDetails.value!.user.roleId == '2',
                                        child: Obx(
                                          () => Text(
                                            "Status: ${controller.getBookStatus(controller.bookDetails.value!)}",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Text("Ratings : ", style: greyTextStyle),
                                                  RatingBar(
                                                    allowHalfRating: true,
                                                    initialRating: double.parse(controller.bookDetails.value!.avgRating),
                                                    maxRating: 5,
                                                    itemSize: 15.0,
                                                    ignoreGestures: true,
                                                    ratingWidget: RatingWidget(
                                                      full: const Icon(Icons.star, color: Colors.amber),
                                                      half: const Icon(Icons.star, color: Colors.amber),
                                                      empty: const Icon(Icons.star_border, color: Colors.amber),
                                                    ),
                                                    onRatingUpdate: (double value) {},
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(controller.bookDetails.value!.avgRating, style: greyTextStyle),
                                                  Text(" (${controller.bookDetails.value!.totalReview} Reviews)", style: greyTextStyle),
                                                ],
                                              )
                                            : const SizedBox(),
                                      ),
                                      SizedBox(height: 10.h),
                                      Obx(
                                        () => controller.bookDetails.value != null
                                            ? Text(
                                                controller.bookDetails.value!.book.description,
                                                style: greyTextStyle,
                                              )
                                            : const SizedBox(),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              ),
                              // Additional widgets handling reviews and submit button follow a similar pattern.
                            ],
                          ),
              )),
        );
      },
    );
  }

  reviewEdit(BuildContext context, String review, String rating, String bookId, BookDetailsController controller) {
    controller.reviewTextController.text = review;
    showDialog(
      context: context,
      barrierDismissible: true,
      // curve: Curves.easeInOut,
      // alignment: Alignment.center,
      // animationType: DialogTransitionType.scale,
      // duration: const Duration(milliseconds: 500),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.green,
          child: Container(
            height: Get.height / 2.7,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55.h,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFF17a2b8), borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r))),
                  child: Row(
                    //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => controller.isLoading.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  height: 35.h,
                                  width: 35.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: CachedNetworkImage(
                                  imageUrl: "${RemoteUrls.rootUrl}${controller.bookDetails.value!.user.image}",
                                  height: 35.h,
                                  width: 35.h,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Image.asset(
                                    KImages.avatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      Obx(
                        () => Expanded(
                          //  flex: 8,
                          child: Text(
                            " ${controller.bookDetails.value!.user.name} ${controller.bookDetails.value!.user.lastName}",
                            style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: RatingBar(
                    initialRating: double.parse(rating),
                    maxRating: 5,
                    itemSize: 30.0,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.amber),
                      half: const Icon(Icons.star, color: Colors.amber),
                      empty: const Icon(Icons.star_border, color: Colors.amber),
                    ),
                    onRatingUpdate: (double value) {
                      controller.ratingChange(value);
                    },
                  ),

                  // RatingBar.builder(
                  //   itemCount: 5,
                  //   initialRating: double.parse(rating),
                  //   direction: Axis.horizontal,
                  //   itemSize: 30.0,
                  //   itemBuilder: (context, _) =>
                  //       const Icon(Icons.star, color: Colors.amber),
                  //   allowHalfRating: true,
                  //   onRatingUpdate: (rating) {
                  //     controller.ratingChange(rating);
                  //   },
                  // ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: TextFormField(
                    controller: controller.reviewTextController,
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                      hintText: "Write your comments",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => controller.ratingUpdateLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: CustomBtn(
                            width: Get.width / 5,
                            text: 'Submit',
                            callback: () {
                              controller.updateRating(bookId).then((value) {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
