class NotificationModel {
  final int id;
  final String type;
  final String title;
  final String body;
  final String senderName;
  final String senderUsername;
  final String? readAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.senderName,
    required this.senderUsername,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      body: json['body'],
      senderName: json['sender']['name'],
      senderUsername: json['sender']['username'],
      readAt: json['read_at'],
    );
  }
}
