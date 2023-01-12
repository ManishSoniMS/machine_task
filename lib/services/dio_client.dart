import 'dart:developer';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../utils/api_constants.dart';

class DioClient {
  /// getDio method is used to add interceptors
  Dio getDio() {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    int timeOut = 120 * 1000; // 2 minute

    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseurl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          String headers = "";
          options.headers.forEach((key, value) {
            headers += "| $key: $value";
          });

          log("""
┌------------------------------------------------------------------------------""");
          log('''| [DIO] Request: ${options.method} ${options.uri}|
         ${options.data}| Headers:\n$headers''');
          log("""
├------------------------------------------------------------------------------""");

          handler.next(options); //continue
        },
        onResponse: (response, handler) async {
          log("| [DIO] Response [code ${response.statusCode}]:"
              " ${response.data}");
          log("""
└------------------------------------------------------------------------------""");
          handler.next(response);
          // return response; // continue
        },
        onError: (error, handler) async {
          log("| [DIO] Error: ${error.error}: ${error.response}");
          log("""
└------------------------------------------------------------------------------""");
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            /// Todo
            /// if token id expired, refresh token

          } else {
            /// Todo delete token
          }
        },
        // handler.next(error); //continue
      ),
    );

    return dio;
  }
}
