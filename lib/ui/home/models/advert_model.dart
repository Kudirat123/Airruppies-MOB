class AdvertModel  {
  
  AdvertModel .fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    image = json['image'];
   // reasons = json['reasons'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }
  AdvertModel ({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.image,
    //required this.reasons,
    required this.createdBy,
    required this.createdAt,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String status;
  late final String image;
 // late final String reasons;
  late final String createdBy;
  late final String createdAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['image'] = image;
    //data['reasons'] = reasons;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}