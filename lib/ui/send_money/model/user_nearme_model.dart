class UserNearMeModel {
  
  UserNearMeModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
  }
  UserNearMeModel({
    required this.id,
    required this.phone,
    required this.name,
  });
  late final int id;
  late final String phone;
  late final String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}