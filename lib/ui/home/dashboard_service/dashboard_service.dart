import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/home/models/advert_model.dart';
import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardService {
  //get advertisment
  Future<List<AdvertModel>> getAdvertisment(context) async {
    Completer<List<AdvertModel>> completer = Completer<List<AdvertModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'dashboard/ads?per_page=3&page=1',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      //  loader: LoaderType.popup,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        List<AdvertModel> advertList = result['data']
            .map<AdvertModel>((element) => AdvertModel.fromJson(element))
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

  Future<dynamic> getMainAccount(context) async {
    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'dashboard',
      method: 'GET',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        completer.complete(result);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //get savings account

  Future<dynamic> getMainSaving(context) async {
    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'dashboard/savings',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      context: context,
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        completer.complete(result['data']);
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }
}
