import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/airtime/airtime/buy_airtime.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_coming_soon.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_dropdown.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_state/bill_payment_state.dart';
import 'package:airruppies/ui/bill_payment/cable/cable.dart';
import 'package:airruppies/ui/bill_payment/model/bill_payment_model.dart';
import 'package:airruppies/ui/bill_payment/sport_bet/sport_bet.dart';
import 'package:airruppies/ui/bill_payment/utility/utility.dart';
import 'package:airruppies/ui/data/buy_data.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class BillPaymentWidget extends StatefulWidget {
  const BillPaymentWidget({super.key});

  @override
  State<BillPaymentWidget> createState() => _BillPaymentWidgetState();
}

class _BillPaymentWidgetState extends State<BillPaymentWidget> {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Cable Tv',
      'text2': 'GoTV, DSTV, etc.',
    },
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Airtime',
      'text2': 'MTN, GLO, Airtel',
    },
    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Internet/Data',
      'text2': 'Swift, Spectranet, etc.',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Utilities',
      'text2': 'BEDC, EKEDC,',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Electricity',
      'text2': 'IBEDC, Ikeja  electric, ',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Cable/TV',
      'text2': 'GoTV, DSTV, etc.',
    },

    {
      'image': 'assets/images/Rectangle 827.png',
      'text1': 'Utilities',
      'text2': 'BEDC, EKEDC,',
    },
    // Add more items here...

    //Widget List
  ];

  List<Widget> widgetList = [
    const CableWidget(),
    const SportBetWidget(),
    const SportBetWidget(),
    const CableWidget(),
    const CableWidget()
  ];

  List<PaybillModel>? billPaymentList;

  bool? loading;

  @override
  void initState() {
    super.initState();
    getBillPaymentList();
  }

  Future<void> getBillPaymentList() async {
    loading = true;
    billPaymentList =
        Provider.of<BillPaymentState>(context, listen: false).billList;
    setState(() {
      loading = false;
    });
  }

  Widget nextPage(String pageTitle) {
    Widget? nextPage;

    switch (pageTitle) {
      case 'Airtime TopUp':
        nextPage = const BuyAirtimeWidget();
        break;
      case 'Betting and Lottery':
        nextPage = const SportBetWidget();
        break;
      case 'Data Subscription':
        nextPage = const Data2Widget();

        break;
      case 'Cable TV':
        nextPage = const CableWidget();
        break;
      case 'Electricity - Prepaid':
        nextPage = const UtilityPage();
        break;

      default:
        nextPage = const BillPaymentComingPage();
    }
    // ignore: avoid_print
    print(nextPage);

    return nextPage;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBars().whiteAppBarWithBackButton('Bill Payments', context),
        body: loading!
            ? Center(
                child: CircularProgressIndicator(
                color: themes().primaryColor,
              ))
            : Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlineInput(
                        labelText: 'Search',
                        preffixWidget: Icon(MdiIcons.magnify),
                        onTap: () {
                          BottomPopUpModal().bottomPopup(
                              context,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: const BillPaymentDropDownWidget()));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Bill Category',
                          style: TextStyles().blackTextStyle().copyWith(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GridView.builder(
                        itemCount: billPaymentList!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.0,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // ignore: avoid_print
                              print(billPaymentList![index].name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => nextPage(
                                          billPaymentList![index]
                                              .name
                                              .toString())));
                            },
                            child: GridTile(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: !state.isDarkMode
                                      ? const Color(0xff1F1723)
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0,
                                          2), // horizontal and vertical offset
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      items[1]['image'].toString(),
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                        billPaymentList![index].name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700)),
                                    // Text(items[index]['text2'].toString(),
                                    //     style: TextStyles()
                                    //         .greyTextStyle()
                                    //         .copyWith(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
