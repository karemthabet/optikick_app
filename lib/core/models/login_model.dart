import 'package:optikick/core/keys/end_ponits.dart';

class LogInModel {
  final String status;
  final String message;
  final String token;
  final dynamic id;
  final String role;
  final String firstName;
  final String lastName;
  LogInModel({
    required this.status,
    required this.message,
    required this.token,
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
  });

  factory LogInModel.fromJson(Map<String, dynamic> jsonData) {
    return LogInModel(
      status: jsonData[ApiKey.status],
      message: jsonData[ApiKey.message],
      token: jsonData[ApiKey.data][ApiKey.token],
      id: jsonData[ApiKey.data][ApiKey.user][ApiKey.id],
      role: jsonData[ApiKey.data][ApiKey.user][ApiKey.role],
      firstName: jsonData[ApiKey.data][ApiKey.user][ApiKey.firstName],
      lastName: jsonData[ApiKey.data][ApiKey.user][ApiKey.lastName],
    );
  }
}
