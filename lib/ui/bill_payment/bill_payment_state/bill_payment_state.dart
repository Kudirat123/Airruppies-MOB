import 'package:airruppies/ui/bill_payment/model/bill_payment_model.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model.dart';
import 'package:flutter/material.dart';

class BillPaymentState with ChangeNotifier {
  List<PaybillModel>? billList;
  List<CableModel>? cableList;
  List<CableModel>? utilityList;
  List<CableModel>? sportBetList;
}
