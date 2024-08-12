class RemoteModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  RemoteModel({required this.id, required this.userId, required this.title, required this.body});

  factory RemoteModel.fromJson(Map<String, dynamic> json) {
    return RemoteModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  RemoteModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return RemoteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}