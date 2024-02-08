import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/ui/savings/model/savings_plan_model.dart';
import 'package:airruppies/ui/savings/savings_state/savings_state.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class CreateAirBoxWidget extends StatefulWidget {
  const CreateAirBoxWidget({super.key, this.data});
  final SavingsPlanModel? data;

  @override
  State<CreateAirBoxWidget> createState() => _CreateAirBoxWidgetState();
}

class _CreateAirBoxWidgetState extends State<CreateAirBoxWidget> {
  TextEditingController? durationController;
  TextEditingController? titleController;
  TextEditingController? amountController;
  @override
  void initState() {
    durationController = TextEditingController();
    titleController = TextEditingController();
    amountController = TextEditingController();
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:
          AppBars().whiteAppBarWithBackButton('Setup your Air Box', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            OutlineInput(
              labelText: 'Give this saving plan a name',
              controller: titleController,
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // OutlineInput(
            //   labelText: 'Select saving Frequency',
            //   suffixWidget: const Padding(
            //       padding: EdgeInsets.all(20.0),
            //       child: Icon(
            //         Icons.arrow_drop_down_outlined,
            //         size: 17,
            //       )),
            // ),
            const SizedBox(
              height: 20,
            ),
            OutlineInput(
              labelText: 'Duration',
              controller: durationController,
              suffixWidget: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 17,
                  )),
              onTap: () {
                BottomPopUpModal().bottomPopup(context,
                    SizedBox(height: 250, child: interestRatesWidgets()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            OutlineInput(
              labelText: 'Amount you will like to save monthly',
              controller: amountController,
              preffixWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/svgs/savings/savingsPlan/Naira.svg',
                  height: 15,
                  width: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // OutlineInput(
            //   labelText: 'Start Date',
            //   controller: ,
            //   suffixWidget: const Padding(
            //       padding: EdgeInsets.all(20.0),
            //       child: Icon(
            //         Icons.calendar_month,
            //         size: 17,
            //       )),
            // ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                BottomPopUpModal().bottomPopup(context,
                    SizedBox(height: 250, child: interestRatesWidgets()));
              },
              child: Row(
                children: [
                  Text(
                    'View Interest rates',
                    style: TextStyles()
                        .purpleTextStyle()
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text: 'Proceed',
              onPressed: () {
                var reference = tools.generateRandomString(20);
                Map<String, dynamic>? body = {
                  'title': titleController!.text,
                  'amount': amountController!.text,
                  'duration': durationController!.text,
                  'session_id': reference,
                  'int': widget.data!.id,
                  'type': widget.data!.title
                };

                var intrestBody =
                    Provider.of<SavingsState>(context, listen: false)
                        .savingsIntrestData;

                body.addAll(intrestBody!);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AirFixedSummary(data: body)));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget interestRatesWidgets() {
    List<String> intrestList = [
      '3',
      '6',
      '9',
      '12',
    ];

    List<String> percentageList = [
      '4.25%',
      '5%',
      '7%',
      '10%',
    ];

    DateTime getUpdatedDateTime(
        DateTime currentDateTime, Duration durationToAdd) {
      DateTime newDateTime = currentDateTime.add(durationToAdd);
      return newDateTime;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Interest Rate',
              style: TextStyles()
                  .blackTextStyle()
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);

                  var time = getUpdatedDateTime(
                      DateTime.now(),
                      Duration(
                          days: double.parse(intrestList[index]).toInt() * 30));
                  Map<String, dynamic>? body = {
                    'frequency': index + 1,
                    'duration': intrestList[index],
                    'intrest': percentageList[index],
                    'time': time.toString(),
                    'location': Provider.of<AuthState>(context, listen: false)
                        .userLocation,
                  };
                  durationController!.text = '${intrestList[index]} months';

                  Provider.of<SavingsState>(context, listen: false)
                      .savingsIntrestData = body;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${intrestList[index]} months',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      percentageList[index],
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 28,
              );
            },
            itemCount: intrestList.length)
      ],
    );
  }
}
