import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/airtime/airtime/buy_airtime.dart';
import 'package:airruppies/ui/bill_payment/bill_payment.dart';
import 'package:airruppies/ui/invitations/myBonus.dart';
import 'package:airruppies/ui/more/beneficiary/beneficiary.dart';
import 'package:airruppies/ui/send_money/send_money.dart';
import 'package:flutter/material.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({super.key});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Fund Transfer',
    },
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Airtime & Data',
    },
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Withdraw',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Add Money',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Bill Payment ',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'Beneficiary',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': '',
      'text2': 'My Bonus',
    },
    // Add more items here...

    //Widget List
  ];

  List<Widget> widgetList = [
    const SendMoneyWidget(),
    const BuyAirtimeWidget(),
    const BillPaymentWidget(),
    const BeneficiaryWidget(),
    const MyBonusWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBars().whiteAppBarWithBackButton('Bill Payments', context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                ),
                GridView.builder(
                  itemCount: items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // ignore: avoid_print
                        print(index);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => widgetList[index]));
                      },
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 2), // horizontal and vertical offset
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8.0),
                              Text(items[index]['text1'].toString(),
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                              Text(items[index]['text2'].toString(),
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
