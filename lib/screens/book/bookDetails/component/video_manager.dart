import 'dart:async';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';
import 'package:video_player/video_player.dart';

class VideoManager extends StatefulWidget {
  final BookDetailsController controller;

  const VideoManager({super.key, required this.controller});

  @override
  State<VideoManager> createState() => _VideoManagerState();
}

class _VideoManagerState extends State<VideoManager> {
  VideoPlayerController? videoPlayerController;
  bool _isControllerInitialized = false;
  bool _isPlaying = true;
  bool showControls = true;
  bool isFullscreen = false;
  Timer? timer;

  ChewieController? chewieController;

  // Future<void> checkAndRequestPermissions() async {
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     await Permission.storage.request();
  //   }
  // }

  Future<void> secureScreen() async {
    try {
      await ScreenProtector.preventScreenshotOn();
    } catch (e) {
      print("Failed to enable screen protection: $e");
    }
  }

  Future<void> blockOIS() async {
    try {
      await ScreenProtector.preventScreenshotOn();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unbLockOIS() async {
    await ScreenProtector.preventScreenshotOff();
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
    if (Platform.isIOS) {
      blockOIS();
    }
    initAsyncVideo();
  }

  Future<void> initAsyncVideo() async {
    final videoUri =
        '${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}';
    // await checkAndRequestPermissions();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUri));
    await videoPlayerController?.initialize().then((_) {
      setState(() {
        _isControllerInitialized = true;
      });
    });

    videoPlayerController?.addListener(() {
      if (!videoPlayerController!.value.isPlaying &&
          videoPlayerController!.value.isInitialized) {
        setState(() {
          _isPlaying = false;
        });
      } else {
        setState(() {
          _isPlaying = true;
        });
      }
    });

    /// Check if video playback is 100% complete and auto-start
    if (videoPlayerController!.value.position ==
            videoPlayerController!.value.duration &&
        widget.controller.readPercentage == 100) {
      /// Auto-start the video
      videoPlayerController?.play();
      updatePlaybackPercentage();
    }
    videoPlayerController?.setLooping(true);
    videoPlayerController?.pause();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      looping: false,
      aspectRatio: MediaQuery.of(context).orientation == Orientation.portrait
          ? 4 / 3
          : 21 / 9,
      allowFullScreen: true,
      autoInitialize: true,
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
      showControls: true,
    );
  }

  void _toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  ///Video progress percentage value calculation mechanism
  void _togglePlayPause() {
    if (_isPlaying) {
      videoPlayerController?.pause();
    } else {
      /// Check if the playback percentage is less than 100% before playing
      if (widget.controller.readPercentage < 100) {
        videoPlayerController?.play();
        updatePlaybackPercentage();
      }
    }
  }

  ///Video progress percentage value calculation mechanism
  void updatePlaybackPercentage() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (videoPlayerController != null &&
          videoPlayerController!.value.isPlaying) {
        setState(() {
          final currentPosition = videoPlayerController!.value.position;
          final totalDuration = videoPlayerController!.value.duration;
          final timeTotal = currentPosition.inSeconds / totalDuration.inSeconds;
          widget.controller.readPercentage = (timeTotal * 100).toInt();
        });
      }
    });
  }

  void jumpBackward(int seconds) {
    final currentPosition = videoPlayerController!.value.position;
    final jumpDuration = Duration(seconds: seconds);
    final newPosition = currentPosition - jumpDuration;
    if (newPosition.isNegative) {
      videoPlayerController!.seekTo(Duration.zero);
    } else {
      videoPlayerController!.seekTo(newPosition);
    }
  }

  void jumpForward(int seconds) {
    final currentPosition = videoPlayerController!.value.position;
    final jumpDuration = Duration(seconds: seconds);
    final newPosition = currentPosition + jumpDuration;
    videoPlayerController!.seekTo(newPosition);
  }

  void toggleFullscreen() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
    if (isFullscreen) {
      setState(() {
        h = Get.height;
        w = Get.width;
        // ratio = 20/9;
      });
      // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      // videoPlayerController?.enterFullScreen();
    } else {
      setState(() {
        h = Get.height / 4;
        w = Get.width;
        ratio = 16 / 8;
      });
      // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // videoPlayerController?.exitFullScreen();
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  ///Video progress percentage value dispose method ee call user back and api calling done
  @override
  void dispose() {
    unbLockOIS();
    videoPlayerController?.dispose();
    chewieController?.dispose();
    timer?.cancel();
    updatePlaybackPercentage();
    // widget.controller.bookProgress();
    super.dispose();
  }

  double h = Get.height / 4;
  double w = Get.width;

  double ratio = 16 / 8;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: /*_isControllerInitialized
            ? Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: ratio,
                    child: VideoPlayer(videoPlayerController!),
                  ),
                  if (showControls)
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 70.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomContainer(
                                height: 50,
                                width: 50,
                                backgroundColor: Colors.black26,
                                borderRadius: BorderRadius.circular(100.r),
                                onPressed: () {
                                  jumpBackward(10);
                                },
                                icon: Icon(
                                  Icons.replay_10_rounded,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                              CustomContainer(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(100),
                                onPressed: _togglePlayPause,
                                backgroundColor: Colors.black26,
                                icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                              CustomContainer(
                                height: 50,
                                width: 50,
                                borderRadius: BorderRadius.circular(100),
                                onPressed: () {
                                  jumpForward(10);
                                },
                                backgroundColor: Colors.black26,
                                icon: Icon(
                                  Icons.forward_10_rounded,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                          VideoProgressIndicator(
                            videoPlayerController!,
                            allowScrubbing: true,
                            padding: EdgeInsets.only(top: 35.h),
                            colors: const VideoProgressColors(
                              playedColor: Colors.white,
                              bufferedColor: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${formatDuration(videoPlayerController!.value.position)} / ${formatDuration(videoPlayerController!.value.duration)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(onTap: () {
                                print("jfskhdfgjashkfgjashd");
                                toggleFullscreen();
                              },child: Icon(Icons.fullscreen,color: Colors.white,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              )*/
            chewieController != null || _isControllerInitialized
                ? Chewie(controller: chewieController!)
                : const Center(child: CircularProgressIndicator()),
      ),
    );

    //   SizedBox(
    //   width: 300.w,
    //   child: Stack(
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           if (isPlaying.value) {
    //             pause();
    //           } else {
    //             play();
    //           }
    //         },
    //         child: Center(
    //           child: _controller!.value.isInitialized
    //               ? AspectRatio(
    //                   aspectRatio: _controller!.value.aspectRatio,
    //                   child: VideoPlayer(_controller!),
    //                 )
    //               : const CircularProgressIndicator(),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 10.h,
    //         left: 0,
    //         right: 0,
    //         child: Visibility(
    //           visible: _controller!.value.isInitialized,
    //           child: Column(
    //             children: [
    //               VideoProgressIndicator(
    //                 _controller!,
    //                 allowScrubbing: true,
    //                 colors: VideoProgressColors(
    //                   playedColor: Colors.red,
    //                   bufferedColor: primaryColor.withOpacity(0.22),
    //                   backgroundColor: Colors.white,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10.h,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       InkWell(
    //                         onTap: seekBackward,
    //                         child: Container(
    //                           width: 30.w,
    //                           height: 30.w,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(40.0),
    //                             color: Colors.white.withOpacity(0.22),
    //                           ),
    //                           child: const Icon(
    //                             Icons.fast_rewind,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: 10.w,
    //                       ),
    //                       ValueListenableBuilder(
    //                         valueListenable: isPlaying,
    //                         builder: (context, value, child) {
    //                           return InkWell(
    //                             onTap: isPlaying.value ? pause : play,
    //                             child: Container(
    //                               width: 30.w,
    //                               height: 30.w,
    //                               decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(40.0),
    //                                 color: Colors.white.withOpacity(0.22),
    //                               ),
    //                               child: Icon(
    //                                 isPlaying.value
    //                                     ? Icons.pause
    //                                     : Icons.play_arrow,
    //                                 color: Colors.white,
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                       SizedBox(
    //                         width: 10.w,
    //                       ),
    //                       InkWell(
    //                         onTap: seekForward,
    //                         child: Container(
    //                           width: 30.w,
    //                           height: 30.w,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(40.0),
    //                             color: Colors.white.withOpacity(0.22),
    //                           ),
    //                           child: const Icon(
    //                             Icons.fast_forward,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(width: 20.w),
    //                   ValueListenableBuilder(
    //                     valueListenable: showVolumeVideo,
    //                     builder: (context, showVolumeValue, child) {
    //                       return Visibility(
    //                         visible: true,
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             ValueListenableBuilder(
    //                               valueListenable: isMuteVideo,
    //                               builder: (context, isMuteValue, child) {
    //                                 return InkWell(
    //                                   onTap: () {
    //                                     setState(() {
    //                                       isMuteVideo.value =
    //                                           !isMuteVideo.value;
    //                                       isMuteVideo.value
    //                                           ? setVolume(0)
    //                                           : null;
    //                                     });
    //                                   },
    //                                   child: Container(
    //                                     width: 30.w,
    //                                     height: 30.w,
    //                                     decoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(20.0),
    //                                       color: Colors.white.withOpacity(0.22),
    //                                     ),
    //                                     child: isMuteValue
    //                                         ? const Icon(
    //                                             Icons.volume_up,
    //                                             color: Colors.white,
    //                                           )
    //                                         : const Icon(
    //                                             Icons.volume_off_rounded,
    //                                             color: Colors.white,
    //                                           ),
    //                                   ),
    //                                 );
    //                               },
    //                             ),
    //                             Slider(
    //                               value: _controller!.value.volume,
    //                               min: 0.0,
    //                               max: 1.0,
    //                               activeColor: Colors.red,
    //                               inactiveColor: Colors.white.withOpacity(0.33),
    //                               thumbColor: Colors.white,
    //                               onChanged: (value) {
    //                                 setState(() {
    //                                   setVolume(value);
    //                                 });
    //                               },
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
