import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_details_model.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_model.dart';
import '../../../data/data_source/remote_data_source.dart';
import '../../../data/error/exception.dart';
import '../../../data/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<TicketModel>>> getUserTicket(String token);
  Future<Either<Failure, String>> createUserTicket(
      Map<String, dynamic> body, String token);
  Future<Either<Failure, String>> deleteUserTicket(String token, String id);
  Future<Either<Failure, TicketDetailsModel>> getUserTicketDetails(
      String id, String token);
  Future<Either<Failure, String>> userTicketReply(
      Map<String, dynamic> body, String token);
}

class TicketRepositoryImpl extends TicketRepository {
  final RemoteDataSource remoteDataSource;
  TicketRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<TicketModel>>> getUserTicket(String token) async {
    try {
      final result = await remoteDataSource.getUserTicket(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> createUserTicket(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.createUserTicket(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUserTicket(
      String token, String id) async {
    try {
      final result = await remoteDataSource.deleteUserTicket(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TicketDetailsModel>> getUserTicketDetails(
      String id, String token) async {
    try {
      final result = await remoteDataSource.getUserTicketDetails(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> userTicketReply(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.userTicketReply(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
