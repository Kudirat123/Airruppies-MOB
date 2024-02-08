import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessAirFixedWidget extends StatefulWidget {
  const SuccessAirFixedWidget({super.key});

  @override
  State<SuccessAirFixedWidget> createState() => _SuccessAirFixedWidgetState();
}

class _SuccessAirFixedWidgetState extends State<SuccessAirFixedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 550,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Color(0xffF5F7FE),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      'Well Dome',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16),
                                    ),
                                    Text(
                                      'Great job on setting up your savings plan! In order to begin earning interest, kindly transfer ₦ 50,000 to the account provided below within the next 24 hours.',
                                      textAlign: TextAlign.center,
                                      style: TextStyles()
                                          .greyTextStyle()
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12),
                                    ),
                                    Text(
                                      '₦50,000',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 22),
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    const SummaeyCard(
                                      firstText: 'Bank name',
                                      secondText: 'AirRupple',
                                    ),
                                    const SummaeyCard(
                                      firstText: 'Account name',
                                      secondText: 'AirRupple',
                                    ),
                                    const SummaeyCard(
                                      firstText: 'Account Number',
                                      secondText: '3445677888',
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const TransactionHistoryDetails()));
                                      },
                                      child: Text(
                                        'History Transaction',
                                        style: TextStyles()
                                            .blackTextStyle()
                                            .copyWith(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/savings/savingsPlan/✔️.svg',
                        width: 150,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const SecondaryButton(text: 'View Saving Plan'),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
