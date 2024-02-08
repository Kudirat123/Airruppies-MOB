import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_state/bill_payment_state.dart';
import 'package:airruppies/ui/bill_payment/model/bill_payment_model.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model/cable_detail_model.dart';

import 'package:airruppies/utils/network.dart';
import 'package:provider/provider.dart';

class BillPaymentService {
  //get advertisment
  Future<List<PaybillModel>> getBillService(context) async {
    Completer<List<PaybillModel>> completer = Completer<List<PaybillModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<PaybillModel> billPaymentServiceList = result
            .map<PaybillModel>((element) => PaybillModel.fromJson(element))
            .toList();

        Provider.of<BillPaymentState>(context, listen: false).billList =
            billPaymentServiceList;

        completer.complete(billPaymentServiceList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }

  //get cable service
  Future<List<CableModel>> getCableService(context) async {
    Completer<List<CableModel>> completer = Completer<List<CableModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/cable',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<CableModel> cableServiceList = result
            .map<CableModel>((element) => CableModel.fromJson(element))
            .toList();

        List<CableModel> cableServiceLists = cableServiceList
            .where((element) =>
                element.status.toString().toLowerCase().contains('in'))
            .toList();

        Provider.of<BillPaymentState>(context, listen: false).cableList =
            cableServiceLists;

        completer.complete(cableServiceLists);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }

  Future<List<CableDetailModel>> getCableDetailsService(
      context, String id) async {
    Completer<List<CableDetailModel>> completer =
        Completer<List<CableDetailModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/field/assigned/byBillId/$id',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<CableDetailModel> cableServiceList = result['fields'][1]['list']
                ['items']
            .map<CableDetailModel>(
                (element) => CableDetailModel.fromJson(element))
            .toList();

        completer.complete(cableServiceList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }

  //get utitlity

  Future<List<CableModel>> getUtilityService(context) async {
    Completer<List<CableModel>> completer = Completer<List<CableModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/prepaid',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<CableModel> cableServiceList = result
            .map<CableModel>((element) => CableModel.fromJson(element))
            .toList();

        Provider.of<BillPaymentState>(context, listen: false).utilityList =
            cableServiceList;

        completer.complete(cableServiceList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }

  //get sport bet lsit

  Future<List<CableModel>> getSportBetService(context) async {
    Completer<List<CableModel>> completer = Completer<List<CableModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/betting',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<CableModel> cableServiceList = result
            .map<CableModel>((element) => CableModel.fromJson(element))
            .toList();

        Provider.of<BillPaymentState>(context, listen: false).sportBetList =
            cableServiceList;

        completer.complete(cableServiceList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }
}
