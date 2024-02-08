class BankBeneficiaryModel {
  
  BankBeneficiaryModel.fromJson(Map<String, dynamic> json){
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
  }
  BankBeneficiaryModel({
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
  });
  late final String accountNumber;
  late final String accountName;
  late final String bankName;
  late final String bankCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['bank_name'] = bankName;
    data['bank_code'] = bankCode;
    return data;
  }
}