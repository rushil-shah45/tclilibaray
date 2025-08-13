import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/book_cover.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';

import '../../../../core/utils/constants.dart';

class PdfScreen2 extends StatefulWidget {
  final BookDetailsController controller;

  const PdfScreen2({Key? key, required this.controller}) : super(key: key);

  @override
  State<PdfScreen2> createState() => _PdfScreen2State();
}

class _PdfScreen2State extends State<PdfScreen2> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  //List<Uint8List> images = [];
  int totalPageInPDF = 0;
  int currentPage = 1;
  //bool isLoading = true;
  int timerRunningSeconds = 1;
  Timer? timer;
  //final _controller = BookController();
  int totalReadingTimeInSeconds = 1;
  int perPageReadingApproxTime = 1;

  Future<void> renderAllPdfPages() async {
//try {
    final result = await PDFApi.loadNetwork("${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}");
    final pdf = PdfImageRenderer(path: result.path);
    await pdf.open();
    totalPageInPDF = await pdf.getPageCount();
    print("totalPageInPDF: ${totalPageInPDF}");
    totalReadingTimeInSeconds = (double.tryParse(widget.controller.bookDetails.value!.book.readingTime)! * 60 * 60).toInt();
    print("totalReadingTimeInSeconds: ${totalReadingTimeInSeconds}");

    perPageReadingApproxTime = totalReadingTimeInSeconds ~/ totalPageInPDF;
    trackProgress(1);

    await Future.forEach<int>(List.generate(totalPageInPDF, (index) => index), (pageIndex) async {
      await pdf.openPage(pageIndex: pageIndex);
      final size = await pdf.getPageSize(pageIndex: pageIndex);
      final img = await pdf.renderPage(
        pageIndex: pageIndex,
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        scale: 1.5,
        background: Colors.white,
      );
      await pdf.closePage(pageIndex: pageIndex);
      setState(() {
        //images.add(img!);
      });
    });

    pdf.close();
    setState(() {
      //isLoading = false;
    });
//}
// catch (error) {
// log("Error loading PDF: $error");
// setState(() {
// isLoading = false;
// });
// }
  }

// @override
// void didChangeDependencies() {
// super.didChangeDependencies();
// renderAllPdfPages();
// pageNo.value = 0;
// }

  Future<void> secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    try {
      await ScreenProtector.preventScreenshotOn();
    } on PlatformException catch (e) {
      print("Failed to open Screenshot Blocker Screen: '${e.message}'.");
    }
  }

  // static const platform = MethodChannel('screenshot_blocker');
  // Future<void> _openScreenshotBlockerScreen() async {
  //   try {
  //     await platform.invokeMethod('openScreenshotBlockerScreen');
  //   } on PlatformException catch (e) {
  //     print("Failed to open Screenshot Blocker Screen: '${e.message}'.");
  //   }
  // }
  Future<void> _iosScreenLock() async {
    try {
      await ScreenProtector.preventScreenshotOn();
    } on PlatformException catch (e) {
      print("Failed to open Screenshot Blocker Screen: '${e.message}'.");
    }
  }

  Future<void> _iosScreenUnLock() async {
    try {
      await ScreenProtector.preventScreenshotOff();
    } on PlatformException catch (e) {
      print("Failed to open Screenshot Blocker Screen: '${e.message}'.");
    }
  }

  @override
  void initState() {
    secureScreen();
    if (Platform.isIOS) {
      //  _openScreenshotBlockerScreen;
      _iosScreenLock();
    }
    //  renderAllPdfPages();
// print("asfdjhf ${widget.controller.bookDetails.value!.book.readingTime}");
// print("asfdjhf1 ${double.parse(widget.controller.bookDetails.value!.book.readingTime).toStringAsFixed(0)}");
// timerSeconds = double.parse(widget.controller.bookDetails.value!.book.readingTime).toDouble();
// //
    super.initState();
  }

  dynamic readPage(int progressID, int page) async {
    await widget.controller.readPage(progressID, page, widget.controller.bookDetails.value!.book.pages);
  }

  Widget pageReadingTime(int currentPageStayTimeInSeconds) {
// var pageDuration = Duration(seconds: pageTime.toInt());
//print("pageReadingTime called");
    int pageReadingInMinutes = perPageReadingApproxTime ~/ 60;
    int pageReadingInSeconds = (perPageReadingApproxTime % 60).toInt();

    String defaultTwoDigitMinutes = "${pageReadingInMinutes < 10 ? "0$pageReadingInMinutes" : pageReadingInMinutes}";

    String defaultTwoDigitSeconds = "${pageReadingInSeconds < 10 ? "0$pageReadingInSeconds" : pageReadingInSeconds}";

    int currentReadingInMinutes = currentPageStayTimeInSeconds ~/ 60;
    int currentReadingInSeconds = (currentPageStayTimeInSeconds % 60).toInt();

    String currentReadingInTwoDigitMinutes = "${currentReadingInMinutes < 10 ? "0$currentReadingInMinutes" : currentReadingInMinutes}";

    String currentReadingInTwoDigitSeconds = "${currentReadingInSeconds < 10 ? "0$currentReadingInSeconds" : currentReadingInSeconds}";

//print("${(pageReadingInMinutes <= currentReadingInMinutes && pageReadingInSeconds <= currentReadingInSeconds)}");

    return Row(
      children: [
        Text(
          "$currentReadingInTwoDigitMinutes:$currentReadingInTwoDigitSeconds ",
          style: TextStyle(
              color: pageReadingInMinutes < currentReadingInMinutes
                  ? Colors.amber
                  : pageReadingInSeconds < currentReadingInSeconds
                      ? Colors.amber
                      : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "/ $defaultTwoDigitMinutes:$defaultTwoDigitSeconds",
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );

//return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void startTimer(int pageIndex) {
    cancelTimer();
    timerRunningSeconds = int.parse(widget.controller.readPageResponseModel!.data.pageView.pageStayTime);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//
      int turnRemind = (timerRunningSeconds % (perPageReadingApproxTime ~/ 2));
      if (turnRemind == 0) {
//int totalSpent = timerRunningSeconds
//+(widget.controller.bookDetails.value!.progress.totalTime!);
        log("TimerSeconds: $timerRunningSeconds");
        print("ProgressCallFrom: startTimer");
        widget.controller.readPageProgress(widget.controller.bookDetails.value!.progress.id!, pageIndex, timerRunningSeconds);
      }
      setState(() {
        timerRunningSeconds++;
      });
    });
  }

  ///PDF progress percentage value dispose method ee call user back and api calling done
  @override
  Future<void> dispose() async {
    super.dispose();
    _iosScreenUnLock();
    currentPage = 1;
// calculateReadPercentage();
    if (timer != null) {
      timer!.cancel();
    }

    print("ProgressCallFrom: Dispose");
    await widget.controller.readPageProgress(widget.controller.bookDetails.value!.progress.id!, currentPage, timerRunningSeconds);
    // _controller.dispose();
  }

  ///Pdf progress percentage value calculation mechanism
// void calculateReadPercentage() {
// if (pageCount > 0) {
// widget.controller.readPercentage =
// ((_controller.currentIndex + 1) / pageCount * 100).toInt();
// }
// print("ljksghsjkgsdkjfg ${widget.controller.readPercentage}");
// }

  @override
  Widget build(BuildContext context) {
// String fileName = Uri.parse(
// "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}")
// .pathSegments
// .last
// .replaceAll('.pdf', '');
    //pageNo.value = _controller.currentIndex;
    // currentPage = _controller.currentIndex + 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Obx(
          () => Row(
            children: [
              Expanded(
                child: Text(widget.controller.bookDetails.value!.book.title, style: darkSmallTextStyle),
              ),
              pageReadingTime(timerRunningSeconds.toInt())
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SfPdfViewer.network(
            "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}",
            key: _pdfViewerKey,
            scrollDirection: PdfScrollDirection.horizontal,
            canShowPageLoadingIndicator: true,
            onPageChanged: (PdfPageChangedDetails pageChangedDetails) {
              currentPage = pageChangedDetails.newPageNumber;
              trackProgress(currentPage);
            },
            pageLayoutMode: PdfPageLayoutMode.single,
            onDocumentLoaded: (PdfDocumentLoadedDetails pdfDocumentLoadedDetails) {
              totalPageInPDF = pdfDocumentLoadedDetails.document.pages.count;
              totalReadingTimeInSeconds = (double.tryParse(widget.controller.bookDetails.value!.book.readingTime)! * 60 * 60).toInt();
              perPageReadingApproxTime = totalReadingTimeInSeconds ~/ totalPageInPDF;
              currentPage = 1;
              trackProgress(currentPage);
            },
          );
//               : (images.isNotEmpty)
//                   ? SizedBox(
//                       height: 750.h,
//                       width: 340.w,
//                       child: Zoom(
//                         enableScroll: true,
//                         initScale: 1,
//                         maxScale: 2,
//                         child: BookFx(
//                           controller: _controller,
//                           currentBgColor: Colors.black38,
//                           size: Size(MediaQuery.of(context).size.width, 750),
//                           pageCount: images.length,
//                           nextPage: (int index) {
//                             return SizedBox(
//                               width: 340.w,
//                               height: 750.h,
//                               child: Image.memory(images[index]),
//                             );
//                           },
//                           currentPage: (int index) {
//                             return SizedBox(
//                               width: 340.w,
//                               height: 750.h,
//                               child: Image.memory(images[index]),
//                             );
//                           },
//                           lastCallBack: (index) {
// //print("lastCallBack called");
// //log("CurrentPageIndex:$index");
//                             trackProgress(index);
//                           },
//                           nextCallBack: (index) {
// //log("CurrentPageIndex:$index");
// // currentPage++;
//                             trackProgress(index);
//                           },
//                         ),
//                       ),
//                     )
//                   : SizedBox(
//                       child: Center(
//                         child: LoadingAnimationWidget.prograssiveDots(
//                             color: primaryColor, size: 60),
//                       ),
//                     );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: CustomFloatingActionButton(
      //   isLoading: isLoading,
      //   pageCount: totalPageInPDF,
      //   images: images,
      //   controller: _controller,
      //   child: const Icon(
      //     Icons.search,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Future<void> trackProgress(int pageIndex) async {
    //print("pageIndex: ${pageIndex}");
    cancelTimer();
    await readPage(widget.controller.bookDetails.value!.progress.id!, pageIndex);
    startTimer(pageIndex);
//
// for (int i = 0;
// i <
// widget
// .controller.readPageResponseModel!.data.viewed.pageViews.length;
// i++) {
// if (int.parse(widget.controller.readPageResponseModel!.data.viewed
// .pageViews[i].pageNo) ==
// pageIndex) {
// timerSeconds = double.tryParse(widget.controller.readPageResponseModel!
// .data.viewed.pageViews[i].pageStayTime) ??
// 0.0;
// break;
// }
// }
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timerRunningSeconds = 0;
    }
  }
}
