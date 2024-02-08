import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/send_money/model/bankList_model.dart';
import 'package:airruppies/ui/send_money/model/bank_beneficary_model.dart';
import 'package:airruppies/ui/send_money/model/contact_model.dart';
import 'package:airruppies/ui/send_money/model/user_nearme_model.dart';
import 'package:airruppies/ui/send_money/send_money_state/send_money_state.dart';
import 'package:airruppies/ui/send_money/send_money_sucess.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class BankService {
  //get bank list
  Future<List<BankModel>> getBankList(context) async {
    //Loaders().showModalLoading(context);
    Completer<List<BankModel>> completer = Completer<List<BankModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    var userState = Provider.of<AuthState>(context, listen: false);

    HttpRequest(
      'banking?location=${userState.userLocation}',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<BankModel> banktLists = result['data']
            .map<BankModel>((element) => BankModel.fromJson(element))
            .toList();

        Provider.of<BankState>(context, listen: false).bankList = banktLists;

        completer.complete(banktLists);
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

  //get verify account

  Future<dynamic> verifyAccountNumber(context, dynamic data) async {
    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    //Loaders().showModalLoading(context);

    HttpRequest(
      'banking/verify-account',
      method: 'POST',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      loader: LoaderType.popup,
      body: data,
      onSuccess: (_, result) async {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
        });
        // ignore: avoid_print
        print(result);
        completer.complete(result);
      },
      onFailure: (_, result) {
        Navigator.pop(context);
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //get send money

  Future<dynamic> sendMoney(context, dynamic data) async {
    Loaders().showModalLoading(context);

    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'banking/nip-transfer',
      method: 'POST',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      loader: LoaderType.popup,
      body: data,
      onSuccess: (_, result) async {
        completer.complete(result);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SendMoneySuccessWidget(data: result['data'])));
      },
      onFailure: (_, result) {
        // Navigator.pop(context);

        SnackBar(content: Text('${result['message']}'));
        // ignore: avoid_print
        print('rfrfr $result');
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  verifyAirPin(context, String pin, dynamic data) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('auth/verify-pin',
        context: context,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'pin': pin,
          'location':
              Provider.of<AuthState>(context, listen: false).userLocation,
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      // ignore: avoid_print
      print('sucess');
      BankService().sendMoney(context, data);
    }, onFailure: (_, result) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      // ignore: avoid_print
      print(result);
      return;
    }).send();
  }

  /// ***********************************************p2p transfer*********************************

  Future<List<BankBeneficiaryModel>> getBeneficiaryList(context) async {
    //Loaders().showModalLoading(context);
    Completer<List<BankBeneficiaryModel>> completer =
        Completer<List<BankBeneficiaryModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    var userState = Provider.of<AuthState>(context, listen: false);
    // ignore: avoid_print
    print(userState.userLocation);

    HttpRequest(
      '/banking/beneficiaries?location=${userState.userLocation}',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<BankBeneficiaryModel> banktLists = result['data']
            .map<BankBeneficiaryModel>(
                (element) => BankBeneficiaryModel.fromJson(element))
            .toList();

        completer.complete(banktLists);
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

  //check for  airruppies customer

  Future<dynamic> checkForAirruppiesCustomer(
      context, String phoneNumber) async {
    Loaders().showModalLoading(context);

    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    var userState = Provider.of<AuthState>(context, listen: false);

    HttpRequest(
      'banking/p2p?location=${userState.userLocation}&identifier=$phoneNumber',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      loader: LoaderType.popup,
      onSuccess: (_, result) async {
        completer.complete(result);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SendMoneySuccessWidget(data: data)));
      },
      onFailure: (_, result) {
        SnackBar(content: Text('${result['message']}'));
        // ignore: avoid_print
        print('rfrfr $result');
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  /// *********************************************get airruppies user around ************
  Future<List<UserNearMeModel>> getUserNearMe(
    context,
  ) async {
    Completer<List<UserNearMeModel>> completer =
        Completer<List<UserNearMeModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    var userState = Provider.of<AuthState>(context, listen: false);

    HttpRequest(
      'nearme?location=${userState.userLocation}',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      onSuccess: (_, result) async {
        List<UserNearMeModel> userNearMeList = result['data']
            .map<UserNearMeModel>(
                (element) => UserNearMeModel.fromJson(element))
            .toList();

        completer.complete(userNearMeList);
      },
      onFailure: (_, result) {
        SnackBar(content: Text('${result['message']}'));
        // ignore: avoid_print
        print('rfrfr $result');
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  ///send  Contact
  ///
  Future<List<ContactSyncModel>> sendContact(
    List<String?>? contatctList,
    context,
  ) async {
    Completer<List<ContactSyncModel>> completer =
        Completer<List<ContactSyncModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;
    //var userState = Provider.of<AuthState>(context, listen: false);

    HttpRequest(
      'auth/sync-contacts',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      loader: LoaderType.popup,
      body: {'contacts': contatctList},
      onSuccess: (_, result) async {
        List<ContactSyncModel> userNearMeList = result['data']
            .map<ContactSyncModel>(
                (element) => ContactSyncModel.fromJson(element))
            .toList();
        // ignore: avoid_print
        print(userNearMeList);

        completer.complete(userNearMeList);
      },
      onFailure: (_, result) {
        SnackBar(content: Text('${result['message']}'));
        // ignore: avoid_print
        print('rfrfr $result');
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }
}
