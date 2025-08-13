
import 'dart:developer';

import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';

import '../../../data/remote_urls.dart';

class TwakController extends GetxController {
  
  RxBool isLoading = false.obs;
  String twakScr = '';

  @override
  void onInit() {
    super.onInit();
    //twakScr = Get.arguments;
    
    twakScr = RemoteUrls.twakSrc;
    print(twakScr);
    // getWebView();
  }

  // getWebView() {
  //   isLoading(true);
  //   webController = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {},
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {
  //           Timer(const Duration(seconds: 1), () {
  //             isLoading(false);
  //           });
  //         },
  //         onWebResourceError: (WebResourceError error) {
  //           isLoading(false);
  //         },
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url.startsWith('twakScr')) {
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(Uri.parse(twakScr));
  // }
}
