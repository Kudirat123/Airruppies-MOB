import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FingerPrintWidget extends StatefulWidget {
  const FingerPrintWidget({super.key});

  @override
  State<FingerPrintWidget> createState() => _FingerPrintWidgetState();
}

class _FingerPrintWidgetState extends State<FingerPrintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().whiteColor,
      appBar: AppBars().backButton(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Text('Fingerprint',
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontSize: 24, fontWeight: FontWeight.w900)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      'Please lift and rest your finger for login authentication',
                      textAlign: TextAlign.center,
                      style:
                          TextStyles().greyTextStyle().copyWith(fontSize: 15)),
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/onboarding_svgs/Fingerprint Scan.svg',
                    height: 110,
                    width: 110,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'By set fingerprint, you agree to our Terms and Conditions',
                              style: TextStyles().greyTextStyle().copyWith( fontSize: 14)),
                          TextSpan(
                              text: ' Terms ',
                              style: TextStyles().blackTextStyle().copyWith( fontSize: 14)),
                          TextSpan(
                              text: ' And ',
                              style: TextStyles().purpleTextStyle().copyWith( fontSize: 14)),
                          TextSpan(
                              text: ' Conditions ',
                              style: TextStyles().blackTextStyle().copyWith( fontSize: 14)),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
