import 'package:optikick/core/keys/end_ponits.dart';

class ForgetPassModel {
  final String status;
  final String message;
  final String email;

  ForgetPassModel(
      {required this.status, required this.message, required this.email});
  factory ForgetPassModel.fromJson(Map<String, dynamic> jsonData) {
    final data = jsonData[ApiKey.data] ?? {};

    return ForgetPassModel(
      status: jsonData[ApiKey.status] ?? '',
      message: jsonData[ApiKey.message] ?? '',
      email: data[ApiKey.email] ?? '',
    );
  }
}
