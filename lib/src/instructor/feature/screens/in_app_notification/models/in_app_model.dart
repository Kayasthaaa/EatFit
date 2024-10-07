class NotificationModel {
  final int id;
  final String createdAt;
  final String modifiedAt;
  final String title;
  final String shortDescription;
  final String content;
  final String notificationCategory;
  final bool seen;
  final dynamic sentBy;
  final int sentTo;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.notificationCategory,
    required this.seen,
    required this.sentBy,
    required this.sentTo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      createdAt: json['created_at'],
      modifiedAt: json['modified_at'],
      title: json['title'],
      shortDescription: json['short_description'],
      content: json['content'],
      notificationCategory: json['notification_category'],
      seen: json['seen'],
      sentBy: json['sent_by'],
      sentTo: json['sent_to'],
    );
  }

  NotificationModel copyWith({bool? seen}) {
    return NotificationModel(
      id: id,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
      title: title,
      shortDescription: shortDescription,
      content: content,
      notificationCategory: notificationCategory,
      seen: seen ?? this.seen,
      sentBy: sentBy,
      sentTo: sentTo,
    );
  }
}
