import 'dart:developer' as devtools show log;
import 'dart:ui';

import '../../data/enums/social_icon_type.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

extension StringExtension on String {
  String firstCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
extension NumberExtension on String {
  int toEInt() {
    return int.parse(this);
  }

  double toEDouble() {
    return double.parse(this);
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension IconTypeExtension on String {
  IconType getIconType(String type){
    switch(type) {
      case 'username':
        return IconType.username;
      case 'number':
        return IconType.number;
      case 'mail':
        return IconType.mail;
      case 'text':
        return IconType.text;
      case 'address':
        return IconType.address;
      case 'mobile':
        return IconType.mobile;
      case 'file':
        return IconType.file;
      case 'link':
        return IconType.link;
      default:
        return IconType.link;
    }
  }
}
