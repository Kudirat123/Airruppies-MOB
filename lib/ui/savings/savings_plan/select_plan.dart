import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/air_box/create_air_box.dart';
import 'package:airruppies/ui/savings/air_fixed/create_air_fixed_plan.dart';
import 'package:airruppies/ui/savings/model/savings_plan_model.dart';
import 'package:airruppies/ui/savings/savings_plan/savings_plan_widget.dart';
import 'package:airruppies/ui/savings/savings_state/savings_state.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectSavingsPlanWidget extends StatefulWidget {
  const SelectSavingsPlanWidget({super.key});

  @override
  State<SelectSavingsPlanWidget> createState() =>
      _SelectSavingsPlanWidgetState();
}

class _SelectSavingsPlanWidgetState extends State<SelectSavingsPlanWidget> {
  List<SavingsPlanModel>? savingPlan;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    getSavingsPlan();
  }

  Future<void> getSavingsPlan() async {
    loading = true;
    savingPlan = Provider.of<SavingsState>(context, listen: false).savingPlan;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        appBar: AppBars().whiteAppBarWithBackButton('Select Plan', context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //green box
              Container(
                decoration: BoxDecoration(
                  color: !state.isDarkMode
                      ? const Color(0xff323045)
                      : const Color(0xffE8FFF1),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset:
                          const Offset(0, 2), // horizontal and vertical offset
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/savings/savingsPlan/Component 1.svg',
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            savingPlan![0].title,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        savingPlan![0].description,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: NoColorButton(
                                text: 'View Details',
                                color: !state.isDarkMode
                                    ? const Color(0xff1F1723)
                                    : Colors.white,
                                textColor: !state.isDarkMode
                                    ? themes().greyText
                                    : Colors.black,
                                onPressed: () {
                                  BottomPopUpModal().bottomPopup(
                                      context,
                                      SizedBox(
                                          height: 200,
                                          child: AirFixedFeatureWidget(
                                              data: savingPlan![0])));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: NoColorButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAirFixedWidget(
                                                  data: savingPlan![0])));
                                },
                                text: 'Create plan',
                                color: const Color(0xff1AB759),
                                textColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // purple box

              Container(
                decoration: BoxDecoration(
                  color: !state.isDarkMode
                      ? const Color(0xff323045)
                      : const Color(0xffFCF6FF),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset:
                          const Offset(0, 2), // horizontal and vertical offset
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
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
                            savingPlan![1].title,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        savingPlan![1].description,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: NoColorButton(
                                  text: 'View Details',
                                  color: !state.isDarkMode
                                      ? const Color(0xff1F1723)
                                      : Colors.white,
                                  textColor: !state.isDarkMode
                                      ? themes().greyText
                                      : Colors.black,
                                  onPressed: () {
                                    BottomPopUpModal().bottomPopup(
                                        context,
                                        SizedBox(
                                            height: 200,
                                            child: AirFixedFeatureWidget(
                                                data: savingPlan![1])));
                                  }),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: NoColorButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAirBoxWidget(
                                                  data: savingPlan![1])));
                                },
                                text: 'Create plan',
                                color: themes().primaryColor,
                                textColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //yellow box

              Container(
                decoration: BoxDecoration(
                  color: !state.isDarkMode
                      ? const Color(0xff323045)
                      : const Color(0xffFFFBF4),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset:
                          const Offset(0, 2), // horizontal and vertical offset
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/savings/savingsPlan/Component 1 (2).svg',
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            savingPlan![2].title,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        savingPlan![2].description,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: NoColorButton(
                                  text: 'View Details',
                                  color: !state.isDarkMode
                                      ? const Color(0xff1F1723)
                                      : Colors.white,
                                  textColor: !state.isDarkMode
                                      ? themes().greyText
                                      : Colors.black,
                                  onPressed: () {
                                    BottomPopUpModal().bottomPopup(
                                        context,
                                        SizedBox(
                                            height: 200,
                                            child: AirFixedFeatureWidget(
                                                data: savingPlan![2])));
                                  }),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: NoColorButton(
                                text: 'Create plan',
                                color: themes().yellowColor,
                                textColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
