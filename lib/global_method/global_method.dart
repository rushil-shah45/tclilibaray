import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

Future<void> checkAndRequestPermissions() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    await Permission.storage.request();
  }
}

Future<String> downloadVideo(String url, String name) async {
  await checkAndRequestPermissions();
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final File file;

    String files = name.split('/').last;
    String fileName = files.split('.').last;
    String fileExtension = files.replaceAll('$fileName.', '');

    if (await File('/storage/emulated/0/download/$files').exists()) {
      int i = 1;
      while (await File(
              '/storage/emulated/0/download/$fileName($i).$fileExtension')
          .exists()) {
        i++;
      }
      file = File('/storage/emulated/0/download/$fileName($i).$fileExtension');
    } else {
      file = File('/storage/emulated/0/download/$files');
    }
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }
  throw Exception('Failed to download video');
}

String extractVideoId(String url) {
  RegExp regExp = RegExp(
    r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    caseSensitive: false,
    multiLine: false,
  );
  Match? match = regExp.firstMatch(url);
  if (match != null && match.groupCount >= 1) {
    return match.group(1)!;
  }
  return '';
}
