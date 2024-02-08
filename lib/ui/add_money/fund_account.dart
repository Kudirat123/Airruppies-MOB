import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/transaction_pin.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FundUssdAccountWidget extends StatefulWidget {
   const FundUssdAccountWidget({super.key});

  @override
  State<FundUssdAccountWidget> createState() => _FundUssdAccountWidgetState();
}

class _FundUssdAccountWidgetState extends State<FundUssdAccountWidget> {
 // final bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars().whiteAppBarWithBackButton('Fund via USSD', context),
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const SizedBox(
                  height: 4,
                ),
                Text(
                    'Make a USSD transfer from your bank account into your airruppies account',
                    textAlign: TextAlign.center,
                    style: TextStyles().greyTextStyle()),
                 const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color:  const Color(0xffF9F9FA),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:  const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Click or Enter  amount ',
                            style: TextStyles().greyTextStyle()),
                         const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Icon(MdiIcons.minus),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                     const EdgeInsets.symmetric(horizontal: 10),
                                child: OutlineInput(
                                  labelText: 'Amount',
                                  textCenter: true,
                                ),
                              ),
                            ),
                            Container(
                              decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Icon(MdiIcons.plus),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                 const SizedBox(
                  height: 15,
                ),
              ],
            ),
            MyButton(
              text: 'USSD code',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionPinWidget()));
              },
            )
          ],
        ),
      ),
    );
  }
}
