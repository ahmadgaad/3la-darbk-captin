import 'package:dio/dio.dart';
import '../../widgets/app_toaster.dart';


class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class ServerException extends AppException {
  final int statusCode;
  ServerException(super.message, this.statusCode);
}


 handleDioExceptions(DioException error, bool showErrorMessage) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      throw NetworkException("Connection timed out");
    case DioExceptionType.sendTimeout:
      throw NetworkException("Send request timed out");
    case DioExceptionType.receiveTimeout:
      throw NetworkException("Receive request timed out");
    case DioExceptionType.badResponse:
      if (error.response != null) {
        final data = error.response?.data;
        if (data != null && data.toString().isNotEmpty && showErrorMessage) {
            AppToaster.show(data['message']??data['error']??"error");
        throw ServerException(data['message']?? "Unknown server error", error.response?.statusCode??0);
        }
        throw ServerException(error.response?.statusMessage ?? "Unknown server error", error.response?.statusCode??0);
      }
      break;
    case DioExceptionType.cancel:
      throw AppException("Request was cancelled");
    case DioExceptionType.unknown:
      throw AppException("An unknown error occurred: ${error.message}");
    case DioExceptionType.badCertificate:
      throw AppException("Bad certificate error");
    case DioExceptionType.connectionError:
      throw NetworkException("Connection error occurred");
  }
}
