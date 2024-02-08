class BonusFriendModel {
  
  BonusFriendModel.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    referredUser = json['referred_user'];
    referralId = json['referral_id'];
    amountEarned = json['amount_earned'];
    status = json['status'];
  }
  BonusFriendModel({
    required this.userId,
    required this.referredUser,
    required this.referralId,
    required this.amountEarned,
    required this.status,
  });
  late final String userId;
  late final String referredUser;
  late final String referralId;
  late final int amountEarned;
  late final int status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['referred_user'] = referredUser;
    data['referral_id'] = referralId;
    data['amount_earned'] = amountEarned;
    data['status'] = status;
    return data;
  }
}