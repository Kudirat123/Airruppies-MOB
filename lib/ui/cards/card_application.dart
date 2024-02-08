import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';

class CardApplicationWidget extends StatefulWidget {
  const CardApplicationWidget({super.key});

  @override
  State<CardApplicationWidget> createState() => _CardApplicationWidgetState();
}

class _CardApplicationWidgetState extends State<CardApplicationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars().whiteAppBarWithBackButton(' Card Application', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const SizedBox(height: 11,),
                   const SizedBox(height: 30,), 

                Text('Personal information'  ,style: TextStyles().blackTextStyle().copyWith(fontWeight: FontWeight.w600 ,fontSize: 14),),
                    const SizedBox(height: 11,),

                  
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
                const SizedBox(height: 30,), 

                Text('Fee and Charges'  ,style: TextStyles().blackTextStyle().copyWith(fontWeight: FontWeight.w600 ,fontSize: 14),),
                    const SizedBox(height: 11,),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                const SummaeyCard(
                  firstText: 'Date',
                  secondText: 'Fund Transfer',
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            const Column(
              children: [MyButton(text: 'Submit')],
            )
          ],
        ),
      ),
    );
  }
}
