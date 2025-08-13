import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/widgets/push_notification.dart';
import '../../../core/utils/constants.dart';
import '../../../routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class SplashController extends GetxController {
  final LoginController loginController;

  SplashController(this.loginController);

  String token = "";
  RxBool isLoading = false.obs;
  final formatter = DateFormat("yyyy-MM-dd hh:mm");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  PushNotification? _notificationInfo;

  @override
  void onInit() {
    super.onInit();
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      _notificationInfo = notification;
      handleNotificationData(message);
    });
    getToken();
    startTime();
  }

  getToken() {}

  void registerNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        // setState(() {
        _notificationInfo = notification;
        print(message.notification?.title);
        print(message.notification?.body);
        // });
        handleNotificationData(message);
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.white,
            foreground: primaryColor,
            slideDismissDirection: DismissDirection.horizontal,
            duration: const Duration(seconds: 4),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      _notificationInfo = notification;
      handleNotificationData(initialMessage);
    }
  }

  void handleNotificationData(RemoteMessage message) {
    // Handle the notification data, you can navigate to the appropriate screen here
    // For example, you can extract data from the message and open a specific screen
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      dataTitle: message.data['title'],
      dataBody: message.data['body'],
    );
  }

  startTime() async {
    isLoading.value = false;
    SharedPreferences sharedData = await SharedPreferences.getInstance();
    token = sharedData.getString("uToken") ?? '';
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
          log("Check my FCM Token ::::: ${token}");
      if (token != '') {
        String? phone = sharedData.getString('isPhone');
        log("Check my phone ::::: ${phone}");
        if (phone == '0') {
          Get.toNamed(Routes.requiredScreen);
        } else {
          return Timer(kDuration, navigateToMainPage);
        }
      } else {
        return Timer(kDuration, navigateToLoginPage);
      }
    } else {
      return Timer(kDuration, noInternetPage);
    }
  }

  void navigateToMainPage() {
    Get.offAllNamed(Routes.main);
  }

  void noInternetPage() {
    Get.offAllNamed(Routes.noInternet);
  }

  void navigateToLoginPage() {
    Get.offAllNamed(Routes.login);
  }
}
