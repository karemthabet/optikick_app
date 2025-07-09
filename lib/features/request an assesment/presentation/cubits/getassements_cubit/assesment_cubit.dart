import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/assesments_with_detailes.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/mini_assesment_model.dart';
import 'package:optikick/features/request%20an%20assesment/data/repos/assesments_repo.dart';
import 'package:optikick/features/request%20an%20assesment/data/repos/assesments_repo_impl.dart';
import '../../../../../core/error/api_exceptions.dart';
import 'assement_cubit_state.dart';

class AssesmentCubit extends Cubit<AssesmentCubitState> {
  AssesmentCubit() : super(AssesmentCubitInitial());

  final AssesmentsRepo assesmentsRepo = AssesmentsRepoImpl();

  Future<void> getAllAssesment() async {
    emit(AssesmentLoading());
    try {
      List<MiniAssessmentModel> miniAssesments =
          await assesmentsRepo.getMiniAssesments();
      emit(AssesmentSuccess(miniAssesments));
    } on ApiException catch (e) {
      emit(AssesmentFailure(e.errModel.message.toString()));
    } catch (e) {
      emit(AssesmentFailure(e.toString()));
    }
  }

  Future<void> getAssesmentDetailes(int id) async {
    emit(AssesmentLoading());
    try {
      AssessmentWithDetailsModel assessmentWithDetailsModel =
          await assesmentsRepo.getAssesmentDetails(id);
      emit(AssesmentDetailsSuccess(assessmentWithDetailsModel));
    } on ApiException catch (e) {
      emit(AssesmentFailure(e.errModel.message.toString()));
    } catch (e) {
      emit(AssesmentFailure(e.toString()));
    }
  }
}
