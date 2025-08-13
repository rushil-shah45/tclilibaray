import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/twak_chat/controller/twak_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

  class TwakScreen extends StatefulWidget {
    const TwakScreen({super.key});

    @override
    State<TwakScreen> createState() => _TwakScreenState();
  }

  class _TwakScreenState extends State<TwakScreen> {
      
    // String name = '';
    // String email = '';  


    // @override
    // Widget build(BuildContext context) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Future.delayed(const Duration(milliseconds: 500), () {
    //       email =  Get.find<MainController>().userProfileModel!.email.toString();
    //       name = "${Get.find<MainController>().userProfileModel!.name.toString()} ${Get.find<MainController>().userProfileModel!.lastName.toString()}";

    //     log("Check my data : ::::: $name, $email");
    //     });

    //   });
    //   return SafeArea(
    //     child: Scaffold(
    //       appBar: AppBar(
    //         leading: IconButton(
    //           icon: const Icon(Icons.arrow_back_ios_new),
    //           onPressed: () {
    //             Get.back();
    //           },
    //         ),
    //         title: Text(
    //           'Live Chat',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       body: /* InAppWebView(
    //       initialUrlRequest: URLRequest(
    //         url: WebUri(
    //             "https://tawk.to/chat/67aac0b7825083258e1311e7/1ijpg1jk7"),
    //       ),
    //       onWebViewCreated: (controller) {
    //         webViewController = controller;
    //       },
    //     ), */
      
    //       Tawk(
    //         directChatLink:
    //             'https://tawk.to/chat/67aac0b7825083258e1311e7/1ijpg1jk7',
    //         visitor: TawkVisitor(
    //           name: name,
    //           email: email,
    //         ),
    //         onLoad: () {
    //           print('Hello Tawk!');
    //         },
    //         onLinkTap: (String url) {
    //           print(url);
    //         },
    //         placeholder: const Center(
    //           child: Text('Loading...'),
    //         ),
    //       ),

    //       // Stack(
    //       //   children: [
    //       //     Obx(
    //       //           () => controller.isLoading.value
    //       //           ? const Center(child: CircularProgressIndicator())
    //       //           : SizedBox(
    //       //           width: double.infinity.w,
    //       //           child: WebViewWidget(controller: controller.webController)),
    //       //     ),
    //       //     Positioned(
    //       //       top: 0, left: 0,
    //       //       child: Container(
    //       //         padding: const EdgeInsets.only(left: 10),
    //       //         height: 75, width: Get.width,
    //       //         color: Colors.white,
    //       //         child: Row(
    //       //           children: [
    //       // IconButton(
    //       //   icon: const Icon(Icons.arrow_back_ios_new),
    //       //   onPressed: () {
    //       //     Get.back();
    //       //   },
    //       // ),
    //       //             Expanded(
    //       // child: Text(
    //       //   'Live Chat',
    //       //   textAlign: TextAlign.center,
    //       //   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    //       // ),
    //       //             ),
    //       //           ],
    //       //         ),
    //       //       ),
    //       //     ),
    //       //   ],
    //       // ),
    //     ),
    //   );
    // }

    late InAppWebViewController webViewController;

  @override
  void initState() {
    super.initState();
    clearWebViewCache();
  }

  Future<void> clearWebViewCache() async {
    final cookieManager = CookieManager.instance();
    await cookieManager.deleteAllCookies(); // Clear all cookies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Chat")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://tawk.to/chat/67aac0b7825083258e1311e7/1ijpg1jk7"),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            cacheEnabled: false, // Disable cache
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          // Clear session storage and reload
          await controller.evaluateJavascript(source: """
            sessionStorage.clear();
            localStorage.clear();
            Tawk_API = Tawk_API || {};
            Tawk_API.endChat(); // End any ongoing chat
          """);
        },
      ),
    );
    }
  }
