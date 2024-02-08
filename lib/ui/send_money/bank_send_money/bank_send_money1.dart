import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/send_money/bank_send_money/bank_send_money2.dart';
import 'package:airruppies/ui/send_money/model/bankList_model.dart';
import 'package:airruppies/ui/send_money/model/bank_beneficary_model.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/ui/send_money/send_money_state/send_money_state.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../more/beneficiary/airRuppies_beneficiary.dart';

class BankSendMoneyWidget extends StatefulWidget {
  const BankSendMoneyWidget({super.key});

  @override
  State<BankSendMoneyWidget> createState() => _BankSendMoneyWidgetState();
}

class _BankSendMoneyWidgetState extends State<BankSendMoneyWidget> {
  List<BankModel>? bankList;
  List<BankModel>? bankItems;

  BankModel? selectedBank;

  String? filterText;
  TextEditingController? bankNameController;
  TextEditingController? accountNumberController;
  List<BankBeneficiaryModel>? bankBeneficiaryList;

  bool? loading = true;
  String? userName;

  bool verifyBankAccountLoading = false;

  Future<void> getData() async {
    var bankState = Provider.of<BankState>(context, listen: false);
    bankList = bankState.bankList!;
    bankItems = bankList;
    // ignore: avoid_print
    print(bankList);
  }

  Future<void> getBeneficiary() async {
    loading = true;
    bankBeneficiaryList = await BankService().getBeneficiaryList(context);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getBeneficiary();
    bankNameController = TextEditingController();
    accountNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('Send Money', context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            OutlineInput(
              controller: accountNumberController,
              labelText: 'Account Number',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlineInput(
              controller: bankNameController,
              labelText: 'Bank Name',
              suffixWidget: Icon(MdiIcons.chevronDown),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  builder: (context) {
                    return _buildBottomSheet();
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Text(
              userName.toString() == 'null' ? '' : userName.toString(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displaySmall!,
            ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: verifyBankAccountLoading
                  ? const CircularProgressIndicator()
                  : MyButton(
                      text: 'Next',
                      onPressed: () {
                        var nextBody = {
                          'account_name': userName,
                          'account_number': accountNumberController!.text,
                          'bank_code': selectedBank!.bankCode,
                          'bank_name': selectedBank!.bankName,
                          'session_id': '20828272871879102923',
                          'amount': 0,
                          'save': '',
                          'location':
                              Provider.of<AuthState>(context, listen: false)
                                  .userLocation,
                        };

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BankSendMoneyWidget2(data: nextBody)));
                      },
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Beneficiaries',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text('See All',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: themes().primaryColor))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: loading!
                  ? const CircularProgressIndicator()
                  : Container(
                      child: bankBeneficiaryList!.isEmpty
                          ? Container()
                          : GridView.count(
                              shrinkWrap: true,
                              //  crossAxisSpacing: 3.0,
                              mainAxisSpacing: 19.0,
                              crossAxisCount: 4, // Number of items in each row
                              children: List.generate(
                                  bankBeneficiaryList!.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    var nextBody = {
                                      'account_name':
                                          bankBeneficiaryList![index]
                                              .accountName,
                                      'account_number':
                                          bankBeneficiaryList![index]
                                              .accountNumber,
                                      'bank_code':
                                          bankBeneficiaryList![index].bankCode,
                                      'bank_name':
                                          bankBeneficiaryList![index].bankName,
                                      'session_id': '20828272871879102923',
                                      'amount': 0,
                                      'save': true,
                                      'location': Provider.of<AuthState>(
                                              context,
                                              listen: false)
                                          .userLocation,
                                    };

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BankSendMoneyWidget2(
                                                    data: nextBody)));
                                  },
                                  child: GridItem(
                                    image: CircleAvatar(
                                      backgroundColor: themes().primaryColor,
                                      radius: 27,
                                      child: Text((bankBeneficiaryList![index]
                                              .accountName[0])
                                          .toString()),
                                    ),
                                    text: Text(
                                      bankBeneficiaryList![index].accountName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 11),
                                    ),
                                  ),
                                );
                              }),
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return StatefulBuilder(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  filterText = text;
                });
                updated(state);
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bankItems!.length,
                itemBuilder: (context, index) {
                  //  String item = bankItems![index].bankName;
                  // bool isFiltered = filterText.isNotEmpty &&
                  //     !item.toLowerCase().contains(filterText.toLowerCase());
                  return ListTile(
                    title: Text(bankItems![index].bankName,
                        style: Theme.of(context).textTheme.displaySmall!),
                    onTap: () async {
                      // ignore: avoid_print
                      print(selectedBank);
                      Navigator.pop(context);
                      setState(() {
                        verifyBankAccountLoading = true;
                      });

                      selectedBank = bankItems![index];
                      bankNameController?.text = selectedBank!.bankName;

                      var body = {
                        'bank_code': selectedBank!.bankCode.toString(),
                        'account_number': accountNumberController!.text,
                        'location': '6.298292,-7.276726'
                      };
                      // Loaders().showModalLoading(context);

                      var result = await BankService()
                          .verifyAccountNumber(context, body);
                      // ignore: avoid_print
                      print(result);

                      setState(() {
                        userName = result['data']['account_name'];
                        verifyBankAccountLoading = false;
                      });

                      // ignore: avoid_print
                      print(result);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> updated(StateSetter updateState) async {
    updateState(() {
      setState(() {
        bankItems = bankList!
            .where((element) =>
                element.bankName.toLowerCase().contains(filterText.toString()))
            .toList();

        // ignore: avoid_print
        print(bankItems);
        // items = itemss!;
      });
    });
  }
}
