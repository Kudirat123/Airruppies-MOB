class CableModel {
  
  CableModel.fromJson(Map<String, dynamic> json){
    billId = json['bill_id'];
    categoryId = json['category_id'];
    commissionId = json['commission_id'];
    description = json['description'];
    feeId = json['fee_id'];
    listOrder = json['list_order'];
    name = json['name'];
    providerId = json['provider_id'];
    status = json['status'];
  }
  CableModel({
    required this.billId,
    required this.categoryId,
    required this.commissionId,
    required this.description,
    required this.feeId,
    required this.listOrder,
    required this.name,
    required this.providerId,
    required this.status,
  });
  late final int billId;
  late final String categoryId;
  late final String commissionId;
  late final String description;
  late final String feeId;
  late final String listOrder;
  late final String name;
  late final String providerId;
  late final String status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bill_id'] = billId;
    data['category_id'] = categoryId;
    data['commission_id'] = commissionId;
    data['description'] = description;
    data['fee_id'] = feeId;
    data['list_order'] = listOrder;
    data['name'] = name;
    data['provider_id'] = providerId;
    data['status'] = status;
    return data;
  }
}