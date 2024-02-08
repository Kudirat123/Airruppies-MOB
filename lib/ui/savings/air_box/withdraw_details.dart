import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';

class Withdarw extends StatefulWidget {
  const Withdarw({super.key});

  @override
  State<Withdarw> createState() => _WithdarwState();
}

class _WithdarwState extends State<Withdarw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBars().myWhiteAppBar('Withdrawal Details', context),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 80,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyles().greyTextStyle().copyWith(
                          fontSize: 14,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    Text('Transactions',
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyles().greyTextStyle().copyWith(
                          fontSize: 14,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    Text('Transactions',
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyles().greyTextStyle().copyWith(
                          fontSize: 14,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    Text('Transactions',
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyles().greyTextStyle().copyWith(
                          fontSize: 14,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    Text('Transactions',
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            const Column(
              children: [
                MyButton(text: 'Continue'),
                SizedBox(
                  height: 15,
                ),
                SecondaryButton(text: 'Decline')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
