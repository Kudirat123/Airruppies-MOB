import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/send_money/bank_send_money/bank_send_money2.dart';
import 'package:airruppies/ui/send_money/contact_sync.dart';
import 'package:airruppies/ui/send_money/model/bank_beneficary_model.dart';
import 'package:airruppies/ui/send_money/send_money.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SendMoneyBeneficiaryPage extends StatefulWidget {
  const SendMoneyBeneficiaryPage({super.key});

  @override
  State<SendMoneyBeneficiaryPage> createState() =>
      _SendMoneyBeneficiaryPageState();
}

class _SendMoneyBeneficiaryPageState extends State<SendMoneyBeneficiaryPage> {
  List<BankBeneficiaryModel>? bankBeneficiaryList;

  bool? loading = true;

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
    getBeneficiary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars().whiteAppBarWithBackButton('Send Money', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: loading!
              ? Center(
                  child: CircularProgressIndicator(
                  color: themes().primaryColor,
                ))
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: SecondaryButton(
                          text: 'Air Ruppies',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SendMoneyWidget()));
                          },
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        const Expanded(
                            child: MyButton(
                          text: 'Transfer',
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'Make a USSD transfer from your bank account into your air ruppies account',
                      textAlign: TextAlign.center,
                      style: TextStyles().blackTextStyle().copyWith(
                          fontSize: 12,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlineInput(
                      labelText: 'User Phone Number',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SyncContact()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(247, 237, 252, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.wallet,
                                color: themes().primaryColor,
                                size: 21,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact using AirRupples',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '23 friends on your contact list use AirRupples',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [],
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      //  crossAxisSpacing: 3.0,
                      mainAxisSpacing: 19.0,
                      crossAxisCount: 4, // Number of items in each row
                      children:
                          List.generate(bankBeneficiaryList!.length, (index) {
                        return InkWell(
                          onTap: () {
                            var nextBody = {
                              'account_name':
                                  bankBeneficiaryList![index].accountName,
                              'account_number':
                                  bankBeneficiaryList![index].accountNumber,
                              'bank_code': bankBeneficiaryList![index].bankCode,
                              'bank_name': bankBeneficiaryList![index].bankName,
                              'session_id': '20828272871879102923',
                              'amount': 0,
                              'save': true,
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
                          child: GridItem(
                            image: CircleAvatar(
                              radius: 27,
                              child: Text(
                                  (bankBeneficiaryList![index].accountName[0])
                                      .toString()),
                            ),
                            text: Text(
                              bankBeneficiaryList![index].accountName,
                              style: TextStyles()
                                  .blackTextStyle()
                                  .copyWith(fontSize: 11),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.image, required this.text});
  final Widget image;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const SizedBox(height: 8.0),
        text,
      ],
    );
  }
}
