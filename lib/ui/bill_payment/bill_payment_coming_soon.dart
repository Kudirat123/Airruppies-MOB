import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';

class BillPaymentComingPage extends StatefulWidget {
  const BillPaymentComingPage({super.key});

  @override
  State<BillPaymentComingPage> createState() => _BillPaymentComingPageState();
}

class _BillPaymentComingPageState extends State<BillPaymentComingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton('Coming Soon ', context),
      body:Center(child: Text('Coming soon' , style: TextStyles().blackTextStyle700().copyWith(fontSize: 20), ),)
    );
  }
}
