import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/air_box/air_box_details.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_details.dart';
import 'package:airruppies/ui/savings/model/user_savings_model.dart';
import 'package:airruppies/ui/savings/savings_service/savings_service.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class CompletedSaving extends StatefulWidget {
  const CompletedSaving({super.key});

  @override
  State<CompletedSaving> createState() => _CompletedSavingState();
}

class _CompletedSavingState extends State<CompletedSaving> {
  List<UserSavingsModel>? userSavingsList;

  bool? loading = true;

  @override
  void initState() {
    super.initState();
    getUserSavingsList();
  }

  Future<void> getUserSavingsList() async {
    loading = true;
    userSavingsList = await SavingsService().getUserCompletedSavingsList(context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) =>  

      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
        body: loading == true
            ? Center(child:  CircularProgressIndicator(color:themes().primaryColor))
            : SingleChildScrollView(
                child: ListView.separated(
                    itemCount: userSavingsList!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => next(
                                      userSavingsList![index].type.id,
                                      userSavingsList![index])));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: !state.isDarkMode ? const Color(0xff323045): const Color(0xffF5F7FE),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userSavingsList![index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      'Interest Rate',
                                      style: TextStyles()
                                          .greyTextStyle()
                                          .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xffA2A0A8)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userSavingsList![index].type.title,
                                      style: TextStyles()
                                          .greyTextStyle()
                                          .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${userSavingsList![index].interestRate}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const ModeSelectionNairaWidget(),
                                        Text(
                                          '${userSavingsList![index].amount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Maturity Date',
                                          style: TextStyles()
                                              .greyTextStyle()
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xffA2A0A8)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          tools.parseDate(DateTime.parse(
                                              userSavingsList![index]
                                                  .maturityDate)),
                                          // userSavingsList![index].maturityDate,
                                          style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: const LinearProgressIndicator(
                                    color: Color(0xffF6A609),
                                    value: 1,
                                    // double.parse(userSavingsList![index]
                                    //     .completion
                                    //     .toString())/100,
                                    minHeight: 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }

  Widget next(int value, UserSavingsModel data) {
    Widget nextPage = Container();

    switch (value) {
      case 1:
        nextPage = AirFixedDetailsWidget(data: data);
        break;
      case 2:
        nextPage = AirBoxDetailsWidget(data: data);
        break;
      case 3:
        nextPage = AirBoxDetailsWidget(data: data);
        break;
    }
    return nextPage;
  }
}
