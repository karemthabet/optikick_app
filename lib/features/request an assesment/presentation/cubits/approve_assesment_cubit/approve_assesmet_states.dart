abstract class ApproveAssesmetStates {}

class ApproveAssesmetInitial extends ApproveAssesmetStates {}

class ApproveAssesmetLoading extends ApproveAssesmetStates {}

class ApproveAssesmetSuccess extends ApproveAssesmetStates {}

class RescheduleAssesmetSuccess extends ApproveAssesmetStates {}

class AssesmetFailure extends ApproveAssesmetStates {
  final String errMessage;
  AssesmetFailure(this.errMessage);
}
