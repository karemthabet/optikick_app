import 'package:dio/dio.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/services/cache_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.authorization] =
        CacheHelper.getData(key: ApiKey.token) != null
            ? 'Bearer ${CacheHelper.getData(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
