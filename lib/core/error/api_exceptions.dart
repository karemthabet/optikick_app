import 'package:dio/dio.dart';
import 'package:optikick/core/error/error_model.dart';

class ApiException implements Exception {
  final ErrorModel errModel;

  ApiException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  if (e.response != null) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.sendTimeout:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badCertificate:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.cancel:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionError:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.unknown:
        throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: // Bad request
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 401: //unauthorized
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 403: //forbidden
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 404: //not found
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 409: //cofficient
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 422: //  Unprocessable Entity
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
          case 504: // Server exception
            throw ApiException(errModel: ErrorModel.fromJson(e.response!.data));
        }
    }
  }
}
