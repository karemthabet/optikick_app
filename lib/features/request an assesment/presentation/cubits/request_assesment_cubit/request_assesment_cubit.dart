import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/core/error/api_exceptions.dart';

import '../../../data/repos/assesments_repo.dart';
import '../../../data/repos/assesments_repo_impl.dart';
import 'request_assesment_state.dart';

class RequestAssesmentCubit extends Cubit<RequestAssesmentCubitState> {
  RequestAssesmentCubit() : super(RequestAssesmentInitial());

  final AssesmentsRepo _assesmentsRepo = AssesmentsRepoImpl();

  Future<void> requestAssesment({required Map<String, dynamic> data}) async {
    emit(RequestAssesmentLoading());
    try {
      await _assesmentsRepo.requestAssesment(data: data);
      emit(RequestAssesmentSuccess());
    } on ApiException catch (e) {
      emit(RequestAssesmentFailure(e.errModel.message.toString()));
    } catch (e) {
      emit(RequestAssesmentFailure(e.toString()));
    }
  }
}
