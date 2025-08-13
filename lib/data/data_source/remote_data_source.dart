import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/models/settings_response_model.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/model/register_model.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/book_details_model.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/read_page_response_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/publisher_authors_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/models/borrowed_models.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/model/club_details_model.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/models/post_details_model.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/model/club_model.dart';
import 'package:tcllibraryapp_develop/screens/faq/model/faq_model.dart';
import 'package:tcllibraryapp_develop/screens/main/model/custom_page.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/notification/model/notification_model.dart';
import 'package:tcllibraryapp_develop/screens/pricing/model/pricing_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_details_model.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_model.dart';
import 'package:tcllibraryapp_develop/screens/transaction/models/transaction_model.dart';

import '../../screens/book/author/add_book/models/books_store_model.dart';
import '../../screens/book/author/add_book/models/category_model.dart';
import '../../screens/book/author/analytics/models/analytics_model.dart';
import '../../screens/book/author/my_readers/models/my_readers_model.dart';
import '../../screens/book/library/allBooks/models/books_model.dart';
import '../error/exception.dart';
import '../remote_urls.dart';

abstract class RemoteDataSource {
  Future<UserRegisterModel> signIn(Map<String, dynamic> body);

  Future<UserRegisterModel> socialLogin(Map<String, dynamic> body);

  Future<String> forgotPassword(Map<String, dynamic> body);

  Future<UserRegisterModel> userRegister(Map<String, dynamic> body);

  Future<SettingsResponseModel> getSettingsData();
  Future<UserModel> getUserProfile(String token);

  Future<List<TicketModel>> getUserTicket(String token);

  Future<String> createUserTicket(Map<String, dynamic> body, String token);

  Future<String> deleteUserTicket(String token, String id);

  Future<TicketDetailsModel> getUserTicketDetails(String id, String token);

  Future<String> userTicketReply(Map<String, dynamic> body, String token);

  Future<BooksModel> getPendingBook(String token);

  Future<BooksModel> getDeclineBook(String token);

  Future<BooksModel> getMyBook(String token);

  Future<MyReadersModel> getMyReaders(String token);

  Future<AllBookModel> getAllBooksData(String token, int page, String search, String category, String author);
  Future<AllBookModel> getAllBooksDataForBookOfMonth(String token, int page, String search, String category, String author);

  Future<PublisherAndAuthorModel> getPublisherData(String token);

  Future<FavouriteModel> getFavouriteBooksData(String token, int page);

  Future<String> storeFavouriteBook(String token, int id);

  Future<String> storeBorrowBook(String token, int id);

  Future<BorrowedModel> getBorrowedBooksData(String token);

  Future<dynamic> getDashboardData(String token);

  Future<AnalyticsModel> getAnalyticsData(String token, String id);

  Future<List<CategoryModel>> getCategoryList();

  Future<List<CountryModel>> getCountryData();

  Future<ClubModel> getClub(String token);

  Future<String> makePaypalPayment(Map<String, dynamic> body, String token, int id);

  Future<String> buyBook(Map<String, dynamic> body, String token, int id);

  Future<String> makeFreePayment(Map<String, dynamic> body, String token, int id);

  Future<String> makeSubscription(String endPoint, String token);

  Future<String> flutterWaveApi(Map<String, dynamic> body, String token);

  Future<PostDetailsModel> getPostDetails(String token, int id);

  Future<ClubDetailsModel> getClubDetails(String token, String id);

  Future<bool> postReply(String token, Map<String, dynamic> body);

  Future<BookStoreModel> updateBooks(String token, int id, Map<String, dynamic> body);

  Future<String> deleteBook(String token, String id);

  Future<BookDetailsModel> getBookDetails(String token, int id, int isBookForSale);

  Future<String> deleteReview(String token, String id);

  Future<String> updatePassword(Map<String, dynamic> body, String token);

  Future<String> updateProfile(Map<String, dynamic> body, String token);

  Future<bool> createTopic(String token, Map<String, dynamic> body);

  Future<ReadPageResponseModel> readPagePdf(String token, String id, int page, int stayTime);

  Future<String> readPageProgress(String token, String id, int page, int stayTime);

  Future<String> ratingSubmit(Map<String, dynamic> body, String token);

  Future<List<PricingModel>> getPricing(String token);

  Future<String> deleteAccount(String token);

  Future<List<FaqModel>> getFaqList();

  Future<List<CustomPageModel>> getPrivacyTermsConditions();

  Future<String> joinClub(String token, String id);

  Future<String> leaveClub(String token, String id);

  Future<String> memberStatusChange(String token, String id, String status);

  Future<List<Notifications>> getNotifications(String token);

  Future<List<TransactionModel>> getTransaction(String token);

  Future<String> readNotifications(String token, String id);

  Future<String> applyPromoCode(String token, Map<String, dynamic> body);

  Future<String> billingInformationPost(String token, Map<String, dynamic> body);

  Future<String> callInAppPayment(Map<String, dynamic> body, String token);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  final _className = 'RemoteDataSourceImpl';

  RemoteDataSourceImpl({required this.client});

  Future<dynamic> callClientWithCatchException(CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
        print(response.body);
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException('Please check your \nInternet Connection', 10061);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  ///User Registration
  @override
  Future<UserRegisterModel> userRegister(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userRegistration);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    // return UserRegisterModel.fromMap(responseJsonBody['data']);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
    {
      return UserRegisterModel.fromMap(responseJsonBody['data']);
    }
  }

  ///User Login
  @override
  Future<UserRegisterModel> signIn(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    // return UserRegisterModel.fromMap(responseJsonBody['data']);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
    {
      return UserRegisterModel.fromMap(responseJsonBody['data']);
    }
  }

  @override
  Future<UserRegisterModel> socialLogin(Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.socialLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    print("SocialLogInResponse: $responseJsonBody");
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserRegisterModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///User Login
  @override
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final headers = {
      'Accept': 'application/json',
    };
    final uri = Uri.parse(RemoteUrls.forgotPassword);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///User Profile
  @override
  Future<SettingsResponseModel> getSettingsData() async {
    final url = Uri.parse(RemoteUrls.settings);
    final headers = {
      'Accept': 'application/json',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);

    print("SettingsData: $responseJsonBody");
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return settingsResponseModelFromJson(responseJsonBody);
    }
  }

  ///User Profile
  @override
  Future<UserModel> getUserProfile(String token) async {
    final url = Uri.parse(RemoteUrls.userProfile);
    print("Profile url: $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return UserModel.fromMap(responseJsonBody['data']);
    }
  }

  @override
  Future<ClubModel> getClub(String token) async {
    final url = Uri.parse(RemoteUrls.getClub);

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);

    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return ClubModel.fromJson(responseJsonBody['data']);
  }

  @override
  Future<String> makeSubscription(String endPoint, String token) async {
    final url = Uri.parse(endPoint);

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);

    final responseJsonBody = await callClientWithCatchException(() => clientMethod);

    return responseJsonBody['msg'];
  }

  @override
  Future<String> buyBook(Map<String, dynamic> body, String token, id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Uri uri = Uri.parse(RemoteUrls.buyBook(id));
    log("Request URL : $uri");
    log("Request body: ${jsonEncode(body)}");
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    log("Response body: ${jsonEncode(responseJsonBody).toString()}");
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['msg'];
    }
  }

  @override
  Future<String> makePaypalPayment(Map<String, dynamic> body, String token, id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Uri uri = Uri.parse(RemoteUrls.makePaypalPayment(id));
    print("Make Payment Url: $uri");
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['data']['ApproveLink'] != null ? responseJsonBody["data"]['ApproveLink'].toString() : responseJsonBody['msg'];
    }
  }

  @override
  Future<String> makeFreePayment(Map<String, dynamic> body, String token, id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Uri uri = Uri.parse(RemoteUrls.makePaypalPayment(id));
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody['msg'];
    }
  }

  @override
  Future<String> flutterWaveApi(Map<String, dynamic> body, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Uri uri = Uri.parse(RemoteUrls.flutterWaveApi);
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["data"];
    }
  }

  @override
  Future<PostDetailsModel> getPostDetails(String token, int id) async {
    final url = Uri.parse(RemoteUrls.getPostDetails(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);

    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return PostDetailsModel.fromJson(responseJsonBody['data']);
  }

  @override
  Future<ClubDetailsModel> getClubDetails(String token, String id) async {
    final url = Uri.parse(RemoteUrls.getClubDetails(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return ClubDetailsModel.fromJson(responseJsonBody['data']);
  }

  ///Get User Ticket
  @override
  Future<List<TicketModel>> getUserTicket(String token) async {
    final url = Uri.parse(RemoteUrls.getUserTicket);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]).map((e) => TicketModel.fromMap(e)).toList();
    }
  }

  ///Create User Ticket
  @override
  Future<String> createUserTicket(Map<String, dynamic> body, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Uri uri = Uri.parse(RemoteUrls.createUserTicket);
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Delete User Ticket
  @override
  Future<String> deleteUserTicket(String token, String id) async {
    final url = Uri.parse(RemoteUrls.deleteUserTicket(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Get User Ticket Details
  @override
  Future<TicketDetailsModel> getUserTicketDetails(String id, String token) async {
    final url = Uri.parse(RemoteUrls.getUserTicketDetails(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return TicketDetailsModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Get User Ticket Details
  @override
  Future<String> userTicketReply(Map<String, dynamic> body, String token) async {
    final url = Uri.parse(RemoteUrls.userTicketReplay);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Get Pending Books
  @override
  Future<BooksModel> getPendingBook(String token) async {
    final url = Uri.parse(RemoteUrls.pendingBook);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return BooksModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Get Decline Books
  @override
  Future<BooksModel> getDeclineBook(String token) async {
    final url = Uri.parse(RemoteUrls.declineBook);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return BooksModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Get My Books
  @override
  Future<BooksModel> getMyBook(String token) async {
    final url = Uri.parse(RemoteUrls.myBook);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return BooksModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Get My Readers
  @override
  Future<MyReadersModel> getMyReaders(String token) async {
    final url = Uri.parse(RemoteUrls.myReadersBook);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return MyReadersModel.fromJson(responseJsonBody["data"]);
    }
  }

  ///Get All Books
  @override
  Future<AllBookModel> getAllBooksData(String token, int page, String search, String category, String author) async {
    final url = Uri.parse(RemoteUrls.allBook(page, search, category, author));

    print("getAllBooksData: $url");

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return AllBookModel.fromMap(responseJsonBody["data"]);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///// ForBookOfMonth
  @override
  Future<AllBookModel> getAllBooksDataForBookOfMonth(String token, int page, String search, String category, String author) async {
    final url = Uri.parse(RemoteUrls.allBookForBookOfMonth(page, search, category, author));

    print("getAllBooksData For Book Of The Month: $url");

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return AllBookModel.fromMap(responseJsonBody["data"]);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Get All Publisher and Authors
  @override
  Future<PublisherAndAuthorModel> getPublisherData(String token) async {
    final url = Uri.parse(RemoteUrls.publisherAndAuthor);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return PublisherAndAuthorModel.fromJson(responseJsonBody["data"]);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Get Favourite Books
  @override
  Future<FavouriteModel> getFavouriteBooksData(String token, int page) async {
    final url = Uri.parse(RemoteUrls.favouriteBook(page));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return FavouriteModel.fromMap(responseJsonBody["data"]);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Store Favourite Books
  @override
  Future<String> storeFavouriteBook(String token, int id) async {
    final url = Uri.parse(RemoteUrls.favouriteBookStore(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return responseJsonBody["msg"];
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Store Borrow Books
  @override
  Future<String> storeBorrowBook(String token, int id) async {
    final url = Uri.parse(RemoteUrls.borrowedBookStore(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return responseJsonBody["msg"];
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Get Favourite Books
  @override
  Future<BorrowedModel> getBorrowedBooksData(String token) async {
    final url = Uri.parse(RemoteUrls.borrowedBook);
    print("Get borrow book $url");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return BorrowedModel.fromMap(responseJsonBody["data"]);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Get Dashboard data
  @override
  Future<dynamic> getDashboardData(String token) async {
    final url = Uri.parse(RemoteUrls.dashboard);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["data"];
    }
  }

  ///Get Analytics Dashboard data
  @override
  Future<AnalyticsModel> getAnalyticsData(String token, String id) async {
    final url = Uri.parse(RemoteUrls.analytics(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return AnalyticsModel.fromMap(responseJsonBody["data"]);
    }
  }

  ///Post Books update
  @override
  Future<BookStoreModel> updateBooks(String token, int id, Map<String, dynamic> body) {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.parse(RemoteUrls.booksUpdate(id));

    return http.post(uri, headers: headers, body: body).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        print(jsonData);
        if (jsonData['success']) {
          BookStoreModel bookStoreModel = BookStoreModel.fromJson(jsonData['data']);
          return bookStoreModel;
        } else {
          final errorMsg = jsonData["message"];
          throw UnauthorisedException(errorMsg, value.statusCode);
        }
      } else {
        throw UnauthorisedException('No Internet', value.statusCode);
      }
    });
  }

  ///Get Category
  @override
  Future<List<CategoryModel>> getCategoryList() {
    final headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};

    Uri uri = Uri.parse(RemoteUrls.category);
    return http.get(uri, headers: headers).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        if (jsonData['data'] is List) {
          print("{Category Data: $jsonData}");

          List<dynamic> categories = jsonData['data'];
          List<CategoryModel> categoryList = categories.map((category) => CategoryModel.fromJson(category)).toList();
          return categoryList;
        } else {
          final errorMsg = jsonData["msg"];
          throw UnauthorisedException(errorMsg, value.statusCode);
        }
      } else if (value.statusCode == value.statusCode) {
        throw UnauthorisedException('Unauthenticated', value.statusCode);
      } else {
        throw UnauthorisedException('No Internet', value.statusCode);
      }
    });
  }

  ///Get Country data
  @override
  Future<List<CountryModel>> getCountryData() async {
    final url = Uri.parse(RemoteUrls.countryData);
    final clientMethod = client.get(url);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    //TODO: UNCOMMENT  LOG FOR COUNTRY MODEL
    // log("check country model data ::: $responseJsonBody //// url :: $url");
    List<dynamic> country = responseJsonBody;
    List<CountryModel> countryList = country.map((category) => CountryModel.fromJson(category)).toList();
    return countryList;
  }

  ///Delete User Ticket
  @override
  Future<String> deleteBook(String token, String id) async {
    final url = Uri.parse(RemoteUrls.deleteBook(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Get BookDetails
  @override
  Future<BookDetailsModel> getBookDetails(String token, int id, int isBookForSale) async {
    log(token);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse(RemoteUrls.viewBookDetails(id, isBookForSale));
    print("Book details: $url");
    return http.get(url, headers: headers).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        log("jsonData ==> $jsonData");
        if (jsonData['status']) {
          BookDetailsModel bookDetailsModel = BookDetailsModel.fromJson(jsonData['data']);
          return bookDetailsModel;
        } else {
          final errorMsg = jsonData["msg"];
          throw UnauthorisedException(errorMsg, value.statusCode);
        }
      } else if (value.statusCode == value.statusCode) {
        throw UnauthorisedException('Unauthenticated', value.statusCode);
      } else {
        throw UnauthorisedException('No Internet', value.statusCode);
      }
    });
  }

  ///Delete User Book Review
  @override
  Future<String> deleteReview(String token, String id) async {
    final url = Uri.parse(RemoteUrls.deleteReview(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Update Password
  @override
  Future<String> updatePassword(Map<String, dynamic> body, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(RemoteUrls.updatePassword);
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return responseJsonBody["message"];
    // if (responseJsonBody["status"] == false) {
    //   final errorMsg = responseJsonBody["message"];
    //   throw UnauthorisedException(errorMsg, 401);
    // } {
    //   return UserRegisterModel.fromMap(responseJsonBody);
    // }
  }

  @override
  Future<bool> postReply(String token, Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};

    final uri = Uri.parse(RemoteUrls.postReply);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return responseJsonBody["status"];
  }

  @override
  Future<bool> createTopic(String token, Map<String, dynamic> body) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};

    final uri = Uri.parse(RemoteUrls.createTopic);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    return responseJsonBody["status"];
  }

  @override
  Future<String> updateProfile(Map<String, dynamic> body, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(RemoteUrls.updateProfile);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return responseJsonBody["msg"];
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Rating
  @override
  Future<String> ratingSubmit(Map<String, dynamic> body, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(RemoteUrls.ratingSubmit);
    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return responseJsonBody["msg"];
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Read Page
  @override
  Future<ReadPageResponseModel> readPagePdf(String token, String id, int page, int totalPage) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {};
    body.addAll({"page": "$page"});
    body.addAll({"total_page": "$totalPage"});

    final url = Uri.parse(RemoteUrls.readPage(id));
    print("Book progress: $url");
    print("Book progress: $body");

    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      log("Read Page Response: $responseJsonBody");
      return ReadPageResponseModel.fromJson(responseJsonBody);
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Progress
  @override
  Future<String> readPageProgress(String token, String id, int page, int stayTime) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {};
    body.addAll({"page": "$page"});
    body.addAll({"page_stay_time": "$stayTime"});

    final url = Uri.parse(RemoteUrls.pageProgress(id));
    print("Book progress 1: $url");
    print("Book progress: $body");

    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == true) {
      return responseJsonBody["msg"];
    } else {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    }
  }

  ///Get My Books
  @override
  Future<List<PricingModel>> getPricing(String token) async {
    final url = Uri.parse(RemoteUrls.getPricing);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]).map((e) => PricingModel.fromJson(e)).toList();
    }
  }

  ///Delete account
  @override
  Future<String> deleteAccount(token) async {
    final url = Uri.parse(RemoteUrls.deleteAccount);
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final clientMethod = client.post(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  ///Get Faq List
  @override
  Future<List<FaqModel>> getFaqList() async {
    final headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    Uri url = Uri.parse(RemoteUrls.faq);
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]).map((e) => FaqModel.fromMap(e)).toList();
    }
  }

  ///Get Privacy Policy
  @override
  Future<List<CustomPageModel>> getPrivacyTermsConditions() async {
    final headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    Uri url = Uri.parse(RemoteUrls.privacyPolicyTerms);
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return List<dynamic>.from(responseJsonBody["data"]).map((e) => CustomPageModel.fromMap(e)).toList();
    }
  }

  /// Join Club
  @override
  Future<String> joinClub(String token, String id) async {
    Map<String, dynamic> data = {};
    data.addAll({"club_id": id});

    final url = Uri.parse(RemoteUrls.joinClub);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: data);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  /// Leave Club
  @override
  Future<String> leaveClub(String token, String id) async {
    Map<String, dynamic> body = {};
    body.addAll({"club_id": id});

    final url = Uri.parse(RemoteUrls.leaveClub);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.post(url, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  /// Club Member Status change
  @override
  Future<String> memberStatusChange(String token, String id, String status) async {
    final url = Uri.parse(RemoteUrls.clubMemberStatusChange(id, status));
    print(url);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  @override
  Future<List<Notifications>> getNotifications(String token) async {
    final url = Uri.parse(RemoteUrls.getNotifications);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      List<Notifications> notificationsList = [];
      for (var model in responseJsonBody['data']['unread_notifications']) {
        Notifications notification = Notifications.fromJson(model);
        notificationsList.add(notification);
      }
      return notificationsList;
    }
  }

  @override
  Future<List<TransactionModel>> getTransaction(String token) async {
    final url = Uri.parse(RemoteUrls.getTransaction);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final clientMethod = client.get(url, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      List<TransactionModel> transactionList = [];
      for (var model in responseJsonBody['data']) {
        TransactionModel transactionModel = TransactionModel.fromJson(model);
        transactionList.add(transactionModel);
      }
      return transactionList;
    }
  }

  @override
  Future<String> readNotifications(String token, String id) async {
    Uri uri = Uri.parse(RemoteUrls.readNotification(id));
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  @override
  Future<String> applyPromoCode(String token, Map<String, dynamic> body) async {
    Uri uri = Uri.parse(RemoteUrls.applyPromo);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  @override
  Future<String> billingInformationPost(String token, Map<String, dynamic> body) async {
    Uri uri = Uri.parse(RemoteUrls.billingUpdate);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody["msg"];
    }
  }

  @override
  Future<String> callInAppPayment(Map<String, dynamic> body, String token) async {
    final headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    final uri = Uri.parse('${RemoteUrls.baseUrl}in-app/submit');

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody = await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["status"] == false) {
      final errorMsg = responseJsonBody["msg"].toString();
      throw UnauthorisedException(errorMsg, 401);
    }
    {
      return responseJsonBody["msg"];
    }
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

        ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException('Error occurred while communication with Server', response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}
