import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/author/book_update/widgets/category_bottom_sheet.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../controller/update_book_controller.dart';
import '../widgets/custom_container.dart';

class UpdateBookPageOne extends StatefulWidget {
  const UpdateBookPageOne({super.key});

  @override
  State<UpdateBookPageOne> createState() => _UpdateBookPageOneState();
}

class _UpdateBookPageOneState extends State<UpdateBookPageOne> {
  final UpdateBookController updateBookController = Get.find();

  final AudioPlayer audioPlayer = AudioPlayer();
  ValueNotifier<PlayerState> playerState =
      ValueNotifier<PlayerState>(PlayerState.stopped);

  Duration duration = const Duration();
  Duration position = const Duration();
  ValueNotifier<bool> showVolume = ValueNotifier<bool>(false);
  ValueNotifier<bool> isMute = ValueNotifier<bool>(true);

  Future<void> playAudio() async {
    await audioPlayer.play(UrlSource(
      "${RemoteUrls.rootUrl}${updateBookController.bookModel.value!.fileDir}",
    ));
  }

  Future<void> resume() async {
    await audioPlayer.resume();
  }

  Future<void> volume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> seekAudio(Duration duration) async {
    await audioPlayer.seek(duration);
  }

  Future<void> muteAudio(Duration duration) async {
    await audioPlayer.setVolume(0);
  }

  void skipForward() {
    final newPosition = position + const Duration(seconds: 5);
    if (newPosition < duration) {
      seekAudio(newPosition);
    }
  }

  void skipBackward() {
    final newPosition = position - const Duration(seconds: 5);
    if (newPosition > const Duration()) {
      seekAudio(newPosition);
    }
  }

  String formatDurationAudio(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
    } else {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
  }

  VideoPlayerController? videoPlayerController;
  bool _isControllerInitialized = false;
  bool _isPlaying = true;
  bool showControls = true;
  bool isFullscreen = false;
  Timer? timer;

  // Future<void> checkAndRequestPermissions() async {
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     await Permission.storage.request();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        playerState.value = event;
      });
    });

    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    initAsyncVideo();
  }

  Future<void> initAsyncVideo() async {
    final videoUrl =
        '${RemoteUrls.rootUrl}${updateBookController.bookModel.value!.fileDir}';
    // await checkAndRequestPermissions();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    videoPlayerController?.initialize().then((_) {
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
    videoPlayerController?.setLooping(true);
    videoPlayerController?.pause();
  }

  void _toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      videoPlayerController?.pause();
    } else {
      videoPlayerController?.play();
    }
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
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      // videoPlayerController?.enterFullScreen();
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // videoPlayerController?.exitFullScreen();
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateBookController>(builder: (controller) {
      String text = "In Video";
      if (controller.bookType.value == "pdf") {
        text = "In PDF";
      } else if (controller.bookType.value == "audio") {
        text = "In Audio";
      } else if (controller.bookType.value == "video") {
        text = "In Video";
      } else if (controller.bookType.value == "url") {
        text = "Video url";
      }

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    title: 'Book Type ${controller.bookModel.value!.fileType}',
                    star: "*",
                  ),
                  Container(
                    height: Get.height / 16.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      List<String> items = controller.bookItems.value;
                      return DropdownButton(
                        borderRadius: BorderRadius.circular(10.r),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        value: controller.bookType.value == ""
                            ? null
                            : controller.bookType.value,
                        isExpanded: true,
                        iconEnabledColor: Colors.grey.shade400,
                        underline: const SizedBox(),
                        hint: const Text("Select"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          controller.changeBookTypeValue(newValue!);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Book ($text) ',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          Visibility(
                            visible: controller.bookType.value == 'pdf',
                            child: Row(children: [
                              Text(
                                "[ ",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Get.back();
                                  final Uri url = Uri.parse(
                                      "${RemoteUrls.rootUrl}/${controller.bookModel.value!.fileDir}");
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: Text(
                                  'Click Here to view previous file ',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: customBlueColor),
                                ),
                              ),
                              Text(
                                "]",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Visibility(
                        visible: controller.bookType.value != 'url',
                        child: Column(
                          children: [
                            Container(
                              height: Get.height / 16.7,
                              width: Get.width,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions:
                                            controller.bookType.value == "pdf"
                                                ? ['pdf']
                                                : controller.bookType.value ==
                                                        "audio"
                                                    ? ['mp3']
                                                    : controller.bookType
                                                                .value ==
                                                            "video"
                                                        ? ['mp4']
                                                        : null,
                                      );
                                      if (result != null) {
                                        if (result.files.isNotEmpty) {
                                          controller.setBookFile(
                                              File(result.files.single.path!));
                                        }
                                      } else {}
                                    },
                                    child: Container(
                                      height: Get.height / 14,
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('Choose File',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Obx(
                                    () => SizedBox(
                                      height: Get.height,
                                      width: Get.width / 2,
                                      child: controller.bookFileName.value == ""
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "No file chosen",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.sp),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                controller.bookFileName.value,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.bookType.value == 'audio' &&
                            controller.youtubeUrlController.text
                                .endsWith('mp3'),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Slider(
                                      value: position.inMilliseconds.toDouble(),
                                      min: 0.0,
                                      max: duration.inMilliseconds.toDouble(),
                                      activeColor: primaryColor,
                                      thumbColor: primaryColor,
                                      inactiveColor: Colors.white,
                                      onChanged: (value) {
                                        seekAudio(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(formatDurationAudio(position),
                                            style: const TextStyle(
                                                color: primaryColor)),
                                        Text(formatDurationAudio(duration),
                                            style: const TextStyle(
                                                color: primaryColor))
                                      ],
                                    ),
                                    Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: stopAudio,
                                            child: Container(
                                              height: 30.w,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40.r),
                                                color: primaryColor
                                                    .withOpacity(0.22),
                                              ),
                                              child: const Icon(
                                                Icons.stop,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: skipBackward,
                                            child: Container(
                                              width: 40.w,
                                              height: 40.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                                color: primaryColor
                                                    .withOpacity(0.22),
                                              ),
                                              child: const Icon(
                                                Icons.fast_rewind,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable: playerState,
                                            builder: (context, playerStateValue,
                                                child) {
                                              return playerStateValue ==
                                                      PlayerState.playing
                                                  ? InkWell(
                                                      onTap: pauseAudio,
                                                      child: Container(
                                                        width: 50.w,
                                                        height: 50.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.r),
                                                          color: primaryColor
                                                              .withOpacity(
                                                                  0.22),
                                                        ),
                                                        child: const Icon(
                                                          Icons.pause,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: playAudio,
                                                      child: Container(
                                                        width: 50.w,
                                                        height: 50.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.r),
                                                          color: primaryColor
                                                              .withOpacity(
                                                                  0.22),
                                                        ),
                                                        child: const Icon(
                                                          Icons
                                                              .play_arrow_sharp,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    );
                                            },
                                          ),
                                          InkWell(
                                            onTap: skipForward,
                                            child: Container(
                                              width: 40.w,
                                              height: 40.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40.r),
                                                color: primaryColor
                                                    .withOpacity(0.22),
                                              ),
                                              child: const Icon(
                                                Icons.fast_forward,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable: isMute,
                                            builder:
                                                (context, isMuteValue, child) {
                                              return InkWell(
                                                onDoubleTap: () {
                                                  isMute.value = !isMute.value;
                                                  isMute.value
                                                      ? volume(0)
                                                      : null;
                                                },
                                                onTap: () {
                                                  showVolume.value =
                                                      !showVolume.value;
                                                },
                                                child: Container(
                                                  height: 30.w,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color: primaryColor
                                                        .withOpacity(0.22),
                                                  ),
                                                  child: isMuteValue
                                                      ? const Icon(
                                                          Icons.volume_up,
                                                          color: primaryColor,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .volume_off_rounded,
                                                          color: primaryColor,
                                                        ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: showVolume,
                                      builder:
                                          (context, showVolumeValue, child) {
                                        return Visibility(
                                          visible: showVolumeValue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.volume_up,
                                                size: 20,
                                                color: primaryColor,
                                              ),
                                              Slider(
                                                value: audioPlayer.volume,
                                                min: 0.0,
                                                max: 1.0,
                                                activeColor: primaryColor,
                                                inactiveColor: primaryColor
                                                    .withOpacity(0.33),
                                                thumbColor: Colors.grey,
                                                onChanged: (value) {
                                                  volume(value);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 15.h),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.bookType.value == 'video' &&
                            controller.youtubeUrlController.text
                                .endsWith('mp4'),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _toggleControls,
                              child: Container(
                                height: Get.height / 5.h,
                                width: Get.width.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: _isControllerInitialized
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 16.0 / 7.2,
                                            child: VideoPlayer(
                                                videoPlayerController!),
                                          ),
                                          if (showControls)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16.w, right: 16.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: 60.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomContainer(
                                                        height: 50,
                                                        width: 50,
                                                        backgroundColor:
                                                            Colors.black26,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.r),
                                                        onPressed: () {
                                                          jumpBackward(10);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .replay_10_rounded,
                                                          color: Colors.white,
                                                          size: 24.sp,
                                                        ),
                                                      ),
                                                      CustomContainer(
                                                        height: 50,
                                                        width: 50,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        onPressed:
                                                            _togglePlayPause,
                                                        backgroundColor:
                                                            Colors.black26,
                                                        icon: Icon(
                                                          _isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          color: Colors.white,
                                                          size: 24.sp,
                                                        ),
                                                      ),
                                                      CustomContainer(
                                                        height: 50,
                                                        width: 50,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        onPressed: () {
                                                          jumpForward(10);
                                                        },
                                                        backgroundColor:
                                                            Colors.black26,
                                                        icon: Icon(
                                                          Icons
                                                              .forward_10_rounded,
                                                          color: Colors.white,
                                                          size: 24.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  VideoProgressIndicator(
                                                    videoPlayerController!,
                                                    allowScrubbing: true,
                                                    padding: EdgeInsets.only(
                                                        top: 35.h),
                                                    colors:
                                                        const VideoProgressColors(
                                                      playedColor: Colors.white,
                                                      bufferedColor:
                                                          Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                ],
                                              ),
                                            ),
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator()),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.bookType.value == 'url',
                        child: CustomTextField(
                          controller: controller.youtubeUrlController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          hintText: "Enter youtube url",
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomRichText(title: 'Thumbnail '),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "[ ",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Recommended size : 300 x 350",
                              style: TextStyle(
                                  fontSize: controller.isTablet ? 10.sp : 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              " ]",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "*",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: Get.height / 16.7,
                        width: Get.width,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'png',
                                    'jpeg',
                                    'jpg',
                                    'svg'
                                  ],
                                );
                                if (result != null) {
                                  if (result.files.isNotEmpty) {
                                    controller.setThumbnailFile(
                                        File(result.files.single.path!));
                                  }
                                } else {
                                  // User canceled the file picker
                                }
                              },
                              child: Container(
                                height: Get.height / 14,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: const Text('Choose File',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Obx(
                              () => SizedBox(
                                height: Get.height,
                                width: Get.width / 2,
                                child: controller.fileName.value == ""
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "No file chosen",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          controller.fileName.value,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                  const CustomRichText(title: 'Category ', star: "*"),
                  SizedBox(
                    height: Get.height / 15,
                    child: GestureDetector(
                      onTap: () {
                        categoryBottomSheet(context);
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: "Select",
                          controller: controller.selectedCategoryOption,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey, size: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Title ', star: "*"),
                  CustomTextField(
                    controller: controller.titleController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Title",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Sub Title'),
                  CustomTextField(
                    controller: controller.subTitleController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Subtitle",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'ISBN-10 ', star: "*"),
                  CustomTextField(
                    controller: controller.isbnTenController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter ISBN-10",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'ISBN-13 ', star: ""),
                  CustomTextField(
                    controller: controller.isbnThreeController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter ISBN-13",
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: CustomBtn(
                      width: Get.width / 5,
                      text: 'Next',
                      callback: () {
                        if (controller.isFileTypeOkay() &&
                            // controller.isVideoBookOkay() &&
                            // controller.isThumbNailOkay() &&
                            controller.isTitleOkay() &&
                            controller.isCategoryOkay() &&
                            controller.isIsbnTenOkay()) {
                          controller.changePage(1);
                          controller.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else if (!controller.isFileTypeOkay()) {
                          Get.snackbar('File type can\'t be empty',
                              'Please enter your file type');
                        } else if (!controller.isTitleOkay()) {
                          Get.snackbar('Title can\'t be empty',
                              'Please enter your title');
                        } else if (!controller.isCategoryOkay()) {
                          Get.snackbar('Category can\'t be empty',
                              'Please choose your category');
                        } else if (!controller.isVideoBookOkay()) {
                          if (controller.bookType.value != 'url') {
                            Get.snackbar('Book type can\'t be empty',
                                'Please select your book type');
                          } else {
                            Get.snackbar('Youtube link can\'t be empty',
                                'Please enter your youtube link');
                          }
                        } else if (!controller.isThumbNailOkay()) {
                          Get.snackbar('Thumbnail can\'t be empty',
                              'Please select your thumbnail');
                        } else if (!controller.isIsbnTenOkay()) {
                          if (controller.bookType.value != 'url') {
                            Get.snackbar('Isbn10 can\'t be empty',
                                'Please enter your Isbn10');
                          } else {
                            controller.changePage(1);
                            controller.pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void categoryBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return const UpdateBookCategoryBottomSheet();
      },
    );
  }
}
