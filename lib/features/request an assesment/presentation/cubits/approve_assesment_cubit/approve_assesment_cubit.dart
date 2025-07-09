import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/api_exceptions.dart';
import '../../../data/repos/assesments_repo.dart';
import '../../../data/repos/assesments_repo_impl.dart';
import 'approve_assesmet_states.dart';

class ApproveAndScheduleAssesmentCubit extends Cubit<ApproveAssesmetStates> {
  ApproveAndScheduleAssesmentCubit() : super(ApproveAssesmetInitial());
  final AssesmentsRepo _assesmentsRepo = AssesmentsRepoImpl();

  Future<void> approveAssesment(int id) async {
    try {
      emit(ApproveAssesmetLoading());
      await _assesmentsRepo.approveAssesment(id);
      emit(ApproveAssesmetSuccess());
    } on ApiException catch (e) {
      emit(AssesmetFailure(e.errModel.message));
    } catch (e) {
      emit(AssesmetFailure(e.toString()));
    }
  }

  Future<void> rescheduleAssesment(
      {required int id, required Map<String, dynamic> data}) async {
    try {
      emit(ApproveAssesmetLoading());
      await _assesmentsRepo.reschduleAssesment(id: id, data: data);
      emit(RescheduleAssesmetSuccess());
    } on ApiException catch (e) {
      emit(AssesmetFailure(e.errModel.message));
    } catch (e) {
      emit(AssesmetFailure(e.toString()));
    }
  }
}
