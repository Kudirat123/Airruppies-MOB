class TransactionModel {
  
  TransactionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    image = json['image'];
    isCredit = json['is_credit'];
    reference = json['reference'];
  }
  TransactionModel({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
     this.image,
    required this.isCredit,
    required this.reference,
  });
  late final int id;
  late final String name;
  late final String type;
  late final String amount;
  late final dynamic status;
  late final String createdAt;
  late final dynamic image;
  late final bool isCredit;
  late final String reference;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['amount'] = amount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['image'] = image;
    data['is_credit'] = isCredit;
    data['reference'] = reference;
    return data;
  }
}