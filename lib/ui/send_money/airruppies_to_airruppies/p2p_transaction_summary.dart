import 'package:airruppies/themes.dart';

import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';

import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class P2PTransactionSummaryPage extends StatefulWidget {
 const  P2PTransactionSummaryPage({super.key, this.data});
 final Map<String, Object?>? data;

  @override
  State<P2PTransactionSummaryPage> createState() => _P2PTransactionSummaryPageState();
}

class _P2PTransactionSummaryPageState extends State<P2PTransactionSummaryPage> {
  TextEditingController? userPin;

  @override
  void initState() {
    userPin = TextEditingController();
    
    super.initState();
  }

  DateTime? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar:
          AppBars().whiteAppBarWithBackButton('Transaction Details', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
         
          children: [
            const SummaeyCard(
              firstText: 'Transaction Type',
              secondText: 'Fund Transfer',
            ),
            SummaeyCard(
              firstText: 'Date',
              secondText: DateTime.now().toString(),
            ),
            SummaeyCard(
              firstText: 'Amount',
              secondText: 'N ${widget.data!['amount'].toString()}',
            ),
            SummaeyCard(
              firstText: 'Receiver’s number',
              secondText: widget.data!['account_number'].toString(),
            ),
            SummaeyCard(
              firstText: 'Receiver’s Bank',
              secondText: widget.data!['bank_name'].toString(),
            ),
            const SizedBox(
              height: 48,
            ),
            ReUsablePin(
              textController: userPin,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Verify this transaction with your PIN',
              textAlign: TextAlign.center,
              style: TextStyles().blackTextStyle().copyWith(
                  fontSize: 15,
                  color: const Color(0xffA2A0A8),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 90,),
            Column(
              children: [
                MyButton(
                  text: 'Make Payment',
                  onPressed: () {
                    var reference = tools.generateRandomString(20);
                    setState(() {
                       widget.data!['session_id'] = reference.toString();
                      
                    });
                   
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const SendMoneySuccessWidget()));
                    
                        BankService().verifyAirPin(context, userPin!.text, widget.data);

                    ///BankService().sendMoney(context, widget.data);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SecondaryButton(text: 'Cancel')
              ],
            )
          ],
        ),
      ),
    );
  }
}
