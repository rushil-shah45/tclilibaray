// import 'package:flutter/material.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoManager extends StatefulWidget {
//   final String videoUrl;
//   const YoutubeVideoManager({super.key, required this.videoUrl});

//   @override
//   State<YoutubeVideoManager> createState() => _YoutubeVideoManagerState();
// }

// class _YoutubeVideoManagerState extends State<YoutubeVideoManager> {
//   late YoutubePlayerController _controller;
//   String videoId = '';

//   @override
//   void initState() {
//     super.initState();
//     videoId = convertUrlToId(widget.videoUrl)!;
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Video Id ${_controller.initialVideoId}");

//     return SizedBox(
//       child: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.red,
//         progressColors: ProgressBarColors(
//           playedColor: Colors.red,
//           bufferedColor: Colors.grey,
//           handleColor: Colors.white,
//           backgroundColor: Colors.grey.withOpacity(0.22),
//         ),
//         onReady: () {
//           _controller.addListener(
//             () {
//               print("Video Listening");
//             },
//           );
//         },
//       ),
//     );
//   }

//   // String? _getYoutubeVideoIdByURL(String url) {
//   //   final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false);
//   //
//   //   try {
//   //     if (regex.hasMatch(url)) {
//   //       return regex.firstMatch(url)!.group(1);
//   //     }
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
//   static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
//     assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
//     if (!url.contains("http") && (url.length == 11)) return url;
//     if (trimWhitespaces) url = url.trim();

//     for (var exp in [
//       RegExp(
//           r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
//       RegExp(
//           r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
//       RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//     ]) {
//       Match match = exp.firstMatch(url) as Match;
//       if (match != null && match.groupCount >= 1) return match.group(1);
//     }

//     return null;
//   }
// }
