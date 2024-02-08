import 'dart:async';

import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/account/profile.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/invitations/bonus_success.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/modal/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSerice {
  Future<dynamic> getProfile(context) async {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Completer<dynamic> completer = Completer<dynamic>();

    HttpRequest(
      '/auth?location=${Provider.of<AuthState>(context, listen: false).userLocation}',
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

  updateProfile(context, Map<String, dynamic> body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('/auth/profile?location=5.673832,6.383973',
        context: context,
        method: 'PUT',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        isPut: true,
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      // ignore: avoid_print
      print(body);
      Provider.of<AccountState>(context, listen: false).userDetails =
          result['data'];
      Modal().success('Profile picture updated ', context);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileWidget()));
      // ignore: avoid_print
      print(body);
    }, onFailure: (_, result) {
      debugPrint(result);
      return;
    }).send();
  }

  //get wallet

  getInvitationDetails(context) {
    //Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;
    HttpRequest('invitation',
        context: context,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        // loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Provider.of<AccountState>(context, listen: false).invitationDetails =
          result['data'];
    }, onFailure: (_, result) {
      return;
    }).send();
  }

  //get Bounus Details

  getBonusDetails(context) {
    //Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;
    HttpRequest('bonus',
        context: context,
        // loader: LoaderType.popup,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        shouldPopOnError: false, onSuccess: (_, result) async {
      Provider.of<AccountState>(context, listen: false).bonuDetails =
          result['data'];
    }, onFailure: (_, result) {
      return;
    }).send();
  }
  //withdraw bonus funds

  withdrawBonus(context, Map<String, dynamic> body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('bonus',
        context: context,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SuccessBonus()));
    }, onFailure: (_, result) {
      // ignore: avoid_print
      print(result);
      return;
    }).send();
  }
}
