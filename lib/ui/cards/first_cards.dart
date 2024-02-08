import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/cards/upgarde_verify.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstCardWidget extends StatefulWidget {
  const FirstCardWidget({super.key});

  @override
  State<FirstCardWidget> createState() => _FirstCardWidgetState();
}

class _FirstCardWidgetState extends State<FirstCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().myWhiteAppBar('Card', context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .70,
                child: Stack(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            child: SvgPicture.asset(
                              'assets/svgs/card_svgs/App Logo.svg',
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.34,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: SvgPicture.asset(
                                    'assets/svgs/card_svgs/Base (2).svg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'DSTV Service',
                                              style: TextStyles()
                                                  .whiteTextStyle(context)
                                                  .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            SvgPicture.asset(
                                              'assets/svgs/card_svgs/Mastercard.svg',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svgs/Union.svg',
                                          height: 40,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Text(
                                'The Air Ruppies Card',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 37,
                                        fontWeight: FontWeight.w900),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Text(
                                'Have a better Digital experience with Air Ruppies',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: MyButton(
                text: 'Coming Soon',
                onPressed: () {
                  // BottomPopUpModal().bottomPopup(context,
                  //     const SizedBox(height: 230, child: WithdrawWidget()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawWidget extends StatelessWidget {
  const WithdrawWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Before submitting an application for a card, it is necessary to fully upgrade to tier 2 and tier 3 in accordance with regulatory requirements.',
            textAlign: TextAlign.center,
            style: TextStyles()
                .blackTextStyle()
                .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 23,
        ),
        Row(
          children: [
            Expanded(
                child: SecondaryButton(
              text: 'No, i don\'t',
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: MyButton(
              text: 'Upgrade Now',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UPgradeVerifyWidget()));
              },
            ))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
