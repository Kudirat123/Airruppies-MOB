import 'package:airruppies/ui/home/models/transaction_model.dart';

import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';

import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';

class TransactionDetailsPage extends StatefulWidget {
  TransactionDetailsPage({
    super.key,
    this.data,
  });
  TransactionModel? data;

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  TextEditingController? userPin;

  @override
  void initState() {
    userPin = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  DateTime? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:
          AppBars().whiteAppBarWithBackButton('Transaction Details', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SummaeyCard(
                  firstText: 'Transaction Type',
                  secondText: widget.data!.type,
                ),
                SummaeyCard(
                  firstText: 'Date',
                  secondText: DateTime.now().toString(),
                ),
                SummaeyCard(
                  firstText: 'Amount',
                  secondText: '₦ ${widget.data!.amount}',
                ),
                SummaeyCard(
                  firstText: 'Receiver’s number',
                  secondText: widget.data!.name,
                ),
                SummaeyCard(
                  firstText: 'Reference',
                  secondText: widget.data!.reference,
                ),
                const SizedBox(
                  height: 48,
                ),
              
               
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
