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

class UtilityPage extends StatefulWidget {
  const UtilityPage({super.key});

  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  bool _switchValue = false;
  bool? isLoading;
  List<CableModel>? getUtilityServiceList;
  TextEditingController? smartCardNumberController;
  TextEditingController? cableTypeController;
  TextEditingController? smartPlanController;
  CableModel? selectedItem;
  List<CableDetailModel>? cableDetailsList;

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
    getUtilityServiceList =
        Provider.of<BillPaymentState>(context, listen: false).utilityList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: themes().primaryColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Utility Service',
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Click here to Change Service',
                      style: TextStyles()
                          .purpleTextStyle()
                          .copyWith(fontSize: 13)),
                  const SizedBox(
                    height: 30,
                  ),

                  OutlineInput(
                    labelText: 'Meter Number',
                    controller: smartCardNumberController,
                    keyboardType: TextInputType.number,
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
                              height: MediaQuery.of(context).size.height * .8,
                              child: dropdown()));
                    },
                    labelText: 'Select Service type',
                    controller: cableTypeController,
                    suffixWidget: const Icon(Icons.arrow_drop_down_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  OutlineInput(
                    labelText: 'Amount',
                  ),

                  // OutlineInput(
                  //   onTap: () {
                  //     BottomPopUpModal().bottomPopup(
                  //         context,
                  //         SizedBox(
                  //             height: MediaQuery.of(context).size.height * .4,
                  //             child: dropdown()));
                  //   },
                  //   labelText: 'Select Plan',
                  //   controller: smartPlanController,
                  //   suffixWidget:  Icon(Icons.arrow_drop_down_rounded),
                  // ),

                  //DropdownTextFormField(),

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save as beneficiary',
                        style: TextStyles()
                            .blackTextStyle()
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
                  'Search Utility Provider',
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
            SingleChildScrollView(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                cableTypeController!.text =
                                    getUtilityServiceList![index].name;

                                Navigator.pop(context);
                              },
                              child: Text(
                                getUtilityServiceList![index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
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
                  itemCount: getUtilityServiceList!.length),
            )
          ],
        ),
      ),
    );
  }

  //cable details list
}
