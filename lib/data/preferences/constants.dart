import 'package:flutter/material.dart';

const kDuration = Duration(seconds: 2);

const String STORAGE_USER_PROFILE_KEY = 'user_profile';
const String STORAGE_USER_TOKEN_KEY = 'user_token';
const String STORAGE_CREDITS_KEY = 'credits';
const String STORAGE_USER_ON_BOARDING = 'user_on_boarding';
const String STORAGE_IS_LOG_IN = 'is_log_in';
const String STORAGE_USER_DATA = 'user_data';
const String NO_POLICY = 'No refund policy';
const String POLICY =
    'You pay for the work done by our engineers, not for the result of that work. We will put everything in place to provide a good product and provide full support. All labour we perform must be paid and for that reason, we will not refund, in part or in full. We will not charge credits from you if we don\'t have a solution.';

/// declare color code
const String primary = '#F39C12';
const String backgroundColor = '#FEF1DD';
const String textColor1 = '#FF0000';
const String textColor2 = '#fedfc0';
const String textColor5 = '#F0F0F5';
const String uploadColor = '#00BC8C';
const String button1 = '#D4860B';
const String button2 = '#009670';
const String button3 = '#e74c3c';
const String button4 = '#3f6791';
const String button5 = '#DC3545';
const String button6 = '#007BFF';
const String button7 = '#3498DB';
const String buttonBlue = '#007bff';
const String buttonYellow = '#ffc107';

const String pricingTop =
    "Our pricing system is based on credits. Credits has a set price and is used to buy modification requests on your uploaded file. When uploading a file you will see the estimated credit price based on your modification requests. Credits is being withdrawn after we've created the finished file based on your request and which requests that has been granted. There is also a minium and maximum price to make sure it's not too expensive:)";

/// convert to color
Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}
