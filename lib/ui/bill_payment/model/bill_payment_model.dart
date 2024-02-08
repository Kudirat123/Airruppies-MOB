class PaybillModel {
  
  PaybillModel.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id'];
    listOrder = json['list_order'];
    name = json['name'];
  }
  PaybillModel({
    required this.categoryId,
    required this.listOrder,
    required this.name,
  });
  late final int categoryId;
  late final String listOrder;
  late final String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['list_order'] = listOrder;
    data['name'] = name;
    return data;
  }
}