import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

///Cache configuration to DataSource who use Dio
mixin DioDataSourceCache {
  ///Return Options based on [buildCacheOptions]
  ///
  /// More Information about:
  /// https://github.com/hurshi/dio-http-cache
  ///
  ///[forceRefresh] force update cache
  ///
  ///[cacheTime]
  ///
  ///[maxStale] Try to update cache if some error occours on request return cached data
  ///
  Options customRequestOptions(
      bool forceRefresh, Duration cacheTime, Duration maxStale) {
    return buildCacheOptions(cacheTime,
        forceRefresh: forceRefresh, maxStale: maxStale);
  }
}
