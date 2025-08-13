import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_details_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/book_details_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class BookDetailsForSaleScreen extends StatefulWidget {
  String bookForSaleTitle;
  int bookID;
  Function(bool callback) onBookForSaleChange;
  BookDetailsForSaleScreen(
      {super.key,
      required this.bookID,
      required this.bookForSaleTitle,
      required this.onBookForSaleChange});

  @override
  State<BookDetailsForSaleScreen> createState() =>
      _BookDetailsForSaleScreenState();
}

class _BookDetailsForSaleScreenState extends State<BookDetailsForSaleScreen> {
  var isLoading = false.obs;
  Rxn<BookDetailsModel> bookDetails = Rxn<BookDetailsModel>();

  Future<void> getBookDetails(int bookID) async {
    BookRepository bookRepository = Get.find<BookRepository>();
    var token = sharedPreferences.getString("uToken");
    isLoading.value = true;
    final result = await bookRepository.getBookDetails(token ?? '', bookID, 1);
    result.fold((error) {
      Get.snackbar('Warning', error.message);
      isLoading.value = false;
    }, (data) async {
      bookDetails.value = data;
      isLoading.value = false;
    });
  }

  @override
  void initState() {
    getBookDetails(widget.bookID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              return getBookDetails(widget.bookID);
            },
            child: Obx(
              () => isLoading.value
                  ? const BookDetailsShimmer()
                  : bookDetails.value == null
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
                                  child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //   return PdfScreen(controller: controller);
                                      // }));
                                    },
                                    child: Obx(
                                      () => bookDetails.value != null &&
                                              bookDetails
                                                  .value!.book.thumb.isNotEmpty
                                          ? isLoading.value
                                              ? Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade200,
                                                  child: Container(
                                                    height: Get.height / 4,
                                                    width: 200,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  child: SizedBox(
                                                    height: Get.height / 4,
                                                    width: 200,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${RemoteUrls.rootUrl}${bookDetails.value!.book.thumb}",
                                                      height: Get.height / 4,
                                                      width: 200,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )
                                          : Image.asset(
                                              'assets/images/default.jpeg',
                                              height: Get.height / 4,
                                              width: 200.h,
                                              fit: BoxFit.contain),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                        top: 10.h,
                                        bottom: 5.h),
                                    child: CustomBtn(
                                      width: Get.width / 1,
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          primaryColor,
                                          primColor
                                        ],
                                      ),
                                      text: widget.bookForSaleTitle,
                                      callback: () async {
                                        widget.onBookForSaleChange(true);
                                      },
                                    ),
                                  ),
                                ],
                              )),
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
                                      () => bookDetails.value != null
                                          ? Text(
                                              bookDetails.value!.book.title,
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
                                      () => bookDetails.value != null
                                          ? Text(
                                              "Authors: ${bookDetails.value!.book.author?.name} ${bookDetails.value!.book.author?.lastName}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null
                                          ? Text(
                                              "Publisher: ${bookDetails.value!.book.publisher}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null
                                          ? Text(
                                              "Publish Years: ${bookDetails.value!.book.publisherYear}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null &&
                                              bookDetails.value!.book.edition !=
                                                  ''
                                          ? Text(
                                              "Edition: ${bookDetails.value!.book.edition}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null &&
                                              bookDetails.value!.book.pages != 0
                                          ? Text(
                                              "Pages: ${bookDetails.value!.book.pages}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null &&
                                              bookDetails.value!.book.isbn10 !=
                                                  ''
                                          ? Text(
                                              "ISBN10: ${bookDetails.value!.book.isbn10}",
                                              style: greyTextStyle,
                                            )
                                          : const Text("N/A",
                                              style: TextStyle(
                                                  color: Color(0xff808080),
                                                  fontSize: 16)),
                                    ),
                                    Obx(
                                      () => bookDetails.value != null &&
                                              bookDetails.value!.book.isbn13 !=
                                                  ''
                                          ? Text(
                                              "ISBN13: ${bookDetails.value!.book.isbn13}",
                                              style: greyTextStyle,
                                            )
                                          : const Text("ISBN13: N/A",
                                              style: TextStyle(
                                                  color: Color(0xff808080),
                                                  fontSize: 16)),
                                    ),
                                    // Visibility(
                                    //   visible: bookDetails.value != null &&
                                    //       bookDetails.value!.user.roleId == '2',
                                    //   child: Obx(
                                    //         () => Text(
                                    //       "Status: ${getBookStatus(bookDetails.value!)}",
                                    //       style: TextStyle(
                                    //         fontSize: 14.sp,
                                    //         color: Colors.red,
                                    //         fontWeight: FontWeight.w600,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Obx(
                                      () => bookDetails.value != null
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text("Ratings : ",
                                                    style: greyTextStyle),
                                                RatingBar(
                                                  allowHalfRating: true,
                                                  initialRating: double.parse(
                                                      bookDetails
                                                          .value!.avgRating),
                                                  maxRating: 5,
                                                  itemSize: 15.0,
                                                  ignoreGestures: true,
                                                  ratingWidget: RatingWidget(
                                                    full: const Icon(Icons.star,
                                                        color: Colors.amber),
                                                    half: const Icon(Icons.star,
                                                        color: Colors.amber),
                                                    empty: const Icon(
                                                        Icons.star_border,
                                                        color: Colors.amber),
                                                  ),
                                                  onRatingUpdate:
                                                      (double value) {},
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                    bookDetails
                                                        .value!.avgRating,
                                                    style: greyTextStyle),
                                                Text(
                                                    " (${bookDetails.value!.totalReview} Reviews)",
                                                    style: greyTextStyle),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ),
                                    SizedBox(height: 10.h),
                                    Obx(
                                      () => bookDetails.value != null
                                          ? Text(
                                              bookDetails
                                                  .value!.book.description,
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
            )));
  }
}
