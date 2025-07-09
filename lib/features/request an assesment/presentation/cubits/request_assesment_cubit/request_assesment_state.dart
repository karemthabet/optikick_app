abstract class RequestAssesmentCubitState {}

class RequestAssesmentInitial extends RequestAssesmentCubitState {}

class RequestAssesmentLoading extends RequestAssesmentCubitState {}

class RequestAssesmentSuccess extends RequestAssesmentCubitState {}

class RequestAssesmentFailure extends RequestAssesmentCubitState {
  final String errMessage;
  RequestAssesmentFailure(this.errMessage);
}
