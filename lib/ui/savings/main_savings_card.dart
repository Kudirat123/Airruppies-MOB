import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/dashboard_service/dashboard_service.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class MainSavingsCard extends StatefulWidget {
  const MainSavingsCard({super.key});

  @override
  State<MainSavingsCard> createState() => _MainSavingsCardState();
}

class _MainSavingsCardState extends State<MainSavingsCard> {
  bool? isLoading = true;

  var savingData;

  Future<void> getSavingData() async {
    isLoading = true;
    savingData = await DashBoardService().getMainSaving(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSavingData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
       builder: (_, state, __) =>  

       Scaffold(
      //  backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
        body: isLoading!
            ? Center(
                child: CircularProgressIndicator(
                  color: themes().primaryColor,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    // Layer 1: Bottom-most layer
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                          color: !state.isDarkMode ? const Color(0xff323045) :const Color(0xffFCF6FF),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    // Layer 2
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset('assets/svgs/savings/Vector 43.svg')
                        ],
                      ),
                    ),
                    // Layer 3
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset('assets/svgs/savings/shapes.svg')
                        ],
                      ),
                    ),
                    // Layer 4: Top-most layer
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text('Current Balance',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [

                                RichText(
  textAlign: TextAlign.center,
  text: TextSpan(

    children: [
      TextSpan(
        text: '₦',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500 , color: !state.isDarkMode? Colors.white : Colors.black  )
      ),
      
      TextSpan(
        text: '${savingData['amount']}',
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        fontSize: 24, fontWeight: FontWeight.w700)
      ),
    ],
  ),
)
                              
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${savingData['count']} Active plan as at ${tools.parseDate(DateTime.now())}',
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
