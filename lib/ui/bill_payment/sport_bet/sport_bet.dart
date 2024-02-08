import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_service/bill_payment_service.dart';
import 'package:airruppies/ui/bill_payment/bill_payment_state/bill_payment_state.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model/cable_detail_model.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SportBetWidget extends StatefulWidget {
  const SportBetWidget({super.key});

  @override
  State<SportBetWidget> createState() => _SportBetWidgetState();
}

class _SportBetWidgetState extends State<SportBetWidget> {
  bool _switchValue = false;

  bool? isLoading;

  List<CableModel>? getCableServiceList;
  TextEditingController? smartCardNumberController;
  TextEditingController? cableTypeController;
  TextEditingController? smartPlanController;

  List<CableDetailModel>? cableDetailsList;

  CableModel? selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCableService();

    smartCardNumberController = TextEditingController();
    cableTypeController = TextEditingController();
    smartPlanController = TextEditingController();
  }

  void getCableService() {
    isLoading = true;
    getCableServiceList =
        Provider.of<BillPaymentState>(context, listen: false).sportBetList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('Sport Bet', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      selectedItem.toString() == 'null'
                          ? ''
                          : '${selectedItem!.name} Service',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 4,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  OutlineInput(
                    labelText: 'Bet Id',
                    controller: smartCardNumberController,
                    onTap: () {},
                    suffixWidget: const Icon(Icons.document_scanner_outlined),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  OutlineInput(
                    onTap: () {
                      BottomPopUpModal().bottomPopup(
                          context,
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .7,
                              child: dropdown()));
                    },
                    labelText: 'Select Bet Platform ',
                    controller: cableTypeController,
                    suffixWidget: const Icon(Icons.arrow_drop_down_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  OutlineInput(
                    onTap: () {},
                    labelText: 'Amount',
                    controller: smartPlanController,
                    keyboardType: TextInputType.number,
                    // suffixWidget:  Icon(Icons.arrow_drop_down_rounded),
                  ),

                  //DropdownTextFormField(),

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save as beneficiary',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 14),
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
                ],
              ),
              const MyButton(text: 'Proceed')
            ],
          ),
        ),
      ),
    );
  }

  //dropdown widget

  Widget dropdown() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Sport Bet',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Icon(MdiIcons.close)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            OutlineInput(
              labelText: 'Search',
              preffixWidget: Icon(MdiIcons.magnify),
            ),
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
                        cableTypeController!.text =
                            getCableServiceList![int].description;
                        selectedItem = getCableServiceList![int];
                      });

                      getUtility();

                      //  selectedItem = getUtilityServiceList![int];

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              getCableServiceList![int].description,
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
                itemCount: getCableServiceList!.length)
          ],
        ),
      ),
    );
  }

  Future<void> getUtility() async {
    isLoading = true;
    cableDetailsList = await BillPaymentService().getCableDetailsService(
      context,
      selectedItem!.billId.toString(),
    );

    setState(() {
      isLoading = false;
    });
  }

  Widget detailsdropdown() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search plan',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Icon(MdiIcons.close)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              OutlineInput(
                labelText: 'Search',
                preffixWidget: Icon(MdiIcons.magnify),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  smartPlanController!.text =
                                      cableDetailsList![int].name;
                                  //  selectedItem = getUtilityServiceList![int];

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '${cableDetailsList![int].name}  NGN ${cableDetailsList![int].amount}',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: cableDetailsList!.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
