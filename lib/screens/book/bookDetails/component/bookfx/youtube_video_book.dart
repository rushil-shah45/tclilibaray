import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/preferences/constants.dart';
import 'package:tcllibraryapp_develop/global_method/global_method.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoBookWidget extends StatefulWidget {
  const YoutubeVideoBookWidget({super.key, required this.youtubeVideoLink});

  final String youtubeVideoLink;

  @override
  State<YoutubeVideoBookWidget> createState() =>
      _BannerYoutubePlayerWidgetState();
}

class _BannerYoutubePlayerWidgetState extends State<YoutubeVideoBookWidget> {
  // late YoutubePlayerController youtubeController;

  @override
  void initState() {
    super.initState();
    // youtubeController = YoutubePlayerController(
    //   initialVideoId: extractVideoId(widget.youtubeVideoLink),
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     showLiveFullscreenButton: true,
    //     mute: false,
    //     captionLanguage: "en",
    //     hideThumbnail: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    print('###################');
    print(widget.youtubeVideoLink);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: Get.height / 5.h,
        width: Get.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Container(
          height: Get.width / 2,
          width: Get.width,
          child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(widget.youtubeVideoLink)),)
          ),
          // WebViewWidget(controller: webViewController),
        ),
        // YoutubePlayerBuilder(
        //   // player: YoutubePlayer(
        //   //   controller: youtubeController,
        //   //   showVideoProgressIndicator: true,
        //   //
        //   //   topActions: <Widget>[
        //   //     const SizedBox(width: 3),
        //   //     Expanded(
        //   //       child: Text(
        //   //         youtubeController.metadata.title,
        //   //         overflow: TextOverflow.ellipsis,
        //   //         maxLines: 1,
        //   //         style: TextStyle(
        //   //           color: Colors.white,
        //   //           fontSize: 18.sp,
        //   //         ),
        //   //       ),
        //   //     ),
        //   //   ],
        //   //   bottomActions: [
        //   //     CurrentPosition(),
        //   //     ProgressBar(
        //   //       isExpanded: true,
        //   //       colors: const ProgressBarColors(
        //   //         playedColor: Colors.white,
        //   //         handleColor: Colors.white,
        //   //       ),
        //   //     ),
        //   //     const PlaybackSpeedButton(),
        //   //   ],
        //   //   progressIndicatorColor: hexToColor(primary),
        //   //   bufferIndicator: SizedBox(
        //   //     height: 5.h,
        //   //     child: CircularProgressIndicator(
        //   //       strokeWidth: 2,
        //   //       color: hexToColor(primary),
        //   //     ),
        //   //   ),
        //   // ),
        //   player: YoutubePlayer(
        //     controller: youtubeController,
        //   ),
        //   builder: (BuildContext, Widget) {
        //     return YoutubePlayer(
        //       controller: youtubeController,
        //       showVideoProgressIndicator: true,
        //       topActions: [
        //         const SizedBox(width: 3),
        //         Expanded(
        //           child: Text(
        //             youtubeController.metadata.title,
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 1,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18.sp,
        //             ),
        //           ),
        //         ),
        //       ],
        //       bottomActions: [
        //         CurrentPosition(),
        //         ProgressBar(
        //           isExpanded: true,
        //           colors: const ProgressBarColors(
        //             playedColor: Colors.white,
        //             handleColor: Colors.white,
        //           ),
        //         ),
        //         const PlaybackSpeedButton(),
        //         FullScreenButton(
        //           color: Colors.white,
        //           controller: youtubeController,
        //         ),
        //       ],
        //       progressIndicatorColor: hexToColor(primary),
        //       bufferIndicator: SizedBox(
        //         height: 5.h,
        //         child: CircularProgressIndicator(
        //           strokeWidth: 2,
        //           color: hexToColor(primary),
        //         ),
        //       ),
        //     );
        //   },
        //   onEnterFullScreen: () {
        //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        //   },
        //   onExitFullScreen: () {
        //     // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        //   },
        // ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // youtubeController.dispose();
  }
}
