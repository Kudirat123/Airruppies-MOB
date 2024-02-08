class ContactSyncModel {
  
  ContactSyncModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    contactId = json['contact_id'];
    phone = json['phone'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  ContactSyncModel({
    required this.id,
    required this.userId,
    required this.contactId,
    required this.phone,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final int contactId;
  late final String phone;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['contact_id'] = contactId;
    data['phone'] = phone;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}