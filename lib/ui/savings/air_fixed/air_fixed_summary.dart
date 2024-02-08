import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/dashboard_service/dashboard_service.dart';
import 'package:airruppies/ui/savings/savings_service/savings_service.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:flutter_svg/flutter_svg.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AirFixedSummary extends StatefulWidget {
  const AirFixedSummary({super.key, this.data});
  final Map<String, dynamic>? data;

  @override
  State<AirFixedSummary> createState() => _AirFixedSummaryState();
}

class _AirFixedSummaryState extends State<AirFixedSummary> {
  bool isLoading = true;

  var mainSavingData;
  Future<void> getMainSavingData() async {
    isLoading = true;
    mainSavingData = await DashBoardService().getMainAccount(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMainSavingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton(
          '${widget.data!['type']} Summary', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: themes().primaryColor,
              ))
            : Column(
                children: [
                  SummaeyCard(
                    firstText: 'Type',
                    secondText: widget.data!['type'],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SummaeyCard(
                    firstText: 'Name',
                    secondText: widget.data!['title'],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SummaeyCard(
                    firstText: 'Saving Amount',
                    secondText: '₦ ${widget.data!['amount']}',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SummaeyCard(
                      firstText: 'Start Date',
                      secondText: tools.parseDate(DateTime.now())),
                  const SizedBox(
                    height: 15,
                  ),
                  SummaeyCard(
                      firstText: 'Withgraw Date',
                      secondText: tools.parseDate(
                          DateTime.parse('${widget.data!['time']}'))),
                  const SizedBox(
                    height: 15,
                  ),
                  SummaeyCard(
                    firstText: 'interest rate',
                    secondText: '${widget.data!['intrest']}',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // SummaeyCard(
                  //   firstText: 'Saving Amount',
                  //   secondText: 'N50,000',
                  // ),
                  const SizedBox(
                    height: 44,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment with ',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                      Row(
                        children: [
                          Text('Change this ',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  sendMoney(MdiIcons.bank, 'Airruppies',
                      'Balance  NGN  ${mainSavingData['data']['account_balance']} '),
                  const SizedBox(
                    height: 45,
                  ),
                  MyButton(
                    text: 'Create Savings Plan',
                    onPressed: () {
                      SavingsService().createSavings(
                          context, widget.data, widget.data!['int']);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SuccessAirFixedWidget()));
                    },
                  )
                ],
              ),
      ),
    );
  }

  Widget sendMoney(IconData icon, String firstText, String secondText) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: !state.isDarkMode
              ? const Color(0xff1F1723)
              : const Color(0xffF7EDFC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themes().primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/svgs/Union.svg'),
                  )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstText,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      secondText,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              //const Icon(Icons.arrow_forward_ios, size: 13)
            ],
          ),
        ),
      ),
    );
  }
}

class SummaeyCard extends StatelessWidget {
  const SummaeyCard({super.key, this.firstText, this.secondText});

  final String? firstText;
  final String? secondText;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Column(
        children: [
          const Divider(
            color: Color(0xffD7DEE7),
            thickness: 0.4,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                firstText.toString(),
                style: TextStyles().greyTextStyle().copyWith(fontSize: 12),
              ),
              Text(secondText.toString(),
                  style: TextStyle(
                      color: state.isDarkMode
                          ? const Color(0xff323045)
                          : Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
