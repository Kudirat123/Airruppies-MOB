import 'package:flutter/material.dart'; 

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessBonus extends StatefulWidget {
    const SuccessBonus({super.key});

  @override
  State<SuccessBonus> createState() => _SuccessBonusState();
}

class _SuccessBonusState extends State<SuccessBonus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding:   const EdgeInsets.all(20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const SizedBox(
                    height: 100,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/savings/savingsPlan/✔️.svg',
                    width: 200,
                  ),
                    const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Bonus Redeemed',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                    const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Your wallet has been credited with 2000NGN for your efforts. Refer more people and earn more money',
                    textAlign: TextAlign.center,
                    style: TextStyles()
                        .greyTextStyle()
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
                  )
                ],
              ),
            ),
            Padding(
              padding:   const EdgeInsets.symmetric(vertical: 20),
              child: SecondaryButton(
                text: 'Home',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>    MyHomePage(pageNumber: 0,)));
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
