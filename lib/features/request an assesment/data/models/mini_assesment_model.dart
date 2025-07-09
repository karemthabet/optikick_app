class MiniAssessmentModel {
  final int id;
  final int playerId;
  final String firstName;
  final String lastName;
  final DateTime requestedAt;
  final String message;
  final String status;

  MiniAssessmentModel({
    required this.id,
    required this.playerId,
    required this.firstName,
    required this.lastName,
    required this.requestedAt,
    required this.message,
    required this.status,
  });

  factory MiniAssessmentModel.fromJson(Map<String, dynamic> json) {
    return MiniAssessmentModel(
      id: json['id'],
      playerId: json['player_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      requestedAt: DateTime.parse(json['requested_at']),
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player_id': playerId,
      'first_name': firstName,
      'last_name': lastName,
      'requested_at': requestedAt.toIso8601String(),
      'message': message,
      'status': status,
    };
  }
}
