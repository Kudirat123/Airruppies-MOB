import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/dashboard_service/dashboard_service.dart';
import 'package:airruppies/ui/savings/active_savings.dart';
import 'package:airruppies/ui/savings/completed_savings.dart';
import 'package:airruppies/ui/savings/main_savings_card.dart';
import 'package:airruppies/ui/savings/savings_plan/select_plan.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var savingData;
  bool isLoading = true;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getSavingData();
  }

  Future<void> getSavingData() async {
    isLoading = true;
    savingData = await DashBoardService().getMainSaving(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
       builder: (_, state, __) =>  
       Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
        appBar: AppBars().myWhiteAppBar('Your Savings', context),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            backgroundColor: themes().primaryColor,
            onPressed: () {
              // Add your onPressed logic here
    
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectSavingsPlanWidget()));
            },
            child:  Icon(Icons.add ,color: themes().whiteColor,),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: isLoading ? Center(child: CircularProgressIndicator(color: themes().primaryColor,)):
        
         SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: const MainSavingsCard()),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      backgroundColor: !state.isDarkMode ? const Color(0xff323045) :const Color(0xffF7EDFC),
                      collapsedBackgroundColor: !state.isDarkMode ? const Color(0xff323045) : const Color(0xffF7EDFC),
                      title: Text(
                        'Saving Details',
                        style:  Theme.of(context).textTheme.displaySmall!
                            .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Saving',
                                      style:  Theme.of(context).textTheme.displaySmall!
                                          .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                  Row(
                                    children: [
                                      const ModeSelectionNairaWidget(),
                                      Text(
                                        '${savingData['amount']}',
                                        style:  Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Interest',
                                      style:  Theme.of(context).textTheme.displaySmall!
                                          .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                  Text(
                                    ' ${savingData['interest']}',
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Balance',
                                      style:  Theme.of(context).textTheme.displaySmall!
                                          .copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                  Row(
                                    children: [
                                       const ModeSelectionNairaWidget(),
                                      Text(
                                        '${savingData['balance']}',
                                        style:  Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
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
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                    
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TabBar(
                      // isScrollable: true,
                      controller: _tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: themes().primaryColor),
                      labelColor: Colors.white,
                      padding: const EdgeInsets.all(3),
                      labelStyle: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      unselectedLabelColor: themes().greyText,
    
                      tabs: const [
                        Tab(text: 'Active'),
                        Tab(text: 'Complete'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child:
                        TabBarView(controller: _tabController, children: const [
                      ActiveSaving(),
                      CompletedSaving(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
