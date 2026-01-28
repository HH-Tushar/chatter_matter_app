
class NotificationModel {
  final String id;
  final String title;
  final String userId;
  final String type;
  final String screen;
  final String subTitle;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.type,
    required this.screen,
    required this.subTitle,
    required this.createdAt,
  });

  /// FROM JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      userId: json['userId'] as String,
      type: json['type'] ,
      screen: json['screen'] as String,
      subTitle: json['subTitle'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

}



class NotificationResponse {
  final int count;
  final String? pageToken;
  final List<NotificationModel> data;

  NotificationResponse({
    required this.count,
    required this.pageToken,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      count: json['count'] as int,
      pageToken: json['pageToken'] as String?,
      data: (json['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList(),
    );
  }
}
