import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model/cable_detail_model.dart';
import 'package:airruppies/ui/bill_payment/other/other_widget.dart';
import 'package:airruppies/ui/data/airtime_service/data_service.dart';
import 'package:airruppies/ui/data/data_pin.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class Data2Widget extends StatefulWidget {
  const Data2Widget({super.key});

  @override
  State<Data2Widget> createState() => _Data2WidgetState();
}

class _Data2WidgetState extends State<Data2Widget> {
  bool _switchValue = false;
  TextEditingController? phoneNumber;
  var serviceName = 'mtn';
  var count;
  List<CableDetailModel>? dataList;
  CableDetailModel? selectedItem;
  int? selectedIndex;
  List<String> serviceProviderList = [
    'mtn',
    'Airtel',
    'Glo',
    'Etisalat',
  ];

  bool? loading = true;

  @override
  void initState() {
    phoneNumber = TextEditingController();
    getDataList();

    // TODO: implement initState
    super.initState();
  }

  void myFunction(String input) {
    // Your implementation here
    if (phoneNumber!.text.length > 10) {
      setState(() {
        serviceName = tools.checkNetworkProvider(phoneNumber!.text);
        // ignore: avoid_print
        print(serviceName);
        getDataList();
      });
    } else {}
  }

  Future<void> getDataList() async {
    loading = true;
    dataList = await DataService()
        .getDataList(context, serviceName.toString().toLowerCase());

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('Data', context),
      body: Consumer<ThemeProvider>(
        builder: (_, state, __) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: loading!
                ? Center(
                    child: CircularProgressIndicator(
                    color: themes().primaryColor,
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            BillPaymentOtherWidget().airtelImageUrl(
                            serviceName.toString().toLowerCase()),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$serviceName Service',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          BottomPopUpModal().bottomPopup(
                              context,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  child: dropdown()));
                        },
                        child: Text(
                          'Click here to Change network',
                          style: TextStyles().purpleTextStyle().copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      OutlineInput(
                        labelText: 'Enter Number',
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        onChanged: myFunction,
                        suffixWidget: const Icon(Icons.person_outlined),
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
                            childAspectRatio: 1.0,
                            //  crossAxisSpacing: 3.0,
                            //  mainAxisSpacing: 10,
                            crossAxisCount: 3, // Number of items in each row
                            children: List.generate(dataList!.length, (index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedItem = dataList![index];
                                    selectedIndex = index;
                                  });
                                },
                                child: GridItem(
                                  image: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: !state.isDarkMode
                                                ? selectedIndex != index
                                                    ? const Color(0xff323045)
                                                    : Colors.white
                                                : selectedIndex != index
                                                    ? Colors.white
                                                    : themes().primaryColor),
                                        color: !state.isDarkMode
                                            ? const Color(0xff323045)
                                            : const Color(0xffF7EDFC),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: dataList![index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(fontSize: 11),
                                                ),
                                                const TextSpan(text: ', '),
                                                TextSpan(
                                                    text:
                                                        '₦ ${dataList![index].amount}',
                                                    style: TextStyle(
                                                        color: state.isDarkMode
                                                            ? const Color(
                                                                0xff323045)
                                                            : Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 11.5)),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                            'data': selectedItem,
                            'beneficiary': phoneNumber!.text,
                            'network': serviceName
                          };
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataPinWidget(
                                      body: body, dataItem: selectedItem)));
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
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      serviceName = serviceProviderList[index];
                    });

                    getDataList();

                    //  selectedItem = getUtilityServiceList![int];

                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            serviceProviderList[index],
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
