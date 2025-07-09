class AssessmentWithDetailsModel {
  final String issueType;
  final String date;
  final String hour;
  final String message;

  AssessmentWithDetailsModel({
    required this.issueType,
    required this.date,
    required this.hour,
    required this.message,
  });

  factory AssessmentWithDetailsModel.fromJson(Map<String, dynamic> json) {
    return AssessmentWithDetailsModel(
      issueType: json['issue_type'] ?? '',
      date: json['date'] ?? '',
      hour: json['hour'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue_type': issueType,
      'date': date,
      'hour': hour,
      'message': message,
    };
  }
}
