import 'package:bloc/bloc.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.api}) : super(ProfileInitial());
  ApiConsumer api;

  ProfileModel? profileModel;

  getPlayerProfile() async {
    emit(ProfileLoading());
    try {
      final response = await api.get(EndPoint.playerProfile);
      profileModel = ProfileModel.fromJson(response['data']);
      //print("profileModel = ${profileModel?.firstName}");
      emit(ProfileSuccesss(profileData: profileModel!));
    } catch (e) {
      emit(ProfileFailure(errMessage: e.toString()));
    }
  }

  getDoctorProfile() async {
    emit(ProfileLoading());
    try {
      final response = await api.get(EndPoint.doctorProfile);
      profileModel = ProfileModel.fromJson(response['data']);
      //print("profileModel = ${profileModel?.firstName}");
      emit(ProfileSuccesss(profileData: profileModel!));
    } catch (e) {
      emit(ProfileFailure(errMessage: e.toString()));
    }
  }

  getCoachProfile() async {
    emit(ProfileLoading());
    try {
      final response = await api.get(EndPoint.coachProfile);
      profileModel = ProfileModel.fromJson(response['data']);
      //print("profileModel = ${profileModel?.firstName}");
      emit(ProfileSuccesss(profileData: profileModel!));
    } catch (e) {
      emit(ProfileFailure(errMessage: e.toString()));
    }
  }
}
