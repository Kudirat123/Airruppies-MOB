class NotificationModel {
  
  NotificationModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = Data.fromJson(json['data']);
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
     this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String type;
  late final String notifiableType;
  late final int notifiableId;
  late final Data data;
 var readAt;
  late final String createdAt;
  late final String updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['notifiable_type'] = notifiableType;
    data['notifiable_id'] = notifiableId;
    data['data'] = data;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  
  Data.fromJson(Map<String, dynamic> json){
    title = json['title'];
    body = json['body'];
  }
  Data({
    required this.title,
    required this.body,
  });
  late final String title;
  late final String body;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}