import 'package:dartz/dartz.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/book_details_model.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/models/read_page_response_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/publisher_authors_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/models/borrowed_models.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';

import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import '../author/my_readers/models/my_readers_model.dart';

abstract class BookRepository {
  Future<Either<Failure, BooksModel>> getPendingBook(String token);
  Future<Either<Failure, BooksModel>> getDeclineBook(String token);
  Future<Either<Failure, BooksModel>> getMyBook(String token);
  Future<Either<Failure, MyReadersModel>> getMyReaders(String token);
  Future<Either<Failure, PublisherAndAuthorModel>> getPublisherData(
      String token);
  Future<Either<Failure, AllBookModel>> getAllBooksData(
      String token, int page, String search, String category, String author);
  Future<Either<Failure, AllBookModel>> getAllBooksDataForBookOfMonth(
      String token, int page, String search, String category, String author);
      
  Future<Either<Failure, String>> storeFavouriteBook(String token, int id);
  Future<Either<Failure, String>> storeBorrowBook(String token, int id);
  Future<Either<Failure, FavouriteModel>> getFavouriteBooksData(
      String token, int page);
  Future<Either<Failure, BorrowedModel>> getBorrowedBooksData(String token);
  Future<Either<Failure, dynamic>> getDashboardData(String token);
  Future<Either<Failure, String>> deleteBook(String token, String id);
  Future<Either<Failure, BookDetailsModel>> getBookDetails(
      String token, int id, int isBookForSale);
  Future<Either<Failure, ReadPageResponseModel>> readPage(
      String token, String id, int page, int totalPage);
  Future<Either<Failure, String>> readPageProgress(
      String token, String id, int page, int stayTime);
  Future<Either<Failure, String>> deleteReview(String token, String id);
  Future<Either<Failure, String>> ratingSubmit(
      Map<String, dynamic> body, String token);
}

class BookRepositoryImpl extends BookRepository {
  final RemoteDataSource remoteDataSource;
  BookRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, BooksModel>> getPendingBook(String token) async {
    try {
      final result = await remoteDataSource.getPendingBook(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BooksModel>> getDeclineBook(String token) async {
    try {
      final result = await remoteDataSource.getDeclineBook(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BooksModel>> getMyBook(String token) async {
    try {
      final result = await remoteDataSource.getMyBook(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, MyReadersModel>> getMyReaders(String token) async {
    try {
      final result = await remoteDataSource.getMyReaders(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AllBookModel>> getAllBooksData(String token, int page,
      String search, String category, String author) async {
    try {
      final result = await remoteDataSource.getAllBooksData(
          token, page, search, category, author);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, AllBookModel>> getAllBooksDataForBookOfMonth(String token, int page,
      String search, String category, String author) async {
    try {
      final result = await remoteDataSource.getAllBooksDataForBookOfMonth(
          token, page, search, category, author);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  

  @override
  Future<Either<Failure, PublisherAndAuthorModel>> getPublisherData(
      String token) async {
    try {
      final result = await remoteDataSource.getPublisherData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, FavouriteModel>> getFavouriteBooksData(
      String token, int page) async {
    try {
      final result = await remoteDataSource.getFavouriteBooksData(token, page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> storeFavouriteBook(
      String token, int id) async {
    try {
      final result = await remoteDataSource.storeFavouriteBook(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> storeBorrowBook(String token, int id) async {
    try {
      final result = await remoteDataSource.storeBorrowBook(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BorrowedModel>> getBorrowedBooksData(
      String token) async {
    try {
      final result = await remoteDataSource.getBorrowedBooksData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getDashboardData(String token) async {
    try {
      final result = await remoteDataSource.getDashboardData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteBook(String token, String id) async {
    try {
      final result = await remoteDataSource.deleteBook(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BookDetailsModel>> getBookDetails(
      String token, int id, int isBookForSale) async {
    try {
      final result = await remoteDataSource.getBookDetails(token, id, isBookForSale);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteReview(String token, String id) async {
    try {
      final result = await remoteDataSource.deleteReview(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> ratingSubmit(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.ratingSubmit(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ReadPageResponseModel>> readPage(
      String token, String id, int page, int totalPage) async {
    try {
      final result =
          await remoteDataSource.readPagePdf(token, id, page, totalPage);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> readPageProgress(
      String token, String id, int page, int stayTime) async {
    try {
      final result =
          await remoteDataSource.readPageProgress(token, id, page, stayTime);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
