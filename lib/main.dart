import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcllibraryapp_develop/bindings/app_bindings.dart';
import 'package:tcllibraryapp_develop/core/utils/my_theme.dart';
import 'package:tcllibraryapp_develop/data/preferences/storage_service.dart';
import 'package:tcllibraryapp_develop/routes/pages.dart';

late final SharedPreferences sharedPreferences;

final _configuration = PurchasesConfiguration('appl_vPdQSVwfdFxFoYmfdbdinMbolpg'); // appl_NhVnyZMjzdlDRnEOhJqYblPkLJj

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    // await Firebase.initializeApp(
    //   name: "tcli-ios",
    //   options: const FirebaseOptions(
    //       apiKey: "AIzaSyAzKHgC6oMv3mFpITsLErr8Sgqzs5Gsm0o",
    //       appId: "1:663622174491:ios:03ef914877a2a2d8c0f5be",
    //       messagingSenderId: "663622174491",
    //       projectId: "tcli-app"),
    // );

    await Firebase.initializeApp(
      name: "tcli-ios",
      options: const FirebaseOptions(
          apiKey: "AIzaSyAXY1mRsbgby76jsYLCclk3659QMWk3baw",
          appId: "1:705177094629:ios:d51def6a3d7bfa14ce470c",
          messagingSenderId: "663622174491",
          projectId: "tclilibrary-9ed4e"),
    );
    await Future.delayed(const Duration(seconds: 1));
  } else {
    // await Firebase.initializeApp(
    //     options: const FirebaseOptions(
    //         apiKey: "AIzaSyAEordPxRoXfUgzl6IzMugJ71C5HojYhV0",
    //         appId: "1:663622174491:android:85b99282e945ae17c0f5be",
    //         messagingSenderId: z "663622174491",
    //         projectId: "tcli-app"));
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCuOUIOy6pIp-9BhgqIGbbQZLvRGQuugTA',
        appId: '1:705177094629:android:d5c6d8e123b49a01ce470c',
        messagingSenderId: '705177094629',
        projectId: 'tclilibrary-9ed4e',
      ),
    );
  }

  if (Platform.isIOS) {
    await Purchases.configure(_configuration).whenComplete(() {
      log("In app Purchase Configuration done inspect");
    });
  }

  sharedPreferences = await SharedPreferences.getInstance();
  await Get.putAsync<StorageService>(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(344, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return OverlaySupport(
          child: GetMaterialApp(
            title: 'TCLI Library',
            debugShowCheckedModeBanner: false,
            theme: MyTheme.theme,
            initialBinding: AppBindings(),
            home: child,
            getPages: Pages.pages,
            builder: EasyLoading.init(),
          ),
        );
      },
      child: Pages.initial,
    );
  }
}
