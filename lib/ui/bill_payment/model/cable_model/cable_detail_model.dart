class CableDetailModel {
  
  CableDetailModel.fromJson(Map<String, dynamic> json){
    amount = json['amount'];
    id = json['id'];
    name = json['name'];
  }
  CableDetailModel({
    required this.amount,
    required this.id,
    required this.name,
  });
  late final String amount;
  late final String id;
  late final String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}