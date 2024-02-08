import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/add_money/first_add_money_widget.dart';
import 'package:airruppies/ui/airtime/airtime/buy_airtime.dart';
import 'package:airruppies/ui/bill_payment/bill_payment.dart';
import 'package:airruppies/ui/send_money/first_send-money.dart';

import 'package:airruppies/utils/theme_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({super.key});

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            dashboardCircularButton(
                'assets/svgs/home_card_svgs/Topup.svg', 'Fund Wallet', context,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const FirstAddMoneyWidget())));
            }),
            dashboardCircularButton(
                'assets/svgs/home_card_svgs/Group.svg', 'Transfer', context,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const FirstSendMoney())));
            }),

            dashboardCircularButton(
                'assets/svgs/home_card_svgs/bill-Payment.svg',
                'Pay BIll',
                context, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BillPaymentWidget())));
            }),

            dashboardCircularButton(
                'assets/svgs/home_card_svgs/icon3.svg', 'Airtime/Data', context,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BuyAirtimeWidget())));
            }),
            // InkWell(
            //   onTap: () {
            //     Provider.of<DashboardState>(context, listen: false)
            //         .tapTransactionHistory = true;
            //   },
            //   child: dashboardCircularButton(
            //       SvgPicture.asset(
            //           'assets/svgs/home_card_svgs/transaction-history 1.svg'),
            //       'History',
            //       context, () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: ((context) =>   const AllTransactionWidget())));
            //   }),
            // ),

            // dashboardCircularButton(
            //     SvgPicture.asset('assets/svgs/home_card_svgs/icon3.svg'),
            //     'Buy Airtime',
            //     context, () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: ((context) =>  BuyAirtimeWidget())));
            // }),
            // dashboardCircularButton(
            //     SvgPicture.asset('assets/svgs/home_card_svgs/bill-Payment.svg'),
            //     'Pay BIll',
            //     context, () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: ((context) =>  BillPaymentWidget())));
            // }),
          ]),
          const SizedBox(
            height: 25,
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // dashboardCircularButton(
                //     SvgPicture.asset(
                //       'assets/svgs/home_card_svgs/Withdraw.svg',
                //       color: Colors.white,
                //     ),
                //     'Withdraw',
                //     context, () {
                //   // Navigator.push(
                //   //     context,
                //   //     MaterialPageRoute(
                //   //         builder: ((context) =>  HomeTransactionWidget())));
                // }),

                // dashboardCircularButton(
                //     SvgPicture.asset('assets/svgs/home_card_svgs/icon3.svg'),
                //     'Buy Data',
                //     context, () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: ((context) =>  Data2Widget())));
                // }),
                // dashboardCircularButton(
                //     SvgPicture.asset('assets/svgs/home_card_svgs/reward 1.svg'),
                //     'More',
                //     context, () {
                //   // Navigator.push(
                //   //     context,
                //   //     MaterialPageRoute(
                //   //         builder: ((context) =>  MoreWidget())));
                // }),
              ]),
        ],
      ),
    );
  }

  Widget dashboardCircularButton(String imageText, String title1,
      BuildContext context, VoidCallback onTap) {
    var themesState = Provider.of<ThemeProvider>(context, listen: true);

    return InkWell(
      splashColor: Colors.white,
      enableFeedback: false,
      highlightColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      onTap: onTap,
      child: SizedBox(
        height: 100,
        width: 80,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffF8F2FB), width: 2),
                    shape: BoxShape.circle),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    imageText,
                    color: !themesState.isDarkMode
                        ? Colors.white
                        : themes().primaryColor,
                  ),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title1,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
