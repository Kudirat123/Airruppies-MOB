import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/ui/authentication/registration/bvn_otp.dart';
import 'package:airruppies/ui/authentication/registration/create_password.dart';
import 'package:airruppies/ui/authentication/registration/pin.dart';
import 'package:airruppies/ui/authentication/registration/register.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationSerice {
  Future<dynamic> submitBvn(context, dynamic body) async {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Completer<dynamic> completer = Completer<dynamic>();
    Loaders().showModalLoading(context);

    HttpRequest(
      'auth',
      context: context,
      loader: LoaderType.popup,
      body: body,
      shouldPopOnError: false,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      onSuccess: (_, result) async {
        completer.complete(result);
        //pass user data to state before user get to the dashboard
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BvnOtp(data: result['data'], bvn: body)));
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //Update Profile

  resendBvnOtp(context, Map<String, dynamic> body) {
    //Loaders().showModalLoading(context);
    HttpRequest('auth/send-bvn-otp',
        context: context,
        method: 'POST',
        body: body,
        // loader: LoaderType.popup,
        shouldPopOnError: false,
        onSuccess: (_, result) async {}, onFailure: (_, result) {
      debugPrint(result);
      return;
    }).send();
  }

  Future<dynamic> submitBvnOtp(context, dynamic body) async {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Completer<dynamic> completer = Completer<dynamic>();

    HttpRequest(
      'auth/verify-bvn-otp',
      context: context,
      loader: LoaderType.popup,
      body: body,
      shouldPopOnError: false,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      onSuccess: (_, result) async {
        completer.complete(result);
        //pass user data to state before user get to the dashboard

        Provider.of<AuthState>(context, listen: false).token =
            result['data']['token'];
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //get wallet
  registerUser(context, Map<String, dynamic> body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('auth/register',
        context: context,
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Provider.of<AuthState>(context, listen: false).token =
          result['data']['token'];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CreatePasswordWidget()));
    }, onFailure: (_, result) {
      return;
    }).send();
  }

  //get Bounus Details

  createPassword(context, dynamic body) {
    Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;
    HttpRequest('auth/set-password',
        context: context,
        loader: LoaderType.popup,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        shouldPopOnError: false, onSuccess: (_, result) async {
      Provider.of<AuthState>(context, listen: false).token =
          result['data']['token'];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CreatePin()));
    }, onFailure: (_, result) {
      return;
    }).send();
  }
  //withdraw bonus funds

  createPin(context, Map<String, dynamic> body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('auth/set-pin',
        context: context,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginWidget()));
    }, onFailure: (_, result) {
      // ignore: avoid_print
      print(result);
      return;
    }).send();
  }
}
