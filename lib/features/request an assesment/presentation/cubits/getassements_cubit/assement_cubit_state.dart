import 'package:optikick/features/request%20an%20assesment/data/models/mini_assesment_model.dart';

import '../../../data/models/assesments_with_detailes.dart';

abstract class AssesmentCubitState {}

class AssesmentCubitInitial extends AssesmentCubitState {}

class AssesmentFailure extends AssesmentCubitState {
  final String errMessage;
  AssesmentFailure(this.errMessage);
}

class AssesmentLoading extends AssesmentCubitState {}

class AssesmentSuccess extends AssesmentCubitState {
  List<MiniAssessmentModel> miniAssesments;
  AssesmentSuccess(this.miniAssesments);
}

class AssesmentDetailsSuccess extends AssesmentCubitState {
  final AssessmentWithDetailsModel assesmentDetails;
  AssesmentDetailsSuccess(this.assesmentDetails);
}
