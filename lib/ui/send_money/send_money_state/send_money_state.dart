import 'package:airruppies/ui/send_money/model/bankList_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class BankState with ChangeNotifier {
  String? token;

  List<BankModel>? bankList;

  String? name;
  List<Contact>? contactList;

  // void getProfileDetails(loginData) {
  //   profileDetails = loginData;

  //   notifyListeners();
  // }

  // void getBusinessDetails(loginData) {
  //   businessData = loginData;

  //   notifyListeners();
  // }
}
