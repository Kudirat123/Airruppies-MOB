import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/savings/air_box/sucess_air_box.dart';
import 'package:airruppies/ui/savings/model/savings_plan_model.dart';
import 'package:airruppies/ui/savings/model/user_savings_model.dart';
import 'package:airruppies/ui/savings/savings_state/savings_state.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/modal/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavingsService {
  //get user saving list
  Future<List<UserSavingsModel>> getUserSavingsList(context) async {
    Completer<List<UserSavingsModel>> completer =
        Completer<List<UserSavingsModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'savings?location=5.673832,6.383973',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<UserSavingsModel> advertList = result['data']
            .map<UserSavingsModel>(
                (element) => UserSavingsModel.fromJson(element))
            .toList();

        completer.complete(advertList);
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

  Future<List<UserSavingsModel>> getUserCompletedSavingsList(context) async {
    Completer<List<UserSavingsModel>> completer =
        Completer<List<UserSavingsModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'savings?location=5.673832,6.383973&completed',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<UserSavingsModel> advertList = result['data']
            .map<UserSavingsModel>(
                (element) => UserSavingsModel.fromJson(element))
            .toList();

        completer.complete(advertList);
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

  //get main account

  Future<List<SavingsPlanModel>> getSavingsPlan(context) async {
    Completer<List<SavingsPlanModel>> completer =
        Completer<List<SavingsPlanModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/savings/plans?location=5.673832,6.383973',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<SavingsPlanModel> savingsList = result['data']
            .map<SavingsPlanModel>(
                (element) => SavingsPlanModel.fromJson(element))
            .toList();

        Provider.of<SavingsState>(context, listen: false).savingPlan =
            savingsList;

        completer.complete(savingsList);
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

  //get savings account

  Future<dynamic> createSavings(context, dynamic body, dynamic int) async {
    Loaders().showModalLoading(context);
    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'savings/new/$int',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      body: body,
      loader: LoaderType.popup,
      onSuccess: (_, result) async {
        completer.complete(result['data']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessAirBox(data: result['data'])));
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

 void  withdrawSavings(context, dynamic body, dynamic id) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('savings/withdraw/$id',
        context: context,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    pageNumber: 0,
                  )));
      Modal().success(result['message'], context);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }
}
