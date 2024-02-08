class SavingsPlanModel {
  
  SavingsPlanModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
    features = List.castFrom<dynamic, String>(json['features']);
    min = json['min'];
    max = json['max'];
    icon = null;
    status = json['status'];
    interest = json['interest'];
    isRecurring = json['is_recurring'];
    minMaturityDate = json['min_maturity_date'];
  }
  SavingsPlanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.features,
    required this.min,
    required this.max,
     this.icon,
    required this.status,
    required this.interest,
    required this.isRecurring,
    required this.minMaturityDate,
  });
  late final int id;
  late final String title;
  late final String description;
  late final List<String> features;
  late final int min;
  late final int max;
  late final dynamic icon;
  late final String status;
  late final dynamic interest;
  late final bool isRecurring;
  late final dynamic minMaturityDate;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['features'] = features;
    data['min'] = min;
    data['max'] = max;
    data['icon'] = icon;
    data['status'] = status;
    data['interest'] = interest;
    data['is_recurring'] = isRecurring;
    data['min_maturity_date'] = minMaturityDate;
    return data;
  }
}