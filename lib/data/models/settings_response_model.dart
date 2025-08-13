// To parse this JSON data, do
//
//     final settingsResponseModel = settingsResponseModelFromJson(jsonString);

import 'dart:convert';

SettingsResponseModel settingsResponseModelFromJson(String str) => SettingsResponseModel.fromJson(json.decode(str));

String settingsResponseModelToJson(SettingsResponseModel data) => json.encode(data.toJson());

class SettingsResponseModel {
  bool? status;
  int? code;
  String? msg;
  String? error;
  Data? data;
  String? description;

  SettingsResponseModel({this.status, this.code, this.msg, this.error, this.data, this.description});

  SettingsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['description'] = this.description;
    return data;
  }
}

class Data {
  int? id;
  String? googleKey;
  String? googleAnalyticsId;
  String? siteName;
  String? siteLogo;
  String? adminLogo;
  String? favicon;
  String? seoMetaDescription;
  String? seoKeywords;
  String? seoImage;
  String? tawkChatBotKey;
  String? name;
  String? address;
  String? driver;
  String? host;
  int? port;
  String? encryption;
  String? username;
  String? password;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? applicationType;
  String? appMode;
  String? facebookClientId;
  String? facebookClientSecret;
  String? facebookCallbackUrl;
  String? googleClientId;
  String? googleClientSecret;
  String? googleCallbackUrl;
  String? copyrightText;
  String? officeAddress;
  String? facebookUrl;
  String? youtubeUrl;
  String? twitterUrl;
  String? linkedinUrl;
  String? telegramUrl;
  String? whatsappNumber;
  String? iosAppUrl;
  String? androidAppUrl;
  String? email;
  String? phoneNo;
  String? supportEmail;
  String? instagramUrl;
  int? emailVerification;
  String? flutterwavePublicKey;
  String? flutterwaveSecretKey;
  String? flutterwaveEncriptionKey;
  String? paypalMode;
  String? paypalClientId;
  String? paypalClientSecret;
  String? mailchimpApiKey;
  String? mailchimpListId;
  String? tawkSrc;
  String? tawkChatUrl;
  int? recaptchaEnable;
  String? recaptchaSiteKey;
  String? recaptchaSecretKey;
  String? appleClientSecret;
  String? appleClientId;
  int? commission;

  Data(
      {this.id,
      this.googleKey,
      this.googleAnalyticsId,
      this.siteName,
      this.siteLogo,
      this.adminLogo,
      this.favicon,
      this.seoMetaDescription,
      this.seoKeywords,
      this.seoImage,
      this.tawkChatBotKey,
      this.name,
      this.address,
      this.driver,
      this.host,
      this.port,
      this.encryption,
      this.username,
      this.password,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.applicationType,
      this.appMode,
      this.facebookClientId,
      this.facebookClientSecret,
      this.facebookCallbackUrl,
      this.googleClientId,
      this.googleClientSecret,
      this.googleCallbackUrl,
      this.copyrightText,
      this.officeAddress,
      this.facebookUrl,
      this.youtubeUrl,
      this.twitterUrl,
      this.linkedinUrl,
      this.telegramUrl,
      this.whatsappNumber,
      this.iosAppUrl,
      this.androidAppUrl,
      this.email,
      this.phoneNo,
      this.supportEmail,
      this.instagramUrl,
      this.emailVerification,
      this.flutterwavePublicKey,
      this.flutterwaveSecretKey,
      this.flutterwaveEncriptionKey,
      this.paypalMode,
      this.paypalClientId,
      this.paypalClientSecret,
      this.mailchimpApiKey,
      this.mailchimpListId,
      this.tawkSrc,
      this.tawkChatUrl,
      this.recaptchaEnable,
      this.recaptchaSiteKey,
      this.recaptchaSecretKey,
      this.appleClientSecret,
      this.appleClientId,
      this.commission});

  Data.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString()) ?? json['id'];
    googleKey = json['google_key'];
    googleAnalyticsId = json['google_analytics_id'];
    siteName = json['site_name'];
    siteLogo = json['site_logo'];
    adminLogo = json['admin_logo'];
    favicon = json['favicon'];
    seoMetaDescription = json['seo_meta_description'];
    seoKeywords = json['seo_keywords'];
    seoImage = json['seo_image'];
    tawkChatBotKey = json['tawk_chat_bot_key'];
    name = json['name'];
    address = json['address'];
    driver = json['driver'];
    host = json['host'];
    port = int.tryParse(json['port'].toString()) ?? json['port'];
    encryption = json['encryption'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    applicationType = json['application_type'];
    appMode = json['app_mode'];
    facebookClientId = json['facebook_client_id'];
    facebookClientSecret = json['facebook_client_secret'];
    facebookCallbackUrl = json['facebook_callback_url'];
    googleClientId = json['google_client_id'];
    googleClientSecret = json['google_client_secret'];
    googleCallbackUrl = json['google_callback_url'];
    copyrightText = json['copyright_text'];
    officeAddress = json['office_address'];
    facebookUrl = json['facebook_url'];
    youtubeUrl = json['youtube_url'];
    twitterUrl = json['twitter_url'];
    linkedinUrl = json['linkedin_url'];
    telegramUrl = json['telegram_url'];
    whatsappNumber = json['whatsapp_number'];
    iosAppUrl = json['ios_app_url'];
    androidAppUrl = json['android_app_url'];
    email = json['email'];
    phoneNo = json['phone_no'];
    supportEmail = json['support_email'];
    instagramUrl = json['instagram_url'];
    emailVerification = int.tryParse(json['email_verification'].toString()) ?? json['email_verification'];
    flutterwavePublicKey = json['flutterwave_public_key'];
    flutterwaveSecretKey = json['flutterwave_secret_key'];
    flutterwaveEncriptionKey = json['flutterwave_encription_key'];
    paypalMode = json['paypal_mode'];
    paypalClientId = json['paypal_client_id'];
    paypalClientSecret = json['paypal_client_secret'];
    mailchimpApiKey = json['mailchimp_api_key'];
    mailchimpListId = json['mailchimp_list_id'];
    tawkSrc = json['tawk_src'];
    tawkChatUrl = json['tawk_chat_url'];
    recaptchaEnable = int.tryParse(json['recaptcha_enable'].toString()) ?? json['recaptcha_enable'];
    recaptchaSiteKey = json['recaptcha_site_key'];
    recaptchaSecretKey = json['recaptcha_secret_key'];
    appleClientSecret = json['apple_client_secret'];
    appleClientId = json['apple_client_id'];
    commission = int.tryParse(json['commission'].toString()) ?? json['commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['google_key'] = this.googleKey;
    data['google_analytics_id'] = this.googleAnalyticsId;
    data['site_name'] = this.siteName;
    data['site_logo'] = this.siteLogo;
    data['admin_logo'] = this.adminLogo;
    data['favicon'] = this.favicon;
    data['seo_meta_description'] = this.seoMetaDescription;
    data['seo_keywords'] = this.seoKeywords;
    data['seo_image'] = this.seoImage;
    data['tawk_chat_bot_key'] = this.tawkChatBotKey;
    data['name'] = this.name;
    data['address'] = this.address;
    data['driver'] = this.driver;
    data['host'] = this.host;
    data['port'] = this.port;
    data['encryption'] = this.encryption;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['application_type'] = this.applicationType;
    data['app_mode'] = this.appMode;
    data['facebook_client_id'] = this.facebookClientId;
    data['facebook_client_secret'] = this.facebookClientSecret;
    data['facebook_callback_url'] = this.facebookCallbackUrl;
    data['google_client_id'] = this.googleClientId;
    data['google_client_secret'] = this.googleClientSecret;
    data['google_callback_url'] = this.googleCallbackUrl;
    data['copyright_text'] = this.copyrightText;
    data['office_address'] = this.officeAddress;
    data['facebook_url'] = this.facebookUrl;
    data['youtube_url'] = this.youtubeUrl;
    data['twitter_url'] = this.twitterUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['telegram_url'] = this.telegramUrl;
    data['whatsapp_number'] = this.whatsappNumber;
    data['ios_app_url'] = this.iosAppUrl;
    data['android_app_url'] = this.androidAppUrl;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['support_email'] = this.supportEmail;
    data['instagram_url'] = this.instagramUrl;
    data['email_verification'] = this.emailVerification;
    data['flutterwave_public_key'] = this.flutterwavePublicKey;
    data['flutterwave_secret_key'] = this.flutterwaveSecretKey;
    data['flutterwave_encription_key'] = this.flutterwaveEncriptionKey;
    data['paypal_mode'] = this.paypalMode;
    data['paypal_client_id'] = this.paypalClientId;
    data['paypal_client_secret'] = this.paypalClientSecret;
    data['mailchimp_api_key'] = this.mailchimpApiKey;
    data['mailchimp_list_id'] = this.mailchimpListId;
    data['tawk_src'] = this.tawkSrc;
    data['tawk_chat_url'] = this.tawkChatUrl;
    data['recaptcha_enable'] = this.recaptchaEnable;
    data['recaptcha_site_key'] = this.recaptchaSiteKey;
    data['recaptcha_secret_key'] = this.recaptchaSecretKey;
    data['apple_client_secret'] = this.appleClientSecret;
    data['apple_client_id'] = this.appleClientId;
    data['commission'] = this.commission;
    return data;
  }
}
