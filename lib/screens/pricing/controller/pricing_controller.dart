import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tcllibraryapp_develop/core/utils/helpers.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/payment/controller/payment_controller.dart';
import 'package:tcllibraryapp_develop/screens/pricing/model/pricing_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class PricingController extends GetxController {
  final SettingsRepository settingsRepository;
  final LoginController loginController;
  String apiKey = 'appl_vPdQSVwfdFxFoYmfdbdinMbolpg';

  PricingController(this.settingsRepository, this.loginController);

  // final PageController pageController =
  //     PageController(viewportFraction: 0.9, initialPage: 0);
  RxBool isLoading = false.obs;
  int currentPage = 0;
  List<PricingModel> pricingModelList = [];
  var token;
  bool isTablet = Get.width >= 600;

  Rx<List<Package>> pack = Rx<List<Package>>([]);
  Rx<List<String>> products = Rx<List<String>>([]);
  RxBool isRestoring = false.obs;
  RxBool isRestored = false.obs;
  var isAnnual = 1.obs;
  RxBool isBuying = false.obs;

  Future<void> restorePurchase() async {
    isRestoring(true);
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      String _apiKeyOld = 'appl_NhVnyZMjzdlDRnEOhJqYblPkLJj';

      await Purchases.configure(PurchasesConfiguration(apiKey));
      LogInResult result = await Purchases.logIn("\$RCAnonymousID:81a4022df424417eb27e1e8319a448be");

      for (String s in customerInfo.activeSubscriptions) {
        print(s);
        products.value.add(s);
      }
      isRestored(true);
      isRestoring(false);
    } catch (e) {
      // TODO
      print(e.toString());
      isRestoring(false);
    }
  }

  Future<void> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      log('Offerings For Purchase subsription ::::: $offerings');
      List<Offering> total = [];
      offerings.all.forEach((key, value) {
        total.add(value);
      });
      if (total.isEmpty) {
        Helper.toastMsg('No Plans Found');
      } else {
        pack.value.addAll(total.map((offer) => offer.availablePackages).expand((element) => element).toList());
        print(pack.value.length);
      }
    } on PlatformException catch (e) {
      log('Purchase controller error :::: $e');
      Get.snackbar('Warning', e.message!);
    }
  }

  Future<void> purchasePackage(Package package, id) async {
    isBuying(true);
    try {
      await Purchases.purchasePackage(package).then((value) {
        value.customerInfo.entitlements.active.forEach((key, val) {
          if (val.productIdentifier.compareTo(package.storeProduct.identifier) == 0) {
            makeInAppPurchase(id, value.customerInfo.originalAppUserId, value.customerInfo.originalAppUserId);
          } else {
            Helper.toastMsg('Downgrade will Eligible only after end of current subscription');

            /// not bought
            isBuying(false);
          }
        });
      });
    } catch (e) {
      // TODO
      print(e.toString());
      isBuying(false);
    }
  }

  makeInAppPurchase(id, paymentUserId, transactionId) async {
    final body = <String, dynamic>{};
    body.addAll({"package_id": id});
    body.addAll({"status": 'successful'});
    // body.addAll({'start_date': start});
    // body.addAll({'end_date': end});
    // body.addAll({"is_yearly": isYearly == true ? '1' : '0'});
    // body.addAll({"cost": '$cost'});
    // body.addAll({"id": '$id'});
    // body.addAll({'user_id': userId});
    body.addAll({'subscription_id': paymentUserId});
    body.addAll({'transaction_id': transactionId});

    final result = await settingsRepository.callInAppPayment(body, token);
    result.fold((error) {
      Helper.toastMsg(error.message);
      isBuying(false);
    }, (data) async {
      Helper.toastMsg(data);
      Get.back();
      Get.snackbar('Thank you for order', 'Thank you for purchasing from TCLI Library');
      // homeCardsController.getOnlyUserData();
      // Get.offAndToNamed(Routes.main);
      isBuying(false);
    });
  }

  Future<void> purchaseInit() async {
    if (Platform.isIOS) {
      try {
        await Purchases.configure(PurchasesConfiguration(apiKey)).whenComplete(() {
          print("In app Purchase Configuration done inspect");
        });
      } catch (e) {
        log('purchase init: $e');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    Purchases.setLogLevel(LogLevel.debug);
    purchaseInit();
    getToken();
    getPricing();
    if (Platform.isIOS) {
      fetchOffers();
    }
    // pageController.addListener(() {
    //   currentPage = pageController.page?.round() ?? 0;
    //   update();
    // });
  }

  void changePlan(value) {
    isAnnual.value = value;
    update();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getPricing() async {
    isLoading.value = true;
    final result = await settingsRepository.getPricing(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      pricingModelList = data;
      isLoading.value = false;
    });
  }
}
