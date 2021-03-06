import 'package:dio/dio.dart';
import 'package:movie_star/core/constants/dio_constants.dart' as constants;

class CustomDio {
  final String apiKey;

  CustomDio({required this.apiKey});

  getDio() {
    var dio = _dioFactory(constants.base_mobiedb_url);
    dio.options.contentType = Headers.jsonContentType;
    dio.options.headers['Authorization'] = 'bearer $apiKey';
  }

  Dio _dioFactory(String baseUrl) {
    var dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = constants.connectTimeout;
    dio.options.receiveTimeout = constants.receiveTimeout;
    return dio;
  }
}
