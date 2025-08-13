import 'package:dartz/dartz.dart';
import 'package:tcllibraryapp_develop/data/models/settings_response_model.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/models/analytics_model.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/model/club_details_model.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/models/post_details_model.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/model/club_model.dart';
import 'package:tcllibraryapp_develop/screens/faq/model/faq_model.dart';
import 'package:tcllibraryapp_develop/screens/main/model/custom_page.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/notification/model/notification_model.dart';
import 'package:tcllibraryapp_develop/screens/pricing/model/pricing_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/transaction/models/transaction_model.dart';

import '../../../data/data_source/local_data_source.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../../book/author/add_book/models/books_store_model.dart';
import '../../book/author/add_book/models/category_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsResponseModel>> getSettingsData();
  Future<Either<Failure, UserModel>> getUserProfile(String token);

  Future<Either<Failure, List<CategoryModel>>> getCategoryList();

  Future<Either<Failure, List<CountryModel>>> getCountryData();

  Future<Either<Failure, AnalyticsModel>> getAnalyticsData(
      String token, String id);

  Future<Either<Failure, ClubModel>> getClub(String token);

  Future<Either<Failure, String>> makePaypalPayment(
      Map<String, dynamic> body, String token, int id);

  Future<Either<Failure, String>> buyBook(
      Map<String, dynamic> body, String token, int id);

  Future<Either<Failure, String>> makeFreePayment(
      Map<String, dynamic> body, String token, int id);

  Future<Either<Failure, String>> makeSubscription(
      String endPoint, String token);

  Future<Either<Failure, String>> flutterWaveApi(
      Map<String, dynamic> body, String token);

  Future<Either<Failure, ClubDetailsModel>> getClubDetails(
      String token, String id);

  Future<Either<Failure, String>> joinClub(String token, String id);

  Future<Either<Failure, String>> leaveClub(String token, String id);

  Future<Either<Failure, String>> memberStatusChange(
      String token, String id, String status);

  Future<Either<Failure, bool>> postReply(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, bool>> createTopic(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, PostDetailsModel>> getPostDetails(
      String token, int id);

  Future<Either<Failure, String>> updatePassword(
      Map<String, dynamic> body, String token);

  Future<Either<Failure, String>> updateProfile(
      Map<String, dynamic> body, String token);

  Future<Either<Failure, BookStoreModel>> updateBooks(
      String token, int id, Map<String, dynamic> body);

  Future<Either<Failure, List<PricingModel>>> getPricing(String token);

  Future<Either<Failure, String>> deleteAccount(String token);

  Future<Either<Failure, List<FaqModel>>> getFaqList();

  Future<Either<Failure, List<CustomPageModel>>> getPrivacyTermsConditions();

  Future<Either<Failure, List<Notifications>>> getNotifications(String token);

  Future<Either<Failure, List<TransactionModel>>> getTransaction(String token);

  Future<Either<Failure, String>> readNotifications(String token, String id);

  Future<Either<Failure, String>> applyPromoCode(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> billingInformationPost(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> callInAppPayment(
      Map<String, dynamic> body, String token);
}

class SettingRepositoryImpl extends SettingsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  SettingRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, SettingsResponseModel>> getSettingsData() async {
    try {
      final result = await remoteDataSource.getSettingsData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserProfile(String token) async {
    try {
      final result = await remoteDataSource.getUserProfile(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.updatePassword(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.updateProfile(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AnalyticsModel>> getAnalyticsData(
      String token, String id) async {
    try {
      final result = await remoteDataSource.getAnalyticsData(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BookStoreModel>> updateBooks(
      String token, int id, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.updateBooks(token, id, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<PricingModel>>> getPricing(String token) async {
    try {
      final result = await remoteDataSource.getPricing(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount(String token) async {
    try {
      final result = await remoteDataSource.deleteAccount(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryList() async {
    try {
      final result = await remoteDataSource.getCategoryList();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CountryModel>>> getCountryData() async {
    try {
      final result = await remoteDataSource.getCountryData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<FaqModel>>> getFaqList() async {
    try {
      final result = await remoteDataSource.getFaqList();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CustomPageModel>>>
      getPrivacyTermsConditions() async {
    try {
      final result = await remoteDataSource.getPrivacyTermsConditions();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ClubModel>> getClub(String token) async {
    try {
      final result = await remoteDataSource.getClub(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> buyBook(
      Map<String, dynamic> body, String token, int id) async {
    //try {
    final result = await remoteDataSource.buyBook(body, token, id);
    return Right(result);
    // } on ServerException catch (e) {
    //   return Left(ServerFailure(e.message, e.statusCode));
    // }
  }

  @override
  Future<Either<Failure, String>> makePaypalPayment(
      Map<String, dynamic> body, String token, int id) async {
    try {
      final result = await remoteDataSource.makePaypalPayment(body, token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> makeFreePayment(
      Map<String, dynamic> body, String token, int id) async {
    try {
      final result = await remoteDataSource.makeFreePayment(body, token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> makeSubscription(
      String endPoint, String token) async {
    try {
      final result = await remoteDataSource.makeSubscription(endPoint, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> flutterWaveApi(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.flutterWaveApi(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PostDetailsModel>> getPostDetails(
      String token, int id) async {
    try {
      final result = await remoteDataSource.getPostDetails(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ClubDetailsModel>> getClubDetails(
      String token, String id) async {
    try {
      final result = await remoteDataSource.getClubDetails(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> joinClub(String token, String id) async {
    try {
      final result = await remoteDataSource.joinClub(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> leaveClub(String token, String id) async {
    try {
      final result = await remoteDataSource.leaveClub(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> memberStatusChange(
      String token, String id, String status) async {
    try {
      final result =
          await remoteDataSource.memberStatusChange(token, id, status);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> postReply(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.postReply(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> createTopic(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.createTopic(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<Notifications>>> getNotifications(
      String token) async {
    try {
      final result = await remoteDataSource.getNotifications(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransaction(
      String token) async {
    try {
      final result = await remoteDataSource.getTransaction(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> readNotifications(
      String token, String id) async {
    try {
      final result = await remoteDataSource.readNotifications(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> applyPromoCode(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.applyPromoCode(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> billingInformationPost(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.billingInformationPost(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> callInAppPayment(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.callInAppPayment(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
