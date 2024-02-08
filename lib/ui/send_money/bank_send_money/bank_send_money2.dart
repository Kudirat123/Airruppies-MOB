import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/send_money/transaction_pin.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BankSendMoneyWidget2 extends StatefulWidget {
  const BankSendMoneyWidget2({super.key, this.data});
  final Map<String, Object?>? data;

  @override
  State<BankSendMoneyWidget2> createState() => _BankSendMoneyWidget2State();
}

class _BankSendMoneyWidget2State extends State<BankSendMoneyWidget2> {
  bool? _switchValue;
  TextEditingController? amountController;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: '0');
    _switchValue = widget.data!['save'] == true ? true : false;
  }

 void  addTenToNumber() {
    setState(() {
      double newValue = double.parse(amountController!.text) + 10;
      amountController!.text = newValue.toString();
      // ignore: avoid_print
      print(amountController!.text);
    });
  }

  void subtractTenToNumber() {
    if (double.parse(amountController!.text) < 1) {
    } else {
      setState(() {
        double newValue = double.parse(amountController!.text) - 10;
        amountController!.text = newValue.toString();
        // ignore: avoid_print
        print(amountController!.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    CircleAvatar(
                        radius: 38,
                        backgroundColor: themes().primaryColor,
                        child: Text(
                          widget.data!['account_name'].toString()[0],
                          style: TextStyles().whiteTextStyle(context),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(widget.data!['account_name'].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(widget.data!['account_number'].toString(),
                        style: TextStyles().greyTextStyle()),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: !state.isDarkMode
                              ? const Color(0xff1F1723)
                              : const Color(0xffF9F9FA),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Click or Enter  amount ',
                                style: TextStyles().greyTextStyle()),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                // InkWell(
                                //   onTap: () {
                                //     subtractTenToNumber();
                                //   },
                                //   child: Container(
                                //     decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Colors.white,
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(7.0),
                                //       child: Icon(MdiIcons.minus),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: OutlineInput(
                                      labelText: 'Amount',
                                      textCenter: true,
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     addTenToNumber();
                                //   },
                                //   child: Container(
                                //     decoration: const BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Colors.white,
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(7.0),
                                //       child: Icon(MdiIcons.plus),
                                //     ),
                                //   ),
                                // ),
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
                          style: TextStyles()
                              .greyTextStyle()
                              .copyWith(fontSize: 13),
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
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 14),
                        ),
                        CupertinoSwitch(
                          activeColor: themes().primaryColor,
                          value: _switchValue!,
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
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                  text: 'Proceed',
                  onPressed: () {
                    var position =
                        Provider.of<AuthState>(context, listen: false)
                            .userLocation;
                    // ignore: avoid_print
                    print(position);
                    setState(() {
                      widget.data!['amount'] = amountController!.text;
                      widget.data!['save'] = _switchValue;
                      //widget.data!['location'] = position;
                    });

                    // ignore: avoid_print
                    print(widget.data);

                    //   BankService().sendMoney(context, widget.data);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TransactionPinWidget(data: widget.data)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
