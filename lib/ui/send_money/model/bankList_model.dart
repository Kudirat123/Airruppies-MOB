class BankModel {

  BankModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
  }
  BankModel({
    required this.bankName,
    required this.bankCode,
  });
  late final String bankName;
  late final String bankCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_code'] = bankCode;
    return data;
  }
}
