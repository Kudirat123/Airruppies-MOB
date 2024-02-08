import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AirtimeSuccessWidget extends StatefulWidget {
  const AirtimeSuccessWidget({super.key, this.data});
 final dynamic data;

  @override
  State<AirtimeSuccessWidget> createState() => _AirtimeSuccessWidgetState();
}

class _AirtimeSuccessWidgetState extends State<AirtimeSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        body: SizedBox(
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
                          decoration: BoxDecoration(
                              color: !state.isDarkMode
                                  ? Colors.black
                                  : const Color(0xffF5F7FE),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: !state.isDarkMode
                                      ? const Color(0xff323045)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
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
                                      'Successful',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16),
                                    ),
                                    Text(
                                      'Your transaction has been successfully completed.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                      
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: '₦',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,
                                                    color: !state.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black)),
                                            TextSpan(
                                              text: '${widget.data['amount']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 22,
                                                  ),
                                            )
                                          ]),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    SummaeyCard(
                                      firstText: 'Service Provider',
                                      secondText:
                                          '${widget.data['serviceProvider']}',
                                    ),
                                    SummaeyCard(
                                      firstText: 'Phone Number',
                                      secondText:
                                          '${widget.data!['phoneNumber']}',
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: themes().primaryColor,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Expanded(child: SecondaryButton(text: 'Share')),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: MyButton(
                            text: 'Done',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                            pageNumber: 0,
                                          )));
                            }))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
