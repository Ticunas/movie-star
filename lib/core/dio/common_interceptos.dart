import 'package:dio/dio.dart';
import 'package:movie_star/core/errors/exceptions.dart';

class CommonInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectTimeout) {
      throw ConnectTimeOutException();
    } else if (err.type == DioErrorType.receiveTimeout) {
      throw ResponseTimeOutException();
    }
    if (err.response != null) {
      switch (err.response?.statusCode!) {
        case 401:
          throw UnauthorizedException();
        case 404:
          throw NotFoundException();
      }
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.resolve(response);
  }
}
