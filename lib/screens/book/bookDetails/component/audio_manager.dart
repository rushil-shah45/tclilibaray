import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  final BookDetailsController controller;

  const AudioPlayerWidget({super.key, required this.controller});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  ValueNotifier<PlayerState> playerState =
      ValueNotifier<PlayerState>(PlayerState.stopped);

  Duration duration = const Duration();
  Duration position = const Duration();
  ValueNotifier<bool> showVolume = ValueNotifier<bool>(false);
  ValueNotifier<bool> isMute = ValueNotifier<bool>(true);

  Future<void> playAudio() async {
    await audioPlayer.play(UrlSource(
      "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.fileDir}",
    ));
  }

  ///Audio progress percentage value calculation mechanism
  void calculateAudioPercentage() {
    if (duration.inMilliseconds > 0) {
      widget.controller.readPercentage = ((position.inMilliseconds / duration.inMilliseconds) * 100).toInt();
    }
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
  }

  ///Audio progress percentage value dispose method ee call user back and api calling done
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    calculateAudioPercentage();
    // widget.controller.bookProgress();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.r),
            topRight: Radius.circular(5.r),
          ),
          color: Colors.grey.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Row(
                children: [
                  Obx(
                    () => widget.controller.bookDetails.value != null &&
                            widget.controller.bookDetails.value!.book.thumb
                                .isNotEmpty
                        ? widget.controller.isLoading.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  height: 100.h,
                                  width: 80.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${RemoteUrls.rootUrl}${widget.controller.bookDetails.value!.book.thumb}",
                                  height: 100.h,
                                  width: 80.w,
                                  fit: BoxFit.cover,
                                ),
                              )
                        : Image.asset(
                            'assets/images/default.jpeg',
                            height: 100.h,
                            width: 80.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    width: 180.h,
                    child: Text(
                      "${widget.controller.bookDetails.value!.book.title} ${widget.controller.bookDetails.value!.book.subTitle}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Slider(
              value: position.inMilliseconds.toDouble(),
              min: 0.0,
              max: duration.inMilliseconds.toDouble(),
              activeColor: primaryColor.withOpacity(0.55),
              thumbColor: primaryColor,
              inactiveColor: Colors.white,
              onChanged: (value) {
                seekAudio(Duration(milliseconds: value.toInt()));
                setState(() {
                  position = Duration(milliseconds: value.toInt());
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDurationAudio(position),
                    style: const TextStyle(color: primaryColor),
                  ),
                  Text(
                    formatDurationAudio(duration),
                    style: const TextStyle(color: primaryColor),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: stopAudio,
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: primaryColor.withOpacity(0.22),
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
                        borderRadius: BorderRadius.circular(40.0),
                        color: primaryColor.withOpacity(0.22),
                      ),
                      child: const Icon(
                        Icons.fast_rewind,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: playerState,
                    builder: (context, playerStateValue, child) {
                      return playerStateValue == PlayerState.playing
                          ? InkWell(
                              onTap: pauseAudio,
                              child: Container(
                                width: 50.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: primaryColor.withOpacity(0.22),
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: primaryColor.withOpacity(0.22),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_sharp,
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
                        borderRadius: BorderRadius.circular(40.r),
                        color: primaryColor.withOpacity(0.22),
                      ),
                      child: const Icon(
                        Icons.fast_forward,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isMute,
                    builder: (context, isMuteValue, child) {
                      return InkWell(
                        onDoubleTap: () {
                          isMute.value = !isMute.value;
                          isMute.value ? volume(0) : null;
                        },
                        onTap: () {
                          showVolume.value = !showVolume.value;
                        },
                        child: Container(
                          height: 30.w,
                          width: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: primaryColor.withOpacity(0.22),
                          ),
                          child: isMuteValue
                              ? const Icon(
                                  Icons.volume_up,
                                  color: primaryColor,
                                )
                              : const Icon(
                                  Icons.volume_off_rounded,
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
              builder: (context, showVolumeValue, child) {
                return Visibility(
                  visible: showVolumeValue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        inactiveColor: primaryColor.withOpacity(0.33),
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
          ],
        ),
      ),
    );
  }
}
