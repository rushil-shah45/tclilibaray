import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';

class InAppWeb extends StatefulWidget {
  const InAppWeb({
    super.key,
    required this.url,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
  });

  final String url;
  final Function onSuccess, onCancel, onError;

  @override
  State<InAppWeb> createState() => _InAppWebState();
}

class _InAppWebState extends State<InAppWeb> {
  late InAppWebViewController webView;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Paypal Payment",
        ),
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url.toString();
              if (url.toString().contains(RemoteUrls.baseUrl)) {
                widget.onSuccess(url);
                Get.back();
                return NavigationActionPolicy.CANCEL;
              }
              if (url.toString().contains(RemoteUrls.rootUrl)) {
                return NavigationActionPolicy.CANCEL;
              } else {
                return NavigationActionPolicy.ALLOW;
              }
            },
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onCloseWindow: (InAppWebViewController controller) {
              widget.onCancel();
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
          progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    value: progress,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
