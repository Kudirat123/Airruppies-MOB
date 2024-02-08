import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/airtime/airtime_pin.dart';
import 'package:airruppies/ui/bill_payment/other/other_widget.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class Airtime2Widget extends StatefulWidget {
  const Airtime2Widget({super.key, this.amount});
  final String? amount;

  @override
  State<Airtime2Widget> createState() => _Airtime2WidgetState();
}

class _Airtime2WidgetState extends State<Airtime2Widget> {
  bool _switchValue = false;
  TextEditingController? numberController;
  TextEditingController? amountController;

  var networkProvider;

  @override
  void initState() {
    super.initState();
    networkProvider = tools.checkNetworkProvider(widget.amount!);
    numberController = TextEditingController(text: widget.amount);
    amountController = TextEditingController(text: '0');
    // ignore: avoid_print
    print(widget.amount);
  }

  List<String> amountList = [
    '50',
    '100',
    '200',
    '500',
    '1000',
    '2000',
    '5000',
  ];

  List<String> serviceProviderList = [
    'mtn',
    'Airtel',
    'Glo',
    'Etisalat',
  ];

  addTenToNumber() {
    setState(() {
      double newValue = double.parse(amountController!.text) + 10;
      amountController!.text = newValue.toString();
      // ignore: avoid_print
      print(amountController!.text);
    });
  }

  subtractTenToNumber() {
    if (double.parse(amountController!.text) < 1) {
    } else {
      setState(() {
        double newValue = double.parse(amountController!.text) - 10;
        amountController!.text = newValue.toString();
        // ignore: avoid_print
        print(amountController!.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBars().whiteAppBarWithBackButton('Airtime', context),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Container(
                        child: Image.asset(
                      BillPaymentOtherWidget().airtelImageUrl(
                          networkProvider.toString().toLowerCase()),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ))),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  networkProvider,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    BottomPopUpModal().bottomPopup(
                        context,
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                            child: dropdown()));
                  },
                  child: Text(
                    'Click here to Change network',
                    style: TextStyles()
                        .purpleTextStyle()
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                OutlineInput(
                  labelText: 'Enter Number',
                  suffixWidget: const Icon(Icons.person_outlined),
                  controller: numberController,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: !state.isDarkMode
                        ? const Color(0xff1F1723)
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 200, 199, 199)
                            .withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(
                            0, 2), // horizontal and vertical offset
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1.6,
                      //  crossAxisSpacing: 3.0,
                      //  mainAxisSpacing: 10,
                      crossAxisCount: 3, // Number of items in each row
                      children: List.generate(amountList.length, (index) {
                        return InkWell(
                          onTap: () {
                            amountController!.text = amountList[index];
                          },
                          child: GridItem(
                            image: Container(
                              height: 52,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: !state.isDarkMode
                                      ? const Color(0xff323045)
                                      : const Color(0xffF7EDFC),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const ModeSelectionNairaWidget(),
                                    Text(
                                      ' ${amountList[index]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: !state.isDarkMode
                          ? const Color(0xff1F1723)
                          : const Color(0xffF9F9FA),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Click or Enter  amount ',
                            style: TextStyles()
                                .greyTextStyle()
                                .copyWith(fontSize: 13)),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     addTenToNumber();
                            //   },
                            //   child: Container(
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.white,
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(7.0),
                            //       child: Icon(MdiIcons.plus),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: OutlineInput(
                                  labelText: 'Amount',
                                  textCenter: true,
                                  controller: amountController,
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     subtractTenToNumber();
                            //   },
                            //   child: Container(
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.white,
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(7.0),
                            //       child: Icon(MdiIcons.minus),
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Save as Contact',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 13),
                    ),
                    CupertinoSwitch(
                      activeColor: themes().primaryColor,
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                  text: 'Proceed',
                  onPressed: () {
                    var body = {
                      'amount': amountController!.text,
                      'beneficiary': numberController!.text,
                      'network': networkProvider
                    };
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AirtimePinWidget(data: body)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //change network

  Widget dropdown() {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        networkProvider = serviceProviderList[int];
                      });

                      //  selectedItem = getUtilityServiceList![int];

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              serviceProviderList[int],
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: serviceProviderList.length)
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.image,
  });
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        image,
        const SizedBox(height: 8.0),
      ],
    );
  }
}
