import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';

class BluetoothTransactionDetailsEidget extends StatefulWidget {
  const BluetoothTransactionDetailsEidget({super.key});

  @override
  State<BluetoothTransactionDetailsEidget> createState() =>
      _BluetoothTransactionDetailsEidgetState();
}

class _BluetoothTransactionDetailsEidgetState
    extends State<BluetoothTransactionDetailsEidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().myWhiteAppBar('Transaction Details', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SummaeyCard(
                  firstText: 'Transaction Type',
                  secondText: 'Fund Transfer',
                ),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ), 

                const SizedBox(height: 48,),


                ReUsablePin(),
                 const SizedBox(height: 12,),

                 Text(
                  'Verify this transaction with your PIN',
              textAlign: TextAlign.center,
              style: TextStyles().blackTextStyle().copyWith(
                  fontSize: 15,
                  color: const Color(0xffA2A0A8),
                  fontWeight: FontWeight.w500),
            ),

              
              ],
            ),
            const Column(children: [
              MyButton(text: 'Make Payment') 
            ,SizedBox(height: 20,),
            SecondaryButton(text: 'Cancel')

            ],)


            
          ],
        ),
      ),
    );
  }
}
