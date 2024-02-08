import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/model/user_savings_model.dart';
import 'package:airruppies/ui/savings/savings_withdraw_summary.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class AirBoxDetailsWidget extends StatefulWidget {
  const AirBoxDetailsWidget({super.key, this.data});
  final UserSavingsModel? data;

  @override
  State<AirBoxDetailsWidget> createState() => _AirBoxDetailsWidgetState();
}

class _AirBoxDetailsWidgetState extends State<AirBoxDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        appBar: AppBars().myPurpleAppBar(widget.data!.title, context),
        backgroundColor:
            !state.isDarkMode ? Colors.black : themes().primaryColor,
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 6,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(75, 255, 255, 255)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: !state.isDarkMode
                        ? const Color(0xff3c3547)
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/savings/savingsPlan/Component 1 (1).svg',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.data!.type.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: themes().primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.data!.status.toString(),
                                  style: TextStyles()
                                      .whiteTextStyle(context)
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 8),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: !state.isDarkMode
                                  ? const Color(0xff323045)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const ModeSelectionNairaWidget(),
                                    Text(
                                      '${widget.data!.amount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: LinearProgressIndicator(
                                    value: double.parse(widget.data!.completion
                                            .toString()) /
                                        100,
                                    minHeight: 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            backgroundColor: !state.isDarkMode
                                ? const Color(0xff323045)
                                : const Color(0xffF7EDFC),
                            collapsedBackgroundColor: !state.isDarkMode
                                ? const Color(0xff323045)
                                : const Color(0xffF7EDFC),
                            title: Text(
                              'Saving Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                            ),

                            // Contents
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const Divider(),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    Text(
                                      'This is a Summary of your current active Saving Plan',
                                      style: TextStyles()
                                          .greyTextStyle()
                                          .copyWith(fontSize: 11),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Debit Amount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Row(
                                          children: [
                                            const ModeSelectionNairaWidget(),
                                            Text(
                                              '${widget.data!.amount}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Start Date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                          widget.data!.type.minMaturityDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Duration',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                          'Total Saving',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Interest',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                          widget.data!.interestRate.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Withdrawal Date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                          tools.parseDate(DateTime.parse(widget
                                              .data!.maturityDate
                                              .toString())),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                            ),
                            Text('See All',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue))
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // ListView.separated(
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, int) {
                        //       return Row(
                        //         children: [
                        //           Container(
                        //             decoration: const BoxDecoration(
                        //                 shape: BoxShape.circle,
                        //                 color: Color(0xffF8F2FB)),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(15.0),
                        //               child: SvgPicture.asset(
                        //                 'assets/svgs/home_card_svgs/Group.svg',
                        //                 height: 15,
                        //                 width: 15,
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 20,
                        //           ),
                        //           Expanded(
                        //               child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text(
                        //                     'Transactions',
                        //                     style: TextStyles()
                        //                         .blackTextStyle()
                        //                         .copyWith(
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.w900),
                        //                   ),
                        //                   Text(
                        //                     'Transactions',
                        //                     style: TextStyles()
                        //                         .greyTextStyle()
                        //                         .copyWith(
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.w900),
                        //                   )
                        //                 ],
                        //               ),
                        //               const SizedBox(
                        //                 height: 10,
                        //               ),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Row(
                        //                     children: [
                        //                       const Icon(
                        //                         Icons.arrow_back,
                        //                         size: 11,
                        //                         color: Colors.green,
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 5,
                        //                       ),
                        //                       Text(
                        //                         'Transactions',
                        //                         style: TextStyles()
                        //                             .blackTextStyle()
                        //                             .copyWith(
                        //                                 fontSize: 14,
                        //                                 color: const Color(
                        //                                     0xffA2A0A8),
                        //                                 fontWeight:
                        //                                     FontWeight.w500),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Text(
                        //                     'Transactions',
                        //                     style: TextStyles()
                        //                         .greyTextStyle()
                        //                         .copyWith(
                        //                             fontSize: 14,
                        //                             color:
                        //                                 const Color(0xffA2A0A8),
                        //                             fontWeight: FontWeight.w500),
                        //                   )
                        //                 ],
                        //               )
                        //             ],
                        //           ))
                        //         ],
                        //       );
                        //     },
                        //     separatorBuilder: (context, int) {
                        //       return Container(
                        //         height: 28,
                        //       );
                        //     },
                        //     itemCount: 3),
                        const SizedBox(
                          height: 20,
                        ),
                        SecondaryButton(
                          text: 'Withdraw',
                          onPressed: () {
                            BottomPopUpModal().bottomPopup(
                                context,
                                SizedBox(
                                    height: 260,
                                    child: WithdrawWidget(data: widget.data)));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WithdrawWidget extends StatefulWidget {
  const WithdrawWidget({super.key, this.data});
  final UserSavingsModel? data;

  @override
  State<WithdrawWidget> createState() => _WithdrawWidgetState();
}

class _WithdrawWidgetState extends State<WithdrawWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Are you sure you want to end this ${widget.data!.type.title}?',
            textAlign: TextAlign.center,
            style: TextStyles()
                .blackTextStyle()
                .copyWith(fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'You will be charged 100%  penalty for ending the Airbox Saving before the scheduled date. ',
            textAlign: TextAlign.center,
            style: TextStyles().greyTextStyle().copyWith(
                fontSize: 14,
                color: const Color(0xffA2A0A8),
                fontWeight: FontWeight.w500),
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
              text: 'Yes, Continue',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SavingsWithdrawSummary(data: widget.data)));
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
