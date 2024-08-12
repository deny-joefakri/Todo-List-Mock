import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_list_app/core/env/env.dart';

import '../injection/di.dart';

final HttpService httpService = locator<HttpService>();
final apiService = httpService._dio;


class HttpService {
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrlString,
    ),
  )
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
        logPrint: (object) => log(object.toString()),
      ),
    );
}