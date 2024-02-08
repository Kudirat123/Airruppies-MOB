import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/dashboard_service/dashboard_service.dart';
import 'package:airruppies/ui/savings/savings.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dot_indicator.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isVisible = true;

  int _currentIndex = 0;
  List<Widget> widgetList = [
    const MainAccountCard(),
    const MainSavingsCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              padEnds: false,
              viewportFraction: 0.92,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widgetList.map((currentCard) {
              return Builder(
                builder: (BuildContext context) {
                  return currentCard;
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 5,
          ),
          CircularDotIndicator(
            currentIndex: _currentIndex,
            dotCount: widgetList.length,
            dotSize: 8.0,
            dotColor: const Color(0xffDAE1FB),
            activeDotColor: themes().primaryColor,
          ),
        ],
      ),
    );
  }
}

class MainAccountCard extends StatefulWidget {
  const MainAccountCard({super.key});

  @override
  State<MainAccountCard> createState() => _MainAccountCardState();
}

class _MainAccountCardState extends State<MainAccountCard> {
  bool isVisible = false;
  bool isLoading = true;
  var mainSavingData;

  @override
  void initState() {
    super.initState();
    getMainSavingData();
  }

  Future<void> getMainSavingData() async {
    isLoading = true;
    mainSavingData = await DashBoardService().getMainAccount(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: themes().primaryColor,
              ))
            : Stack(
              children: [
                Container(
                  height: 190.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: 190,
                  child: Image.asset(
                    'assets/svgs/home_svg/Base (2).png',
                    height: 190.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Main account balance',
                            style: TextStyles()
                                .whiteTextStyle(context)
                                .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const NairaWidget(),
                                  Text(
                                    isVisible
                                        ? '*******'
                                        : '${mainSavingData['data']['account_balance']}',
                                    style: TextStyles()
                                        .whiteTextStyle(context)
                                        .copyWith(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(
                                    !isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: themes().whiteColor,
                                    size: 16),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Account Number',
                                style: TextStyles()
                                    .whiteTextStyle(context)
                                    .copyWith(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${mainSavingData['data']['account_number']}',
                                style: TextStyles()
                                    .whiteTextStyle(context)
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
      ),
    );
  }
}

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
    return Scaffold(
    
      body: isLoading!
          ? Center(
              child: CircularProgressIndicator(
                color: themes().primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Savings()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      // Layer 1: Bottom-most layer
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        decoration: BoxDecoration(
                            color: const Color(0xffFCF6FF),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      // Layer 2
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                                'assets/svgs/savings/Vector 43.svg')
                          ],
                        ),
                      ),
                      // Layer 3
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
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
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text('Savings',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 18,
                              ),
                              Text('Earn up to 15.5% per annum',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                  'Invest where your money works as hard as you do ',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// class SavingCardWidget extends StatefulWidget {
//   const SavingCardWidget({super.key});

//   @override
//   State<SavingCardWidget> createState() => _SavingCardWidgetState();
// }

// class _SavingCardWidgetState extends State<SavingCardWidget> {
//   bool isVisible = false;
//   bool isLoading = true;
//   var savingData;

//   @override
//   void initState() {
//     super.initState();
//     getSavingData();
//   }

//   Future<void> getSavingData() async {
//     isLoading = true;
//     savingData = await DashBoardService().getMainSaving(context);
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: SizedBox(
//         height: 2,
//         child: isLoading
//             ? const CircularProgressIndicator()
//             : Stack(
//                 children: [
//                  Container(
//                       height: 224.0,
                     
//                       decoration: BoxDecoration(
//                          color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color.fromARGB(255, 162, 162, 162)
//                                 .withOpacity(0.22),
//                             spreadRadius: 5,
//                             blurRadius: 5,
//                             offset: const Offset(
//                                 0, 2), // horizontal and vertical offset
//                           ),
//                         ],
//                       ),
//                     ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     // height: 190,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Image.asset(
//                           height: 224,
//                           'assets/svgs/home_card_svgs/Vector 44.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     // height: 190,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Image.asset(
//                           height: 224,
//                           'assets/svgs/home_card_svgs/Vector 43.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ],
//                     ),
//                   ),

//                   //   Container(color: Colors.white,),

//                   SizedBox(
//                       // height: 220,
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.all(30.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Saving balance',
//                               style: TextStyles().blackTextStyle().copyWith(
//                                   fontSize: 14, fontWeight: FontWeight.w800),
//                             ),
//                             const SizedBox(
//                               height: 42,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   savingData.toString().toLowerCase() == 'null'
//                                       ? '0'
//                                       : isVisible
//                                           ? '₦ *******'
//                                           : '₦ ${savingData['amount']} ',
//                                   style: TextStyles().blackTextStyle().copyWith(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w800),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       isVisible = !isVisible;
//                                     });
//                                   },
//                                   child: Icon(
//                                       !isVisible
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                       color: themes().whiteColor,
//                                       size: 16),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//       ),
//     );
//   }
// }
