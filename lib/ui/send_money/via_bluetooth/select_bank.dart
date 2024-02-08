import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/transaction_pin.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectBankWidget extends StatefulWidget {
   const SelectBankWidget({super.key});

  @override
  State<SelectBankWidget> createState() => _SelectBankWidgetState();
}

class _SelectBankWidgetState extends State<SelectBankWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const SizedBox(
                  height: 22,
                ),
                 const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.black,
                ),
                 const SizedBox(
                  height: 16,
                ),
                Text('Alex Armstrong',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
                 const SizedBox(
                  height: 4,
                ),
                Text('3244574701', style: TextStyles().greyTextStyle()),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'optional',
                      style:
                          TextStyles().greyTextStyle().copyWith(fontSize: 13),
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 15,
                ),
                OutlineInput(
                  labelText: 'What’s this for?',
                ),
                 const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Save as beneficiary',
                      style:
                          TextStyles().blackTextStyle().copyWith(fontSize: 14),
                    ),
                    CupertinoSwitch(
                      activeColor: themes().primaryColor,
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            MyButton(
              text: 'Proceed',
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
