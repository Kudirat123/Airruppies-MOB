import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';

class TransactionHistoryDetails extends StatefulWidget {
   const TransactionHistoryDetails({super.key,  this.data});
  final dynamic data;

  @override
  State<TransactionHistoryDetails> createState() =>
      _TransactionHistoryDetailsState();
}

class _TransactionHistoryDetailsState extends State<TransactionHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBars().whiteAppBarWithBackButton('History Transaction', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SummaeyCard(
                  firstText: 'Transaction Type',
                  secondText: widget.data['type'],
                ),
                SummaeyCard(
                  firstText: 'Date',
                  secondText: widget.data['created_at'],
                ),
             
                SummaeyCard(
                  firstText: 'Amount',
                  secondText: widget.data['amount'],
                ),
                SummaeyCard(
                  firstText: 'Reference',
                  secondText: widget.data['reference'],
                ),
             
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            const Column(
              children: [
                MyButton(text: 'Download Reciept'),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
