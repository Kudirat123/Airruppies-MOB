import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/home/models/transaction_model.dart';
import 'package:airruppies/ui/transactions/transactions_state/transaction_state.dart';
import 'package:airruppies/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionSerice {
  Future<List<TransactionModel>> getTransactionList(context) async {
    var token = Provider.of<AuthState>(context, listen: false).token;
    Completer<List<TransactionModel>> completer =
        Completer<List<TransactionModel>>();

    HttpRequest(
      'transactions',
      context: context,
      // loader: LoaderType.popup,
      shouldPopOnError: false,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      onSuccess: (_, result) async {
        //pass user data to state before user get to the dashboard
        // Provider.of<AccountState>(context, listen: false).userDetails =
        //     result['data'];

        List<TransactionModel> transactionList = result['data']
            .map<TransactionModel>(
                (element) => TransactionModel.fromJson(element))
            .toList();

        Provider.of<TransactionState>(context, listen: false).transactionList = transactionList;

        completer.complete(transactionList);
      },
      onFailure: (_, result) {
        debugPrint(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
  }

  //Update Profile
}
