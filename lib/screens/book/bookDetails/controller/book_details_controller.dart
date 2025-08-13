import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/book_details_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

import '../models/read_page_response_model.dart';

class BookDetailsController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;
  ReadPageResponseModel? readPageResponseModel;

  BookDetailsController(
      this.bookRepository, this.loginController, this.mainController);

  Rxn<BookDetailsModel> bookDetails = Rxn<BookDetailsModel>();
  RxBool isLoading = false.obs;
  RxBool isReviewDelete = false.obs;
  RxBool submitBtnIsLoading = false.obs;
  RxBool ratingUpdateLoading = false.obs;
  final reviewTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxDouble ratingValue = 0.0.obs;
  var token;
  int id = 0;
  int isBookForSale = 0;
  bool isTablet = Get.width >= 600;
  int readPercentage = 0;

  @override
  void onInit() {
    super.onInit();
    getToken();
    log("Check Argumenr : ${Get.arguments} //// ${Get.arguments[0]} //// $isBookForSale");
    id = Get.arguments[0];
isBookForSale = Get.arguments[1] == "isBookForSale" ? 1 : 0;

    getBookDetails();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  ///PDF read Api calling mechanism
  Future<void> readPage(int progressID, int page, int totalPage) async {
    final result = await bookRepository.readPage(
        token, progressID.toString(), page, totalPage);
    result.fold((error) {
      print(error.message);
      Get.snackbar('Warning', error.message);
    }, (data) async {
      readPageResponseModel = data;
    });
  }

  ///PDF Audio Video progress percentage Api calling mechanism
  Future<void> readPageProgress(int progressID, int page, int stayTime) async {
    final result = await bookRepository.readPageProgress(
        token, progressID.toString(), page, stayTime);
    result.fold((error) {
      print(error.message);
      Get.snackbar('Warning', error.message);
    }, (data) async {});
  }

  ratingChange(value) {
    ratingValue.value = value;
    update();
  }

  Future<void> getBookDetails() async {
    isLoading.value = true;
    final result = await bookRepository.getBookDetails(
        loginController.userInfo?.accessToken ?? token, id, isBookForSale);
    result.fold((error) {
      Get.snackbar('Warning', error.message);
      isLoading.value = false;
    }, (data) async {
      bookDetails.value = data;
      isLoading.value = false;
    });
  }

  Future<void> getBookDetailsAdded() async {
    final result = await bookRepository.getBookDetails(
        loginController.userInfo?.accessToken ?? token, id, isBookForSale);
    result.fold((error) {
      Get.snackbar('Warning', error.message);
    }, (data) async {
      bookDetails.value = data;
    });
  }

  bool isRatingOkay() {
    return ratingValue.value > 0;
  }

  bool isReviewTextOkay() {
    if (reviewTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> ratingSubmit(int id) async {
    submitBtnIsLoading(true);
    if (isRatingOkay() && isReviewTextOkay()) {
      Map<String, dynamic> body = {
        'book_id': id.toString(),
        'rating': ratingValue.value.toStringAsFixed(0),
        'review': reviewTextController.text.trim(),
      };

      submitBtnIsLoading.value = true;
      final result = await bookRepository.ratingSubmit(
          body, loginController.userInfo?.accessToken ?? token);
      result.fold((error) {
        print(error.message);
        Get.snackbar('Warning', error.message);
        submitBtnIsLoading.value = false;
      }, (data) async {
        Get.snackbar('Success', data);
        getBookDetailsAdded();
        reviewTextController.clear();
        submitBtnIsLoading.value = false;
      });
    } else if (!isRatingOkay()) {
      Get.snackbar('Rating can\'t be empty', 'Please select your rating');
      submitBtnIsLoading(false);
    } else if (!isReviewTextOkay()) {
      Get.snackbar('Review can\'t be empty', 'Please enter your review');
      submitBtnIsLoading(false);
    }
  }

  Future<void> updateRating(String id) async {
    if (isRatingOkay() && isReviewTextOkay()) {
      Map<String, dynamic> body = {
        'book_id': id.toString(),
        'rating': ratingValue.value.toStringAsFixed(0),
        'review': reviewTextController.text.trim(),
      };

      ratingUpdateLoading.value = true;
      final result = await bookRepository.ratingSubmit(body, token);
      result.fold((error) {
        print(error.message);
        Get.snackbar('Warning', error.message);
        ratingUpdateLoading.value = false;
      }, (data) async {
        Get.snackbar('Success', data);
        getBookDetailsAdded();
        reviewTextController.clear();
        ratingUpdateLoading.value = false;
      });
    } else if (!isRatingOkay()) {
      Get.snackbar('Rating can\'t be empty', 'Please select your rating');
      ratingUpdateLoading(false);
    } else if (!isReviewTextOkay()) {
      Get.snackbar('Review can\'t be empty', 'Please enter your review');
      ratingUpdateLoading(false);
    }
  }

  Future<void> deleteReview(String id) async {
    isReviewDelete.value = true;
    final result = await bookRepository.deleteReview(token, id);
    result.fold((error) {
      print(error.message);
      isReviewDelete.value = false;
      Get.snackbar("Warning", error.message);
    }, (data) async {
      getBookDetailsAdded();
      Get.snackbar("Success", data);
      isReviewDelete.value = false;
    });
  }

  String getBookStatus(BookDetailsModel bookDetailsModel) {
    if (bookDetailsModel.book.status == "0") {
      return 'Pending';
    } else if (bookDetailsModel.book.status == "10") {
      return 'Published';
    } else if (bookDetailsModel.book.status == "20") {
      return 'Unpublished';
    } else if (bookDetailsModel.book.status == "30") {
      return 'Rejected';
    } else if (bookDetailsModel.book.status == "40") {
      return 'Expired';
    } else if (bookDetailsModel.book.status == "50") {
      return 'Deleted';
    } else {
      return 'Unknown Status';
    }
  }
}
