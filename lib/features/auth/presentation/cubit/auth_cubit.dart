import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/error/api_exceptions.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/models/forget_pass_model.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/models/login_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.api}) : super(AuthInitial());

  ApiConsumer api;
  LogInModel? logInModel;
  ForgetPassModel? forgetPassModel;

  //?login email textField
  TextEditingController logInEmailField = TextEditingController();
  //?login password textField
  TextEditingController logInPasswordField = TextEditingController();

//?forget Password email textField
  TextEditingController forgotPasswordEmailField = TextEditingController();

  //?verification (OTP) textField
  TextEditingController verificationOTP = TextEditingController();

  //?resetPassword newPassword textField
  TextEditingController newPasswordField = TextEditingController();
//?resetPassword confirmPassword textField
  TextEditingController confirmNewPasswordField = TextEditingController();

//? Auth Cubit Functions:

  login() async {
    if (logInEmailField.text.isEmpty || logInPasswordField.text.isEmpty) {
      emit(LogInFailure(errMessage: 'Please fill all required fields'));
    } else {
      try {
        emit(LogInLoading());
        final response = await api.post(EndPoint.logIn, data: {
          ApiKey.identifier: logInEmailField.text.toUpperCase(),
          ApiKey.password: logInPasswordField.text,
        });

        logInModel = LogInModel.fromJson(response);
        
        CacheHelper.storeData(key: ApiKey.token, value: logInModel!.token);
        CacheHelper.storeData(key: ApiKey.role, value: logInModel!.role);
        CacheHelper.storeData(key: ApiKey.userId, value: logInModel!.id);
        CacheHelper.storeData(
            key: ApiKey.firstName, value: logInModel!.firstName);
        CacheHelper.storeData(
            key: ApiKey.lastName, value: logInModel!.lastName);
        CacheHelper.storeData(key: ApiKey.email, value: logInEmailField.text);
        bool isDoctor =
            CacheHelper.getData(key: ApiKey.role) == ApiKey.doctorRole;
        bool isCoach =
            CacheHelper.getData(key: ApiKey.role) == ApiKey.coachRole;
        bool isPlayer =
            CacheHelper.getData(key: ApiKey.role) == ApiKey.playerRole;
        CacheHelper.storeData(key: ApiKey.isDoctor, value: isDoctor);
        CacheHelper.storeData(key: ApiKey.isCoach, value: isCoach);
        CacheHelper.storeData(key: ApiKey.isPlayer, value: isPlayer);
        emit(LogInSuccess(successMessage: logInModel!.message));
      } on ApiException catch (e) {
        emit(LogInFailure(errMessage: e.errModel.message));
      }
    }
  }

  forgetPassword() async {
    if (forgotPasswordEmailField.text.isEmpty) {
      emit(
          ForgetPasswordFailure(errMessage: 'Please fill all required fields'));
    } else {
      try {
        emit(ForgetPasswordLoading());
        final response = await api.post(EndPoint.forgetPassword, data: {
          ApiKey.identifier: forgotPasswordEmailField.text,
        });
        forgetPassModel = ForgetPassModel.fromJson(response);
        CacheHelper.storeData(
            key: ApiKey.forgetPassEmail, value: forgotPasswordEmailField.text);
        emit(ForgetPasswordSuccess(forgetPassModel: forgetPassModel!));
      } on ApiException catch (e) {
        emit(ForgetPasswordFailure(errMessage: e.errModel.message));
      }
    } //? forgetPassword
  }

  verifyOTP() async {
    if (verificationOTP.text.isEmpty) {
      emit(VerifyOTPFailure(errMessage: 'Please fill all required fields'));
    } else {
      try {
        emit(VerifyOTPLoading());
        final response = await api.post(EndPoint.verifyResetToken, data: {
          ApiKey.identifier: CacheHelper.getData(key: ApiKey.forgetPassEmail),
          ApiKey.token: verificationOTP.text,
        });
        debugPrint(response);
        emit(VerifyOTPSuccess());
      } on ApiException catch (e) {
        emit(VerifyOTPFailure(errMessage: e.errModel.message));
      }
    }
  } //? verifyOTP

  resetPassword() async {
    if (newPasswordField.text.isEmpty || confirmNewPasswordField.text.isEmpty) {
      emit(ResetPasswordFailure(errMessage: 'Please fill all required fields'));
    } else if (newPasswordField.text.length < 8 ||
        confirmNewPasswordField.text.length < 8) {
      emit(ResetPasswordFailure(
          errMessage: 'Passwords Must be at least 8 characters'));
    } else if (newPasswordField.text != confirmNewPasswordField.text) {
      emit(ResetPasswordFailure(errMessage: 'Opps, Passwords do not match'));
    } else {
      try {
        emit(ResetPasswordLoading());
        final response = await api.post(EndPoint.resetPassword, data: {
          ApiKey.identifier: CacheHelper.getData(key: ApiKey.forgetPassEmail),
          ApiKey.token: verificationOTP.text,
          ApiKey.password: newPasswordField.text,
          ApiKey.confirmPassword: confirmNewPasswordField.text,
        });
        debugPrint(response);
        emit(ResetPasswordSuccess(
            successMessage: 'Password reset successfully'));
      } on ApiException catch (e) {
        emit(ResetPasswordFailure(errMessage: e.errModel.message));
      }
    }
  } //? resetPassword
} //!cubit
