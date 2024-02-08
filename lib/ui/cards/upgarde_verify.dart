import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/cards/proof_of_residency.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UPgradeVerifyWidget extends StatefulWidget {
  const UPgradeVerifyWidget({super.key});

  @override
  State<UPgradeVerifyWidget> createState() => _UPgradeVerifyWidgetState();
}

class _UPgradeVerifyWidgetState extends State<UPgradeVerifyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset('assets/svgs/card_svgs/Icon (1).svg'),
                Text('First, let’s verify your identity',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(
                  height: 15,
                ),
                Text(
                    'We’re required by law to verify your identity before you can spend with your card or send money. Your information will be encrypted and stored securely.',
                    textAlign: TextAlign.center,
                    style: TextStyles().greyTextStyle().copyWith(fontSize: 13)),
              ],
            )),
            MyButton(
              text: 'Verify Identity',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProofOfResidencyWidget()));
              },
            )
          ],
        ),
      ),
    );
  }
}
