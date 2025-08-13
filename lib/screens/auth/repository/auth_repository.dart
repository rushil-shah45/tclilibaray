import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/model/register_model.dart';

import '../../../data/data_source/local_data_source.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserRegisterModel>> login(Map<String, dynamic> body);

  Future<Either<Failure, UserRegisterModel>> userRegister(
      Map<String, dynamic> body);

  Future<Either<Failure, UserRegisterModel>> socialLogin(String social);

  // Future<Either<Failure, UserRegisterModel>> socialLoginData(
  //     Map<String, dynamic> body);

  Future<Either<Failure, String>> forgotPassword(Map<String, dynamic> body);

  Either<Failure, UserRegisterModel> getCashedUserInfo();

  Either<Failure, bool> saveCashedUserInfo(UserRegisterModel userRegisterModel);
}

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserRegisterModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, UserRegisterModel>> socialLoginData(
  //     Map<String, dynamic> body) async {
  //   try {
  //     final result = await remoteDataSource.socialLogin(body);
  //     localDataSource.cacheUserResponse(result);
  //     return Right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

  String? deviceId = '';

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<Either<Failure, UserRegisterModel>> socialLogin(String social) async {
    try {
      UserRegisterModel result;
      deviceId = await FirebaseMessaging.instance.getToken();
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential? userCredential;
      Map<String, dynamic> data = <String, dynamic>{};
      if (social == 'google') {
        GoogleSignIn googleSignIn = GoogleSignIn(
            signInOption: SignInOption.standard, scopes: ['email']);

        await googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
          if (acc != null) {
            GoogleSignInAuthentication auth = await acc.authentication;
            if (auth.accessToken != null) {
              print('Ali debugging');
              print(auth.accessToken);
              print(acc.id);
              print('Ali debugging: ${acc.displayName} /// ${acc.email} /// ${acc.photoUrl} /// ${acc.id} // ${auth.accessToken} // $deviceId');
              data.addAll({'provider': social});
              data.addAll({'id': acc.id});
              data.addAll({'access_token': auth.accessToken});
              data.addAll({'name': acc.displayName});
              data.addAll({'email': acc.email});
              data.addAll({'imageUrl': acc.photoUrl ?? ''});
              data.addAll({'device_id': deviceId.toString()});
            }
          }
        });
      }
      else {
        try {
          final rawNonce = generateNonce();
          final nonce = sha256ofString(rawNonce);

          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: nonce,
          );

          print('-------');
          print(appleCredential);

          final oauthCredential = OAuthProvider("apple.com").credential(
            idToken: appleCredential.identityToken,
            rawNonce: rawNonce,
          );
          print(oauthCredential);
          userCredential =
              await FirebaseAuth.instance.signInWithCredential(oauthCredential);

          print(userCredential.user!);
          print('######');
          print(userCredential.credential!.accessToken);
          print('######');
          Map<String, dynamic> data = <String, dynamic>{};

          if (userCredential.additionalUserInfo!.isNewUser) {
            data.addAll({'provider': social});
            data.addAll({'id': userCredential.additionalUserInfo!.providerId});
            data.addAll(
                {'access_token': userCredential.credential!.accessToken});
            data.addAll({
              'name':
                  "${appleCredential.givenName} ${appleCredential.familyName}"
            });
            data.addAll({'email': userCredential.user!.email});
            // data.addAll({'lname': appleCredential.familyName});
            data.addAll({
              'imageUrl':
                  userCredential.additionalUserInfo!.profile!['picture'] ?? ''
            });
            data.addAll({'device_id': deviceId.toString()});
          } else {
            data.addAll({'provider': social});
            data.addAll({'id': userCredential.additionalUserInfo!.providerId});
            data.addAll(
                {'access_token': userCredential.credential!.accessToken});
            data.addAll({'email': userCredential.user!.email});
            data.addAll({'device_id': deviceId.toString()});
          }
          print('#######');
          print(data);
          print('#######');
          result = await remoteDataSource.socialLogin(data);
          localDataSource.cacheUserResponse(result);
          return Right(result);
        } on Exception catch (e) {
          print(e);
          print("****************");
          // return const Left(ServerFailure('Cancelled', 1001));
          return const Left(ServerFailure('Warning!', 400));
        }
      }
      result = await remoteDataSource.socialLogin(data);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  @override
  Future<Either<Failure, String>> forgotPassword(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.forgotPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserRegisterModel>> userRegister(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserRegisterModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Either<Failure, bool> saveCashedUserInfo(
      UserRegisterModel userRegisterModel) {
    try {
      localDataSource.cacheUserResponse(userRegisterModel);
      return const Right(true);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
