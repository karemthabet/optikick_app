import 'package:optikick/core/keys/end_ponits.dart';

class ProfileModel {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? sex;
  String? status;
  String? position;
  String? bloodType;
  String? email;

  ProfileModel(
      {this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.sex,
      this.status,
      this.position,
      this.bloodType,
      this.email});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json[ApiKey.firstName];
    lastName = json[ApiKey.lastName];
    dateOfBirth = json[ApiKey.dateOfBirth];
    sex = json[ApiKey.sex];
    status = json[ApiKey.status];
    position = json[ApiKey.position];
    bloodType = json[ApiKey.bloodType];
    email = json[ApiKey.email];
  }
}
