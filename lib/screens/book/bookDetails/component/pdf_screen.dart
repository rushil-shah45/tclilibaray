// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:pdf_image_renderer/pdf_image_renderer.dart';
// import 'package:tcllibraryapp_develop/data/remote_urls.dart';
// import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_cover.dart';
// import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/bookfx/src/book_controller.dart';
// import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/bookfx/src/book_fx.dart';
// import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/custom_floating_action_button.dart';
// import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';
// import 'package:zoom_widget/zoom_widget.dart';
// import '../../../../core/utils/constants.dart';
//
// class PdfScreen extends StatefulWidget {
//   final BookDetailsController controller;
//
//   const PdfScreen({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   State<PdfScreen> createState() => _PdfScreenState();
// }
//
// class _PdfScreenState extends State<PdfScreen> {
//   List<Uint8List> images = [];
//   int pageCount = 0;
//   bool isLoading = true;
//   bool isTimerRunning = false;
//   double timerSeconds = 10;
//   Timer? timer;
//   final _controller = BookController();
//
//   Future<void> renderAllPdfPages() async {
//     try {
//       final result = await PDFApi.loadNetwork(
//           "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}");
//       final pdf = PdfImageRendererPdf(path: result.path);
//       DateTime startTime = DateTime.now();
//       await pdf.open();
//       DateTime endTime = DateTime.now();
//       Duration executionTime = endTime.difference(startTime);
//       pageCount = await pdf.getPageCount();
//
//       await Future.forEach<int>(List.generate(pageCount, (index) => index),
//           (pageIndex) async {
//         await pdf.openPage(pageIndex: pageIndex);
//         final size = await pdf.getPageSize(pageIndex: pageIndex);
//         final img = await pdf.renderPage(
//           pageIndex: pageIndex,
//           x: 0,
//           y: 0,
//           width: size.width,
//           height: size.height,
//           scale: 1.5,
//           background: Colors.white,
//         );
//
//         await pdf.closePage(pageIndex: pageIndex);
//         setState(() {
//           images.add(img!);
//         });
//         print("Done 1");
//       });
//       pdf.close();
//       setState(() {
//         isLoading = false;
//       });
//     } catch (error) {
//       print("Error loading PDF: $error");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     renderAllPdfPages();
//     pageNo.value = 0;
//   }
//
//   @override
//   void initState() {
//     // print("asfdjhf ${widget.controller.bookDetails.value!.book.readingTime}");
//     // print("asfdjhf1 ${double.parse(widget.controller.bookDetails.value!.book.readingTime).toStringAsFixed(0)}");
//     // timerSeconds = double.parse(widget.controller.bookDetails.value!.book.readingTime).toDouble();
//     // //
//     super.initState();
//   }
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }
//
//   void startTimer() {
//     setState(() {
//       isTimerRunning = true;
//     });
//
//     timer = Timer.periodic(Duration(seconds: 10), (timer) {
//       setState(() {
//         if (timerSeconds > 0) {
//           timerSeconds--;
//         } else {
//           timer.cancel();
//           isTimerRunning = false;
//           setState(() {
//             timerSeconds = 10;
//             isAnimation = false;
//           });
//         }
//       });
//     });
//   }
//
//   ///PDF progress percentage value dispose method ee call user back and api calling done
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     calculateReadPercentage();
//     widget.controller.bookProgress();
//     if (timer != null) {
//       timer!.cancel();
//     }
//   }
//
//   ///Pdf progress percentage value calculation mechanism
//   void calculateReadPercentage() {
//     if (pageCount > 0) {
//       widget.controller.readPercentage =
//           ((_controller.currentIndex + 1) / pageCount * 100).toInt();
//     }
//   }
//
//   bool isAllPath = true;
//   bool isAnimation = false;
//   bool isNext = true;
//
//   Point<double> currentA = Point(0, 0);
//
//   @override
//   Widget build(BuildContext context) {
//     // String fileName = Uri.parse(
//     //         "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}")
//     //     .pathSegments
//     //     .last
//     //     .replaceAll('.pdf', '');
//
//     pageNo.value = _controller.currentIndex;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//           ),
//         ),
//         title: Obx(
//           () => Row(
//             children: [
//               Expanded(
//                 child: Text(widget.controller.bookDetails.value!.book.title,
//                     style: darkSmallTextStyle),
//               ),
//               Expanded(
//                 child: Visibility(
//                   visible: isTimerRunning,
//                   child: Text(
//                     formatDuration(Duration(seconds: timerSeconds.toInt())),
//                     style: const TextStyle(fontSize: 24),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ValueListenableBuilder(
//             valueListenable: pageNo,
//             builder: (context, value, child) {
//               return Text(
//                 "${pageNo.value + 1}",
//               );
//             },
//           ),
//           Text("/$pageCount"),
//           SizedBox(width: 16.w),
//         ],
//       ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return (images.isNotEmpty)
//               ? SizedBox(
//                   height: 750.h,
//                   width: 340.w,
//                   child: Zoom(
//                     enableScroll: true,
//                     initScale: 1,
//                     maxScale: 2,
//                     child: BookFx(
//                         controller: _controller,
//                         currentBgColor: Colors.black38,
//                         size: Size(MediaQuery.of(context).size.width, 750),
//                         pageCount: images.length,
//                         nextPage: (int index) {
//                           return SizedBox(
//                             width: 340.w,
//                             height: 750.h,
//                             child: Image.memory(images[index]),
//                           );
//                         },
//                         currentPage: (int index) {
//                           return SizedBox(
//                             width: 340.w,
//                             height: 750.h,
//                             child: Image.memory(images[index]),
//                           );
//                         },
//                         isAlPath: isAllPath,
//                         isAnimation: isAnimation,
//                         isNext: isNext,
//                         nextCallBack: (index) {
//                           // if (isTimerRunning) {
//                           //   return;
//                           // }
//                           //
//                           // isAllPath = false;
//                           // isAnimation = true;
//                           // isNext = true;
//                           // currentA = Point(
//                           //     MediaQuery.of(context).size.width - 50,
//                           //     MediaQuery.of(context).size.height - 50);
//                           // // _controller.forward(from: 0);
//                           // _controller.addListener(() {
//                           //   return;
//                           // });
//                           startTimer();
//                           setState(() {});
//
//                           //   if(isTimerRunning){
//                           //     _controller.currentIndex = pageNo.value;
//                           //     return;
//                           //   }
//                           //   startTimer();
//                         }),
//                   ),
//                 )
//               : SizedBox(
//                   child: Center(
//                     child: LoadingAnimationWidget.prograssiveDots(
//                         color: primaryColor, size: 60),
//                   ),
//                 );
//         },
//       ),
//       floatingActionButton: CustomFloatingActionButton(
//         isLoading: isLoading,
//         pageCount: pageCount,
//         images: images,
//         controller: _controller,
//         child: const Icon(
//           Icons.search,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
