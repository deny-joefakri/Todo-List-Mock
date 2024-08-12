import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

class ServerException implements Exception {}

class ErrorHandling {
  static Either<Failure, T> handleException<T>(exception) {
    if (exception is ServerException) {
      return const Left(ServerFailure('Server Failure'));
    } else if (exception is SocketException) {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } else if (exception is HttpException) {
      return const Left(ServerFailure('Http Exception'));
    } else if (exception is FormatException) {
      return const Left(ServerFailure('Format Exception'));
    } else if (exception is DioException) {
      return Left(
        ServerFailure(
          exception.message ??
              exception.response?.statusMessage ??
              'Unknown Dio Exception',
        ),
      );
    } else {
      return Left(ServerFailure(exception.toString()));
    }
  }
}
