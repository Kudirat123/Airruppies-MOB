import 'dart:async';
import 'dart:convert';

import 'package:airruppies/ui/account/reset_pin/input_new_pin.dart';
import 'package:airruppies/ui/account/settings/settings.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/ui/upgarde_account/teir2/success_message.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/modal/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SettingsService {
  Map<String, dynamic>? userData;

  /// ******************************Security*************************

  Future<dynamic> getSecurityQuestion(context) {
    Completer<dynamic> completer = Completer<dynamic>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest('settings/security-question',
        context: context,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        shouldPopOnError: false, onSuccess: (_, result) async {
      completer.complete(result); // Resolve the completer with the result
    }, onFailure: (_, result) {
      debugPrint(result);
      completer.completeError(result); // Reject the completer with an error
    }).send();

    return completer.future; // Return the future for the caller to await
  }

  //Submit Security Question
  submitQuestion(context, var body) {
    Loaders().showModalLoading(context);
    HttpRequest('settings/security-question/verify',
        context: context,
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false,
        onSuccess: (_, result) async {}, onFailure: (_, result) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      debugPrint(result);
      return;
    }).send();
  }

  setSecurityQuestion(context) {
    //Loaders().showModalLoading(context);
    HttpRequest('settings/security-question',
        context: context,
        body: {'question': 0, 'answer': 'Ekiti'},
        loader: LoaderType.popup,
        shouldPopOnError: false,
        onSuccess: (_, result) async {}, onFailure: (_, result) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      debugPrint(result);
      return;
    }).send();
  }

  /// **************** Pin ****************************************

  resetPin(context, dynamic body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Loaders().showModalLoading(context);
    HttpRequest('settings/reset-txn-pin',
        context: context,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChooseANewPinWidget()));
    }, onFailure: (_, result) {
      debugPrint(result);
      return;
    }).send();
  }

  //get transaction Pin
  getPinCode(context) {
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest('settings/reset-txn-pin',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        context: context,
        shouldPopOnError: false,
        onSuccess: (_, result) async {}, onFailure: (_, result) {
      debugPrint(result);
      return;
    }).send();
  }

  changePassword(context, var body) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    //Loaders().showModalLoading(context);
    HttpRequest('auth/set-password',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: body,
        method: 'PATCH',
        context: context,
        onSuccess: (_, result) async {}, onFailure: (_, result) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      debugPrint(result);
      return;
    }).send();
  }

  /// *************************Verify  Pin for transcation
  verifyPin(context, String pin, dynamic data) {
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
      debugPrint('success');
      BankService().sendMoney(context, data);
    }, onFailure: (_, result) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      debugPrint(result.toString());
      return;
    }).send();
  }

  //upgrade tier

  upgradeAccount(context, dynamic data) {
    var token = Provider.of<AuthState>(context, listen: false).token;
    var state = Provider.of<AuthState>(context, listen: false);
    Loaders().showModalLoading(context);
    HttpRequest('upgrade/wallet?location=${state.userLocation}',
        context: context,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: data,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const UpgardeTierSuccessPage()));
      Modal().success(result['message'], context);
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

  //create new pin

  createPinInAppp(context, Map<String, dynamic> body) {
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
      Modal().success('Successfull', context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsWidget()));
    }, onFailure: (_, result) {
      // ignore: avoid_print
      print(result);
      return;
    }).send();
  }

  // get verify

  //change profile picture

  Future<dynamic> uploadAttachment(String imagePath, context) async {
    var token = Provider.of<AuthState>(context, listen: false).token;

    // ignore: avoid_print
    print(userData);
    Loaders().showModalLoading(context);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://airruppies.lazynerdstudios.com/api/v1/attachment/'));
    request.fields.addAll({
      'title': 'Profile Picture ',
      'description': 'front page',
    });

    // Replace 'file_path_here' with the actual file path of the image to upload.
    String filePath = imagePath;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode.toString().startsWith('2')) {
        String responseBody = await response.stream.bytesToString();
        // ignore: avoid_print
        print(responseBody);
        // userData =
        //     Provider.of<AccountState>(context, listen: false).userDetails;

  

        // ignore: avoid_print
    
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        return responseBody;
      } else {
        Navigator.pop(context);
        // ignore: avoid_print
        print(response.statusCode);
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return 'Error occurred: $e';
    }
  }

  ///upload document
  ///

  Future uploadDocumnet(
      String imagePath, context, String title, String description) async {
    var token = Provider.of<AuthState>(context, listen: false).token;

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://airruppies.lazynerdstudios.com/api/v1/attachment/'));
    request.fields.addAll({
      'title': title,
      'description': description,
    });

    // Replace 'file_path_here' with the actual file path of the image to upload.
    String filePath = imagePath;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode.toString().startsWith('2')) {
        var responseBody = json.decode(await response.stream.bytesToString());
        // ignore: avoid_print
        print(responseBody);
        return responseBody;
      } else {
        Navigator.pop(context);
        // ignore: avoid_print
        print(response.reasonPhrase);
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return 'Error occurred: $e';
    }
  }
}
