import 'dart:async';

import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/airtime/airtime/airtime_succesful.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/utils/loaders.dart';

import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AirtimeSerice {
  Future<dynamic> airtimeList(context) async {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Completer<dynamic> completer = Completer<dynamic>();

    HttpRequest(
      '/payBill/airtime',
      context: context,
      // loader: LoaderType.popup,
      shouldPopOnError: false,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      onSuccess: (_, result) async {
        completer.complete(result);
        //pass user data to state before user get to the dashboard
        Provider.of<AccountState>(context, listen: false).userDetails =
            result['data'];
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //Update Profile

  void buyAirtime(context, dynamic body) {
    Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      '/payBill/airtime/purchase?type=${body['serviceProvider']}',
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

  buyPinAirtime(context, String pin, dynamic data) {
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
      buyAirtime(context, data);
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
