import 'package:dio/dio.dart';
import 'package:optikick/core/api/dio_consumer.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/assesments_with_detailes.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/mini_assesment_model.dart';
import 'package:optikick/features/request%20an%20assesment/data/repos/assesments_repo.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/keys/end_ponits.dart';

class AssesmentsRepoImpl implements AssesmentsRepo {
  final ApiConsumer apiConsumer = DioConsumer(dio: Dio());
  @override
  Future<List<MiniAssessmentModel>> getMiniAssesments() async {
    List<MiniAssessmentModel> miniAssesments = [];
    final response = await apiConsumer.get(EndPoint.doctorsAssessment);

    for (var element in response["data"]["assessments"] as List) {
      miniAssesments.add(MiniAssessmentModel.fromJson(element));
    }
    return miniAssesments;
  }

  @override
  Future<AssessmentWithDetailsModel> getAssesmentDetails(int id) async {
    final response = await apiConsumer.get("${EndPoint.doctorsAssessment}/$id");
    return AssessmentWithDetailsModel.fromJson(response["data"]);
  }

  @override
  Future<void> approveAssesment(int id) async {
    await apiConsumer.post(
        "${EndPoint.doctorsAssessment}/$id/${EndPoint.approveAssessment}");
  }

  @override
  Future<void> reschduleAssesment({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    await apiConsumer.post(
      "${EndPoint.doctorsAssessment}/$id/${EndPoint.reschdule}",
      data: data,
    );
  }

  @override
  Future<void> requestAssesment({required Map<String, dynamic> data}) async {
    await apiConsumer.post(EndPoint.requestAssessment, data: data);
  }
}
