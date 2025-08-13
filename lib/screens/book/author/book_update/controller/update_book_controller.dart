import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/error/exception.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

import '../../../../../main.dart';
import '../../add_book/models/category_model.dart';
import '../../mybooks/controller/my_book_controller.dart';
import '../component/update_book_page1.dart';
import '../component/update_book_page2.dart';

class UpdateBookController extends GetxController {
  final SettingsRepository settingsRepository;
  final LoginController loginController;

  UpdateBookController(this.settingsRepository, this.loginController);

  TextEditingController titleController = TextEditingController();
  TextEditingController youtubeUrlController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController publishYearController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController editionController = TextEditingController();
  TextEditingController isbnTenController = TextEditingController();
  TextEditingController isbnThreeController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController readingTimeController = TextEditingController();
  TextEditingController selectedCategoryOption = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();

  MyBookController myBookController = Get.find();
  Rx<List<CategoryModel>> categoryList = Rx<List<CategoryModel>>([]);
  Rxn<Book> bookModel = Rxn<Book>();
  Rx<List<String>> bookItems = Rx<List<String>>([]);
  Rx<List<String>> sizeItems = Rx<List<String>>([]);
  Rx<List<String>> distributionTypeList = Rx<List<String>>([]);
  RxString bookType = ''.obs;
  RxString sizeType = ''.obs;
  RxString distributionType = ''.obs;
  RxString categoryType = ''.obs;
  Rx<File> attachment = File('').obs;
  Rx<File> bookAttachment = File('').obs;
  RxString fileName = ''.obs;
  RxString bookFileName = ''.obs;
  RxBool booksStoreLoading = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;
  RxInt selectedCategoryId = 0.obs;
  DateTime selectedDate = DateTime.now();
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    bookItems.value = ['pdf', 'audio', 'video', 'url'];
    sizeItems.value = ['small', 'medium', 'large'];
    distributionTypeList.value = ['Book For Library', 'Book For Sale'];
    bookModel.value = Get.arguments;
    getCategoryList().then((value) {
      selectedCategoryId.value = bookModel.value!.categoryId;
      for (var category in categoryList.value) {
        if (category.id == selectedCategoryId.value) {
          selectedCategoryOption.text = category.name;
          break;
        }
      }
    });
    bookType.value = bookModel.value!.fileType;
    youtubeUrlController.text = bookModel.value!.fileDir;

    // Extract file name from the URL
    // Uri uri = Uri.parse(bookModel.value!.fileDir);
    // bookFileName.value = uri.pathSegments.last;
    //
    // Uri uris = Uri.parse(bookModel.value!.thumb);
    // fileName.value = uris.pathSegments.last;
    distributionType.value = bookModel.value?.bookFor == "library"
        ? distributionTypeList.value[0]
        : distributionTypeList.value[1];
    bookPriceController.text = bookModel.value?.bookPrice ?? "";
    bookModel.value!.bookPrice!=""?priceChange(bookModel.value!.bookPrice):null;
    titleController.text = bookModel.value!.title;
    subTitleController.text = bookModel.value!.subTitle;
    publisherController.text = bookModel.value!.publisher;
    publishYearController.text = bookModel.value!.publisherYear;
    editionController.text = bookModel.value!.edition;
    isbnTenController.text = bookModel.value!.isbn10;
    isbnThreeController.text = bookModel.value!.isbn13;
    pagesController.text = bookModel.value!.pages.toString();
    sizeType.value = bookModel.value!.size;
    descriptionController.text = bookModel.value!.description;
    readingTimeController.text = bookModel.value!.readingTime;
    selectedDate = DateTime(int.parse(bookModel.value!.publisherYear));
  }

  var token;

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  changeCategory(val, id) {
    selectedCategoryOption.text = val.toString();
    selectedCategoryId.value = id;
    update();
  }

  void changeBookTypeValue(val) {
    bookType.value = val;
    update();
  }

  void changeSizeItemValue(val) {
    sizeType.value = val;
    update();
  }

  void changeDistributionItemValue(val) {
    distributionType.value = val;
    update();
  }

  RxDouble vatResult = 0.0.obs;
  RxDouble resultWithoutVat = 0.0.obs;
  void priceChange(String value){
    if (value.isNotEmpty) {
      double valueDouble = double.parse(value.toString());
      double subtractedValue = valueDouble - (valueDouble * 0.05);
      vatResult.value = subtractedValue;
      resultWithoutVat.value = valueDouble - subtractedValue;
    }else{
      bookPriceController.clear();
    }
    update();
  }

  setThumbnailFile(File file) {
    attachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    fileName.value = path.replaceAll(parent, '');
  }

  setBookFile(File file) {
    bookAttachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    bookFileName.value = path.replaceAll(parent, '');
  }

  int pageIndex = 0;
  var pageController = PageController(
    initialPage: 0,
  );

  void changePage(int index) {
    pageIndex = index;
    update();
  }

  List<Widget> screenList = [
    const UpdateBookPageOne(),
    const UpdateBookPageTwo(),
  ];

  Future<void> getCategoryList() async {
    isLoading(true);
    final result = await settingsRepository.getCategoryList();
    result.fold((error) {
      Get.snackbar('Warning', error.message);
      isLoading.value = false;
    }, (data) async {
      categoryList.value = data;
      isLoading.value = false;
    });
  }

  bool isTitleOkay() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isCategoryOkay() {
    if (selectedCategoryOption.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPublisherOkay() {
    if (publisherController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPublisherYearOkay() {
    if (publishYearController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isDescriptionOkay() {
    if (descriptionController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
  bool isReadingTimeOkay() {
    if (readingTimeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
  bool isBookForOkay() {
    if (distributionType.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBookPriceOkay() {
    if (bookPriceController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isFileTypeOkay() {
    if (bookType.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isIsbnTenOkay() {
    if (isbnTenController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isThumbNailOkay() {
    if (attachment.value.path.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isVideoBookOkay() {
    if (bookType.value != 'url') {
      if (youtubeUrlController.text.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (bookAttachment.value.path.isNotEmpty) {
        return true;
      }
      return false;
    }
  }

  void newBookUpdate(context) async {
    booksStoreLoading(true);
    if (isTitleOkay() &&
        isCategoryOkay() &&
        isPublisherOkay() &&
        isPublisherYearOkay() &&
        isBookForOkay() &&
        (distributionType.value == 'Book For Sale' && isBookPriceOkay()) &&
        isDescriptionOkay() &&
        isFileTypeOkay() &&
        isIsbnTenOkay() &&
        (isReadingTimeOkay() || bookType.value!="pdf") &&
        isVideoBookOkay()) {
      File file = File(bookAttachment.value.path);
      File file2 = File(attachment.value.path);

      if (file.path.isNotEmpty || youtubeUrlController.text.trim().isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.booksUpdate(bookModel.value!.id));
        var request = http.MultipartRequest('POST', uri);

        if (file2.path.isNotEmpty) {
          request.files.add(http.MultipartFile.fromBytes(
              'thumb', file2.readAsBytesSync(),
              filename: file2.path));
        }

        if (bookType.value == 'pdf' && file.path.isNotEmpty) {
          request.files.add(http.MultipartFile.fromBytes(
              'pdf_book', file.readAsBytesSync(),
              filename: file.path));
        } else if (bookType.value == 'audio' && file.path.isNotEmpty) {
          request.files.add(http.MultipartFile.fromBytes(
              'audio_book', file.readAsBytesSync(),
              filename: file.path));
        } else if (bookType.value == 'video' && file.path.isNotEmpty) {
          request.files.add(http.MultipartFile.fromBytes(
              'video_book', file.readAsBytesSync(),
              filename: file.path));
        } else if (bookType.value == 'url') {
          request.fields['url_book'] = youtubeUrlController.text.trim();
        }

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] =
            'Bearer ${loginController.userInfo?.accessToken ?? token}';

        request.fields['title'] = titleController.text.trim();
        request.fields['sub_title'] = subTitleController.text.trim();
        request.fields['category_id'] = selectedCategoryId.value.toString();
        request.fields['file_type'] = bookType.value;
        request.fields['isbn10'] = isbnTenController.text.trim();
        request.fields['isbn13'] = isbnThreeController.text.trim();
        request.fields['publisher'] = publisherController.text.trim();
        request.fields['size'] = sizeType.value.trim();
        if (bookType.value != 'url') {
          request.fields['pages'] = pagesController.text.trim();
        }
        request.fields['edition'] = editionController.text.trim();
        request.fields['publisher_year'] = publishYearController.text.trim();
        request.fields['description'] = descriptionController.text.trim();
        request.fields['reading_time'] = readingTimeController.text.trim();
        request.fields['book_for'] = distributionType.value=='Book For Library'
            ? "library"
            : "sale";
        request.fields['book_price'] = distributionType.value=='Book For Library'
            ? ""
            : bookPriceController.text.trim();

        return request.send().then((value) {
          if (value.statusCode == 200) {
            value.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((event) async {
              final jsonData = json.decode(event);
              print("BodyData: ${request.fields}");
              print("Response Data: ${jsonData}");
              if (jsonData['status']) {
                myBookController.getMyBook();
                Get.back();
                Get.snackbar('Success', 'Book Updated Successfully !');
                booksStoreLoading.value = false;
              } else {
                final errorMsg = jsonData["message"];
                Get.snackbar('Warning', errorMsg.message);
                booksStoreLoading.value = false;
                throw UnauthorisedException(errorMsg, value.statusCode);
              }
            });
          } else {
            Get.snackbar('No Internet', value.statusCode.toString());
            booksStoreLoading.value = false;
            throw UnauthorisedException('No Internet', value.statusCode);
          }
        });
      } else {
        Get.snackbar('File upload not success', 'Please try again');
        booksStoreLoading(false);
      }
    } else if (!isTitleOkay()) {
      Get.snackbar('Title can\'t be empty', 'Please enter your title');
      booksStoreLoading(false);
    } else if (!isCategoryOkay()) {
      Get.snackbar('Category can\'t be empty', 'Please choose your category');
      booksStoreLoading(false);
    } else if (!isPublisherOkay()) {
      Get.snackbar('Publisher can\'t be empty', 'Please enter publisher');
      booksStoreLoading(false);
    } else if (!isPublisherYearOkay()) {
      Get.snackbar('Publisher year can\'t be empty',
          'Please select your publisher year');
      booksStoreLoading(false);
    } else if (!isReadingTimeOkay()) {
      Get.snackbar(
          'Reading time can\'t be empty', 'Please enter your reading time');
      booksStoreLoading(false);
    }  else if (!isBookForOkay()) {
      Get.snackbar('Book distribution can\'t be empty',
          'Please select book distribution');
      booksStoreLoading(false);
    } else if (distributionType.value == "Book For Sale" && !isBookPriceOkay()) {
      Get.snackbar('Book price can\'t be empty',
          'Please enter book price');
      booksStoreLoading(false);
    } else if (!isDescriptionOkay()) {
      Get.snackbar(
          'Description can\'t be empty', 'Please enter your description');
      booksStoreLoading(false);
    } else if (!isFileTypeOkay()) {
      Get.snackbar('File type can\'t be empty', 'Please enter your file type');
      booksStoreLoading(false);
    } else if (!isIsbnTenOkay()) {
      Get.snackbar('Isbn10 can\'t be empty', 'Please enter your Isbn10');
      booksStoreLoading(false);
    } else if (!isVideoBookOkay()) {
      if (bookType.value != 'url') {
        Get.snackbar(
            'Book type can\'t be empty', 'Please select your book type');
        booksStoreLoading(false);
      } else {
        Get.snackbar(
            'Youtube link can\'t be empty', 'Please enter your youtube link');
        booksStoreLoading(false);
      }
    }
  }
}
