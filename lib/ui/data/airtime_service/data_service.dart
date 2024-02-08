import 'dart:async';

import 'package:airruppies/ui/airtime/airtime/airtime_succesful.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model/cable_detail_model.dart';
import 'package:airruppies/utils/loaders.dart';

import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DataService {
  //Update Profile

  Future<List<CableDetailModel>> getDataList(context, String name) async {
    Completer<List<CableDetailModel>> completer =
        Completer<List<CableDetailModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/data/plans?type=$name',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<CableDetailModel> cableServiceList = result['data']['items']
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

  void buyData(context, dynamic body) {
    Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/data/purchase?type=${body['serviceProvider']}',
      context: context,
      loader: LoaderType.popup,
      body: body,
      shouldPopOnError: false,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      onSuccess: (_, result) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AirtimeSuccessWidget(
                      data: body,
                    )));
      },
      onFailure: (_, result) {
        debugPrint(result);
      },
    ).send();
  }

  void buyPinData(context, String pin, dynamic data) {
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
      buyData(context, data);
      data;
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
}
