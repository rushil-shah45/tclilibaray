import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/error/exception.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

import '../../../../../main.dart';
import '../../../../auth/login/controller/login_controller.dart';
import '../../mybooks/controller/my_book_controller.dart';
import '../component/add_book_page1.dart';
import '../component/add_book_page2.dart';
import '../models/category_model.dart';

class AddBookController extends GetxController {
  final LoginController loginController;
  final SettingsRepository settingsRepository;
  final AuthorBookController authorBookController;

  AddBookController(
      this.settingsRepository, this.loginController, this.authorBookController);

  final titleController = TextEditingController();
  final youtubeUrlController = TextEditingController();
  final subTitleController = TextEditingController();
  final publisherController = TextEditingController();
  final publishYearController = TextEditingController();
  final authorController = TextEditingController();
  final editionController = TextEditingController();
  final isbnTenController = TextEditingController();
  final isbnThreeController = TextEditingController();
  final pagesController = TextEditingController();
  final descriptionController = TextEditingController();
  final readingTimeController = TextEditingController();
  final bookPriceController = TextEditingController();
  final selectedCategoryOption = TextEditingController();
  MyBookController myBookController = Get.find();
  Rx<List<CategoryModel>> categoryList = Rx<List<CategoryModel>>([]);
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
  var token;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    bookItems.value = ['pdf', 'audio', 'video', 'url'];
    sizeItems.value = ['Small', 'Medium', 'Large'];
    distributionTypeList.value = ['Book For Library', 'Book For Sale'];
    getCategoryList();
    some(text);
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  RxString text = "".obs;

  void some(text) {
    if (bookType.value == "pdf") {
      text.value = "In PDF";
    } else if (bookType.value == "audio") {
      text.value = "In Audio";
    } else if (bookType.value == "video") {
      text.value = "In Video";
    } else if (bookType.value == "url") {
      text.value = "Video url";
    }
    update();
  }

  changeCategory(val, id) {
    selectedCategoryOption.text = val.toString();
    selectedCategoryId.value = id;
    update();
  }

  void changeBookItemValue(val) {
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
  setThumbnail(File file) {
    attachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    fileName.value = path.replaceAll(parent, '');
  }

  setFileBookType(File file) {
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
    const AddBookPageOne(),
    const AddBookPageTwo(),
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

  bool isBookType() {
    if (bookType.value != "") {
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

  bool isTitleOkay() {
    if (titleController.text.isNotEmpty) {
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
  bool isReadingOkay() {
    if (readingTimeController.text.isNotEmpty) {
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

  bool isBookFileOkay() {
    if (bookType.value != 'url') {
      if (bookAttachment.value.path.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (youtubeUrlController.text.isNotEmpty) {
        return true;
      }
      return false;
    }
  }

  void newBookStore() async {
    // print("askdjhfdkjasf ${isReadingOkay()}");
    // print("askdjhfdkjasf ${isBookFileOkay()}");
    booksStoreLoading(true);
    if ( isTitleOkay() && isCategoryOkay()&&
        isIsbnTenOkay() &&
        isPublisherOkay() &&
        isPublisherYearOkay() &&
        isDescriptionOkay() &&
        isThumbNailOkay()) {

      File file = File(bookAttachment.value.path);
      File file2 = File(attachment.value.path);

      if (file.path.isNotEmpty || youtubeUrlController.text.trim().isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.booksStore);
        print("Add Book URI:$uri");
        var request = http.MultipartRequest('POST', uri);

        request.files.add(http.MultipartFile.fromBytes(
            'thumb', file2.readAsBytesSync(),
            filename: file2.path));

        if (bookType.value == 'pdf') {
          if(isBookType() && isBookForOkay() &&
              (distributionType.value == 'Book For Sale'? isBookPriceOkay(): true)  && isReadingOkay() && isBookFileOkay()
          ) {
            request.files.add(http.MultipartFile.fromBytes(
                'pdf_book', file.readAsBytesSync(),
                filename: file.path));
          }
        } else if (bookType.value == 'audio') {


          // Read the file bytes
          Uint8List fileBytes = await file.readAsBytes();

          // Create a multipart file
          http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'audio_book', // Field name for the file
            fileBytes,
            filename: path.basename(file.path),
            contentType: MediaType('audio', 'mp3'), // Set the content type
          );

          // Create a multipart request
          request.files.add(multipartFile);







          //

          // request.files.add(http.MultipartFile.fromBytes(
          //     'audio_book',  file.readAsBytesSync(),
          //     filename: file.path));
        } else if (bookType.value == 'video') {
          request.files.add(http.MultipartFile.fromBytes(
              'video_book', file.readAsBytesSync(),
              filename: file.path)  );
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
        request.fields['book_for'] = distributionType.value=='Book For Library'?"library":"sale";
        request.fields['book_price'] = bookPriceController.text.trim()??"";
        print("Add Books Request Data: ${jsonEncode(request.fields)}");
       // final extension = path.extension(file.path).toLowerCase();
        //print("fileExtention: $extension}");
        // if (extension != '.mp3') {
        //   throw Exception('The file must be an MP3');
        // }



        return request.send().then((value) {
      //    print(" headers: ${request.headers.toString()}");
          if (value.statusCode == 200) {
            value.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((event) async {
              final jsonData = json.decode(event);
              print("Response Data: ${jsonData}");
              if (jsonData['status']) {
                myBookController.getMyBook();
                authorBookController.getMyBook();
                Get.back();
                Get.snackbar('Success', 'Book Created Successfully!');
                booksStoreLoading.value = false;
              } else {
                final errorMsg = jsonData["msg"];
                Get.snackbar('Warning', errorMsg);
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
    } else if (!isBookType()) {
      Get.snackbar('Book type can\'t be empty', 'Please select book type');
      booksStoreLoading(false);
    } else if (!isBookFileOkay()) {
      if (bookType.value != 'url') {
        Get.snackbar(
            'Book file can\'t be empty', 'Please select your book file');
        booksStoreLoading(false);
      } else {
        Get.snackbar(
            'Youtube link can\'t be empty', 'Please enter your youtube link');
        booksStoreLoading(false);
      }
    } else if (!isThumbNailOkay()) {
      Get.snackbar('Thumbnail can\'t be empty', 'Please select your thumbnail');
      booksStoreLoading(false);
    } else if (!isCategoryOkay()) {
      Get.snackbar('Category can\'t be empty', 'Please choose your category');
      booksStoreLoading(false);
    } else if (!isTitleOkay()) {
      Get.snackbar('Title can\'t be empty', 'Please enter your title');
      booksStoreLoading(false);
    } else if (!isIsbnTenOkay()) {
      Get.snackbar('Isbn10 can\'t be empty', 'Please enter your Isbn10');
      booksStoreLoading(false);
    } else if (!isPublisherOkay()) {
      Get.snackbar('Publisher can\'t be empty', 'Please enter publisher');
      booksStoreLoading(false);
    } else if (!isPublisherYearOkay()) {
      Get.snackbar('Publisher year can\'t be empty',
          'Please select your publisher year');
      booksStoreLoading(false);
    } else if (!isBookForOkay()) {
      Get.snackbar('Book distribution can\'t be empty',
          'Please select book distribution');
      booksStoreLoading(false);
    } else if (distributionType.value=="Book For Sale" && !isBookPriceOkay()) {
      Get.snackbar('Book price can\'t be empty',
          'Please enter book price');
      booksStoreLoading(false);
    } else if (!isDescriptionOkay()) {
      Get.snackbar(
          'Description can\'t be empty', 'Please enter your description');
      booksStoreLoading(false);
    } else if (!isReadingOkay()) {
      Get.snackbar(
          'Reading time can\'t be empty', 'Please enter your reading time');
      booksStoreLoading(false);
    }
  }
}
