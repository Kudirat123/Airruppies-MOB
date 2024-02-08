import 'package:airruppies/ui/send_money/bank_send_money/bank_send_money1.dart';
import 'package:airruppies/ui/send_money/send_money.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FirstSendMoney extends StatefulWidget {
   const FirstSendMoney({super.key});

  @override
  State<FirstSendMoney> createState() => _FirstSendMoneyState();
}

class _FirstSendMoneyState extends State<FirstSendMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton ('Send Money', context),
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const SendMoneyWidget()));
              },
              child: SendMoney(MdiIcons.pound, 'To AirRupple Account',
                  'Instant transfers with Zero charges'),
            ),
             const SizedBox(
              height: 12,
            ),
            InkWell( 
                 onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const BankSendMoneyWidget()));


                //  Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>   BankSendMoneyWidget()));
              },
              child: SendMoney(MdiIcons.wallet, 'To Other Account',
                  'Send Money to any Back Account'),
            )
          ],
        ),
      ),
    );
  }

  Widget SendMoney(IconData icon, String firstText, String secondText) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: !state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF7EDFC),
        ),
        child: Padding(
          padding:  const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                decoration:   BoxDecoration(
                  shape: BoxShape.circle,
                  color: !state.isDarkMode ? Colors.black: Colors.white,
                ),
                child: Padding(
                  padding:  const EdgeInsets.all(12.0),
                  child: Icon(
                    icon,
                    color:  !state.isDarkMode ? Colors.white: const Color(0xff551B73),
                    size: 19,
                  ),
                ),
              ),
               const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstText,
                      style: Theme.of(context).textTheme.displaySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                     const SizedBox(
                      height: 7,
                    ),
                    Text(
                      secondText,
                      style: Theme.of(context).textTheme.displaySmall!
                          .copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
               const Icon(Icons.arrow_forward_ios, size: 13)
            ],
          ),
        ),
      ),
    );
  }
}
