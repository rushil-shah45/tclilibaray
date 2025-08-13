import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/pdf_screen_new.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/component/pdf_screen_new2.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class BookCover extends StatelessWidget {
   BookCover({super.key, required this.controller, required this.isBookForSale, required this.bookForSaleTitle, required this.onBookForSaleChange});

  final BookDetailsController controller;
  bool isBookForSale;
  String bookForSaleTitle;
  Function(bool callback) onBookForSaleChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PdfScreen(controller: controller);
            }));
          },
          child: Obx(
            () => controller.bookDetails.value != null &&
                    controller.bookDetails.value!.book.thumb.isNotEmpty
                ? controller.isLoading.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height: Get.height / 4,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: SizedBox(
                          height: Get.height / 4,
                          width: 200,
                          child: CachedNetworkImage(
                            imageUrl:
                                "${RemoteUrls.rootUrl}${controller.bookDetails.value!.book.thumb}",
                            height: Get.height / 4,
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                : Image.asset('assets/images/default.jpeg',
                    height: Get.height / 4, width: 200.h, fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 5.h),
          child: CustomBtn(
            width: Get.width / 1,
            color:  Colors.green,
            text: "Read now",
            callback: () async {
              if(isBookForSale == true){
                onBookForSaleChange(true);
              }else {
Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PdfScreen2(controller: controller);
                return PdfScreen(controller: controller);
              }));
              }
              
            },
          ),
        ),
      ],
    );
  }
}

ValueNotifier<int> pageNo = ValueNotifier(0);

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    DateTime startTime = DateTime.now();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the PDF is cached
    String? cachedPdf = prefs.getString(url);
    if (cachedPdf != null) {
      final List<int> pdfBytes = base64.decode(cachedPdf);
      final File file = await _storeFile(url, pdfBytes);

      // Calculate the execution time
      DateTime endTime = DateTime.now();
      Duration executionTime = endTime.difference(startTime);
      print(
          "Execution time for Loading pdf from cache: ${executionTime.inMilliseconds} milliseconds");

      return file;
    } else {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Store the PDF content in shared preferences for future use
        prefs.setString(url, base64.encode(bytes));

        // Calculate the execution time
        DateTime endTime = DateTime.now();
        Duration executionTime = endTime.difference(startTime);
        print(
            "Execution time for Loading pdf and caching: ${executionTime.inMilliseconds} milliseconds");

        return _storeFile(url, bytes);
      } else {
        // Handle HTTP errors
        print("HTTP request failed with status code: ${response.statusCode}");
        return Future.error("HTTP request failed");
      }
    }
  }

  static Future<File> loadAsset(String assetPath) async {
    // Load the PDF file from the assets as a byte data
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    return _storeFile(assetPath, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
