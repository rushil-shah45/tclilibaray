import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/all_sale_book_api_response_model.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/make_book_payment_api_response.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/purchased_book_api_response_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/publisher_authors_model.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/payment/views/in_app_webview.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class AllBookForSaleScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController selectPublisherController = TextEditingController();
  TextEditingController selectAuthorController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController billingCityController = TextEditingController();
  TextEditingController billingStateController = TextEditingController();
  TextEditingController billingZipCodeController = TextEditingController();
  TextEditingController billingSelectedCountryController =
      TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var isLoading = false.obs;
  var isLoadingCountry = false.obs;
  UserProfileModel? userProfileModel;

  var allSaleBookList = <AllSaleBookResponseModel>[].obs;
  RxBool isPublisher = false.obs;
  var authorModel = <Author>[].obs;
  var publisherModel = <CategoryIdModel>[].obs;
  RxInt publisherId = 0.obs;
  RxInt authorId = 0.obs;
  Rx<List<CountryModel>> countryModel = Rx<List<CountryModel>>([]);
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxBool isPaging = true.obs;
  RxString countryCodeName = "AU".obs;
  var makingPayment = false.obs;

  RxInt page = 1.obs;

  var userItems = ["Personal", "Business"].obs;
  var userItemsSelected = ''.obs;

  var allPurchasedBookList = <PurchasedBookData>[].obs;
  var isLoadingPurchased = false.obs;

   
  var isFetchingMore = false.obs;

  void change(val, id) {
    selectPublisherController.text = val;
    publisherId.value = id;
    update();
  }

  void change2(val, id) {
    selectAuthorController.text = val;
    authorId.value = id;
    update();
  }

  void changeCountry(val) {
    billingSelectedCountryController.text = val;
  }




 

  Future<void> getCountryData() async {
    isLoadingCountry.value = true;
    SettingsRepository settingsRepository = Get.find<SettingsRepository>();
    final result = await settingsRepository.getCountryData();
    result.fold((error) {
      isLoadingCountry.value = false;
    }, (data) async {
      countryModel.value = data;
      log('Country Model :::: ${countryModel.value}');
      isLoadingCountry.value = false;
    });
  }


  //// Load more book 
  loadMoreBooks() async {
    if (!isFetchingMore.value) {
      isFetchingMore.value = true;
      page.value++; 
      await getAllBooksSaleData(loadMore : true ); 
      // isFetchingMore.value = false;
    }
  }

  /// Set User Data
  setUserdata() {
    nameController.text = "${userProfileModel?.billingName}";
    emailController.text = "${userProfileModel?.billingEmail}";
    billingAddressController.text = "${userProfileModel?.address}";
    billingCityController.text = "${userProfileModel?.city}";
    billingStateController.text = "${userProfileModel?.state}";
    billingZipCodeController.text = "${userProfileModel?.zipcode}";
    billingSelectedCountryController.text = "${userProfileModel?.country}";
    userItemsSelected.value = "${userProfileModel?.type}";
    dialCode.value = userProfileModel?.billingDialCode == ''
        ? ''
        : "${userProfileModel?.billingDialCode.substring(1)}";
    phoneController.text = "${userProfileModel?.billingPhone}";
    countryCodeName.value = "${userProfileModel?.billingCountryCode}";
    if (userProfileModel?.billingCountryCode != '') {
      Country country = CountryParser.parseCountryCode(
          "${userProfileModel?.billingCountryCode}");
      flagIcon.value = country.flagEmoji;
    } else {
      Country country =
          CountryParser.parseCountryCode(userProfileModel!.countryCode);
      flagIcon.value = country.flagEmoji;
      dialCode.value =
          dialCode.value == '' ? country.phoneCode : dialCode.value;
    }
  }

  getAllBooksSaleData({bool loadMore = false}) async {
    if (page.value == 1) {
      allSaleBookList.clear();
    }
    if(loadMore){
      isFetchingMore.value = true;
    }else {
    isLoading.value = true;
    }
      
    var token = sharedPreferences.getString("uToken");
    log('Token :::: $token');

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log("API URL :: ${RemoteUrls.baseUrl}books-for-sale/all?page=${page.value}&keyword=${searchController.text}&category=${publisherId.value}&author_id=${authorId.value}");

    final response = await http.get(
        Uri.parse(
            '${RemoteUrls.baseUrl}books-for-sale/all?page=${page.value}&keyword=${searchController.text}&category=${publisherId.value}&author_id=${authorId.value}'),
        headers: headers);

    log("Check status code ::: ${response.statusCode} ");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJsonBody = json.decode(response.body);
      log("Check status code 9999 ::: ${responseJsonBody['data']['books']['data']}");

      for (var book in responseJsonBody['data']['books']['data']) {
        allSaleBookList.add(AllSaleBookResponseModel.fromJson(book));
      }

      isLoading.value = false;
      isFetchingMore.value = false;
    } else {
      isLoading.value = false;
      isFetchingMore.value = false;
      throw Exception('Failed to load data');
    }
  }

  //// Get user Profile
  getUserProfile() async {
    var token = sharedPreferences.getString("uToken");
    final url = Uri.parse(RemoteUrls.userProfile);

    log('URL For Publisher: $url /// Token :::: $token');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    log('Response status: For category ${response.statusCode} ');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJsonBody = json.decode(response.body);
      var data = UserModel.fromMap(responseJsonBody['data']);
      userProfileModel = data.user;
      
      setUserdata();
      log('Response status: For category ${userProfileModel?.name}');
    } else {
      log('Error in API');
    }
  }


  Future<void> getPublisherData() async {
    var token = sharedPreferences.getString("uToken");
    final url = Uri.parse(RemoteUrls.publisherAndAuthor);

    log('URL For Publisher: $url /// Token :::: $token');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    log('Response status: For category ${response.statusCode} ');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJsonBody = json.decode(response.body);
      var author = responseJsonBody['data']['authors'];
      var publisher = responseJsonBody['data']['categories'];
      authorModel.clear();
      publisherModel.clear();

      for (var authorData in author) {
        authorModel.add(Author.fromJson(authorData));
      }
      for (var publisherData in publisher) {
        publisherModel.add(CategoryIdModel.fromJson(publisherData));
      }
    } else {}
  }

  /// Faviourit book
  storeFavouriteBook({required int id}) async {
    var token = sharedPreferences.getString("uToken");
    final url = Uri.parse('${RemoteUrls.baseUrl}books/$id/favorite/store');

    log('URL For favourite: $url /// Token :::: $token');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(url, headers: headers);
    log('Response status: For category ${response.statusCode} ///// ${response.body}');
    final Map<String, dynamic> responseJsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.snackbar("Success", responseJsonBody['msg']);
    } else {
      Get.snackbar("Success", responseJsonBody['error']);
    }
  }

  bool isBillingNameOkay() {
    if (nameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingEmailOkay() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingAddressOkay() {
    if (billingAddressController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingCityOkay() {
    if (billingCityController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingStateOkay() {
    if (billingStateController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingZipCodeOkay() {
    if (billingZipCodeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingCountryOkay() {
    if (billingSelectedCountryController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingTypeOkay() {
    if (userItemsSelected.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    RegExp regExp = RegExp(r'^[0-9]+$'); // Only allow digits
    return regExp.hasMatch(phoneNumber);
  }

  bool isBillingPhoneOkay() {
    String phoneNumber = phoneController.text.trim();
    if (phoneController.text.isNotEmpty && isPhoneNumberValid(phoneNumber)) {
      return true;
    }
    return false;
  }

  //// Make Payment
  Future<void> makePaypalPayment(String name, int bookId, String price, BuildContext context) async {
    SettingsRepository settingsRepository = Get.find<SettingsRepository>();
    var token = sharedPreferences.getString("uToken");
    if (isBillingNameOkay() &&
        isBillingEmailOkay() &&
        isBillingAddressOkay() &&
        isBillingCityOkay() &&
        isBillingStateOkay() &&
        isBillingZipCodeOkay() &&
        isBillingCountryOkay() &&
        isBillingTypeOkay() &&
        isBillingPhoneOkay()) {
      Map<String, dynamic> body = {
        'billing_name': nameController.text,
        'billing_email': emailController.text,
        'billing_country': billingSelectedCountryController.text,
        'billing_country_code': countryCodeName.value.trim(),
        'billing_dial_code': '+${dialCode.value.trim()}',
        'billing_phone': phoneController.text.trim(),
        'type': userItemsSelected.value.capitalizeFirst,
        'billing_address': billingAddressController.text,
        'billing_state': billingStateController.text,
        'billing_city': billingCityController.text,
        'billing_zipcode': billingZipCodeController.text,
        'payment_method': 'paypal',
        'transaction_id': '',
        'billing_for': 'book',
        'price': price,
      };

      makingPayment(true);

      final url = Uri.parse(RemoteUrls.makeBookPayment(bookId));

      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(url, headers: headers);
      log('Response status: For category ${response.statusCode}  ///// ${response.body}');

      if (response.statusCode == 200) {
        MakeBookPaymentApiResponseData responseData =
            MakeBookPaymentApiResponseData.fromJson(json.decode(response.body));

        Get.to(InAppWeb(
            url: responseData.data?.approveLink ?? '',
            onSuccess: (val) async {
              // makeSubscription(val);
              final result = await settingsRepository.buyBook(
                  body,
                  Get.find<LoginController>().userInfo?.accessToken ??
                      sharedPreferences.getString("uToken")!,
                  bookId);
              result.fold((error) {
                print(error);
                Get.snackbar("Failed", "Payment Status Update Failed!");
                EasyLoading.dismiss();
              }, (data) async {
                Get.snackbar("Success", data);
                Navigator.pop(context);
                EasyLoading.dismiss();
              });
            },
            onError: (val) {
              Get.snackbar('Warning', val.toString());
            },
            onCancel: (val) {
              Get.snackbar('Warning', val.toString());
            }));
        makingPayment(false);
      }
    } else if (!isBillingNameOkay()) {
      Get.snackbar('Billing name can\'t be empty', 'Please enter billing name');
      makingPayment.value = false;
    } else if (!isBillingEmailOkay()) {
      Get.snackbar(
          'Billing email can\'t be empty', 'Please enter billing email');
      makingPayment.value = false;
    } else if (!isBillingAddressOkay()) {
      Get.snackbar(
          'Billing address can\'t be empty', 'Please enter billing address');
      makingPayment.value = false;
    } else if (!isBillingCityOkay()) {
      Get.snackbar('Billing city can\'t be empty', 'Please enter billing city');
      makingPayment.value = false;
    } else if (!isBillingStateOkay()) {
      Get.snackbar(
          'Billing state can\'t be empty', 'Please enter billing state');
      makingPayment.value = false;
    } else if (!isBillingZipCodeOkay()) {
      Get.snackbar(
          'Billing zip code can\'t be empty', 'Please enter billing zip code');
      makingPayment.value = false;
    } else if (!isBillingCountryOkay()) {
      Get.snackbar('Billing country can\'t be empty',
          'Please select your billing country');
      makingPayment.value = false;
    } else if (!isBillingTypeOkay()) {
      Get.snackbar(
          'Billing type can\'t be empty', 'Please select your billing type');
      makingPayment.value = false;
    } else if (!isBillingPhoneOkay()) {
      Get.snackbar('Billing phone number is not valid',
          'Please valid billing phone number');
      makingPayment.value = false;
    }
  }

  //// Purchased Book

  getAllBooksPurchasedData() async {
    isLoadingPurchased.value = true;
    allPurchasedBookList.clear();
    var token = sharedPreferences.getString("uToken");
    log('Token :::: $token');

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log("API URL :: ${RemoteUrls.baseUrl}books-for-sale/purchased?page=1&keyword=${searchController.text}&category=${publisherId.value}&author_id=${authorId.value}");

    final response = await http.get(
        // Uri.parse('${RemoteUrls.baseUrl}books-for-sale/purchased'),
        Uri.parse('${RemoteUrls.baseUrl}books-for-sale/purchased?page=1&keyword=${searchController.text}&category=${publisherId.value}&author_id=${authorId.value}'),
        headers: headers);

    log("Check status code ::: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJsonBody = json.decode(response.body);
      if (responseJsonBody['data']['books'] != []) {
        var books = responseJsonBody['data']['books'];

      log('Response status: For purchased book : ${books}');
        if (books is List) {
          for (var book in books) {
            allPurchasedBookList.add(PurchasedBookData.fromJson(book));
          }
        }
        isLoadingPurchased.value = false;
      } else {
        isLoadingPurchased.value = false;
      }
    } else {
      isLoadingPurchased.value = false;
      throw Exception('Failed to load data');
    }
  }

  
}

class Author {
  int id;
  String name;
  String lastName;

  Author({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
      };
}
