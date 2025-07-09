import 'package:optikick/features/request%20an%20assesment/data/models/assesments_with_detailes.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/mini_assesment_model.dart';

abstract class AssesmentsRepo {
  Future<List<MiniAssessmentModel>> getMiniAssesments();
  Future<AssessmentWithDetailsModel> getAssesmentDetails(int id);
  Future<void> approveAssesment(int id);
  Future<void> reschduleAssesment({
    required int id,
    required Map<String, dynamic> data,
  });

  Future<void> requestAssesment({required Map<String, dynamic> data});
}
