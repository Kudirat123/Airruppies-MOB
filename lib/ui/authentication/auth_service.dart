import 'package:airruppies/ui/account/account_service/account_service.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/authentication/confirm_new_device.dart/new_device_otp.dart';
import 'package:airruppies/ui/authentication/forgot_password/otp_forgot_password.dart';
import 'package:airruppies/ui/authentication/forgot_password/reset_password.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_service/bill_payment_service.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/savings/savings_service/savings_service.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/ui/transactions/transaction_service/transaction_service.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/modal/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class AuthService {
  bvn(context) {
    Loaders().showModalLoading(context);
    HttpRequest('auth',
        context: context,
        body: {'bvn': '22476228085'},
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  //verify Bvn
  verifyBvn(context) {
    Loaders().showModalLoading(context);
    HttpRequest('auth/verify-bvn-otp',
        context: context,
        body: {'bvn': '22476228085', 'otp': '861183'},
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  //set Password
  setPassword(context) {
    Loaders().showModalLoading(context);
    HttpRequest('auth/verify-bvn-otp',
        context: context,
        body: {
          'password': '12345678',
          'password_confirmation': '12345678',
          'device_id': 'web'
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  setPin(context) {
    Loaders().showModalLoading(context);
    HttpRequest('auth/verify-bvn-otp',
        context: context,
        body: {
          // 'old_pin': '2512',
          'pin': '2512',
          'pin_confirmation': '2512',
          'location': '5.343433,7.739793'
        },
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

//Login

  login(BuildContext context, dynamic body) async {
    //// ignore: avoid_print
    print(Provider.of<AuthState>(context, listen: false).userLocation);
    Loaders().showModalLoading(context);
    HttpRequest('auth/login',
        method: 'POST',
        context: context,
        body: body,
        shouldPopOnError: false, onSuccess: (_, result) async {
      if (result['message'].toString().contains('Unrecognized')) {
        Provider.of<AuthState>(context, listen: false).token =
            result['data']['token'];
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewDeviceOtpPage()));
      } else {
        //pass token to state
        Provider.of<AuthState>(context, listen: false).token =
            result['data']['token'];

        //This is here to fetch the user details
        await AccountSerice().getProfile(context);
        //Fetch Bonus and invitaion
        await AccountSerice().getBonusDetails(context);
        await AccountSerice().getInvitationDetails(context);
        await BankService().getBankList(context);
        // await TransactionSerice().getTransactionList(context);
        await SavingsService().getSavingsPlan(context);
        await BillPaymentService().getBillService(context);
        await BillPaymentService().getCableService(context);
        await BillPaymentService().getUtilityService(context);
        await BillPaymentService().getSportBetService(context);
        // tools.putInStore('accessToken', result['data']['token']);

        tools.putInStore('username', body['identifier']);
        tools.putInStore('password', body['password']);

        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      pageNumber: 0,
                    )));
      }
    }, onFailure: (_, result) {
      Navigator.pop(context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //              MyHomePage()));
      // ignore: avoid_print
      print(result);
      //debugPrint(result);
      return;
    }).send();
  }

  /// ************************** forgot password

  getOtpforResetPassword(context, dynamic body) {
    Loaders().showModalLoading(context);
    HttpRequest('auth/password/request',
        context: context,
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpForgotPassword(data: body)));
      // ignore: avoid_print
      print(result);
      //  tools.putInStore('accessToken', result['data']['token']);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  resendResetPasswordOtp(context, dynamic body) {
    HttpRequest('auth/password/request',
        context: context,
        body: body,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Modal().comingSoonToast('We have just sent a code to your mail', context);
      // ignore: avoid_print
      print(result);
      //  tools.putInStore('accessToken', result['data']['token']);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  verifyOtpforResetPassword(context, dynamic body) {
    Loaders().showModalLoading(context);
    HttpRequest('/auth/password/reset/${body['otp']}',
        context: context,
        body: body,
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ResetPassword(body: body)));
      //  tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  ResetPasswordfunction(context, dynamic body) {
    Loaders().showModalLoading(context);
    HttpRequest('/auth/password/reset',
        context: context,
        body: body,
        method: 'PUT',
        loader: LoaderType.popup,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginWidget()));
      //  tools.putInStore('accessToken', result['data']['token']);
      debugPrint(result);
    }, onFailure: (_, result) {
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }

  /// *****************************

  verifyNewDevice(context, dynamic body) {
    Loaders().showModalLoading(context);
    var token = Provider.of<AuthState>(context, listen: false).token;
    HttpRequest('auth/verify-new-device',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        context: context,
        body: body,
        shouldPopOnError: false, onSuccess: (_, result) async {
      Provider.of<AuthState>(context, listen: false).token =
          result['data']['token'];
      //This is here to fetch the user details
      await AccountSerice().getProfile(context);
      //Fetch Bonus and invitaion
      await AccountSerice().getBonusDetails(context);
      await AccountSerice().getInvitationDetails(context);
      await BankService().getBankList(context);
      await TransactionSerice().getTransactionList(context);
      await SavingsService().getSavingsPlan(context);
      await BillPaymentService().getBillService(context);
      await BillPaymentService().getCableService(context);
      await BillPaymentService().getUtilityService(context);
      await BillPaymentService().getSportBetService(context);
      // tools.putInStore('accessToken', result['data']['token']);
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    pageNumber: 0,
                  )));

      //  tools.putInStore('accessToken', result['data']['token']);
    }, onFailure: (_, result) {
      Navigator.of(context, rootNavigator: true).pop();
      //Navigator.pop(context);
      debugPrint(result);
      return;
    }).send();
  }
}
