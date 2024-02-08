import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:airruppies/widget/modal/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class FirstAddMoneyWidget extends StatefulWidget {
  const FirstAddMoneyWidget({super.key});

  @override
  State<FirstAddMoneyWidget> createState() => _FirstAddMoneyWidgetState();
}

class _FirstAddMoneyWidgetState extends State<FirstAddMoneyWidget> {
  Map<String, dynamic>? userDetails;

  bool? loading = true;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    loading = true;
    userDetails = Provider.of<AccountState>(context, listen: false).userDetails;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        appBar: AppBars().whiteAppBarWithBackButton('Add Money', context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: loading!
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //height: 256,
                      decoration: ShapeDecoration(
                        color: !state.isDarkMode
                            ? const Color(0xff1F1723)
                            : const Color(0xFFF6EDFB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                            color: const Color(0xFFF7F2FA),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(19.50),
                                            )),
                                        child: Center(
                                            child:
                                                Icon(MdiIcons.swapHorizontal))),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('Via Bank Transfer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700))
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Share.share(
                                        'Account Number : ${userDetails!['virtual_account']['account_number']}  , Bank : ${userDetails!['virtual_account']['bank_name']}  ,  Bank Name : ${userDetails!['virtual_account']['bank_name']}');
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                          color: themes().primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(19.50),
                                          )),
                                      child: Center(
                                          child: Icon(
                                        MdiIcons.shareVariant,
                                        color: Colors.white,
                                        size: 14,
                                      ))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'to add money to your airRupple Wallet, make a bank transfer of up to 1million to the account detail below. fund reflect instantly',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 10)),
                            const SizedBox(
                              height: 15,
                            ),
                            AddMoneyCard(
                              firstText: 'Bank name',
                              secondText: userDetails!['virtual_account']
                                  ['bank_name'],
                              imageString:
                                  'assets/images/send_money_assets/Icon (1).png',
                              copy: false,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AddMoneyCard(
                              firstText: 'Account number',
                              secondText: userDetails!['virtual_account']
                                  ['account_number'],
                              imageString:
                                  'assets/images/send_money_assets/Hash.png',
                              copy: true,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AddMoneyCard(
                              firstText: 'Beneficiary',
                              secondText: userDetails!['virtual_account']
                                  ['account_name'],
                              imageString:
                                  'assets/images/send_money_assets/Icon (2).png',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Or',
                                style: TextStyles()
                                    .greyTextStyle()
                                    .copyWith(fontSize: 14)),
                          ),
                          const Expanded(
                              child: Divider(
                            height: 1,
                          )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Modal().comingSoonToast('', context);
                      },
                      child: SendMoney(MdiIcons.pound, 'USSD',
                          'Transfer using your other banks’ USSD code'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Modal().comingSoonToast('', context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  BluetoothSendMoneyWidget()));
                      },
                      child: SendMoney(
                          MdiIcons.wallet,
                          'Top up with debit card',
                          'Fund with bank debit card'),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget SendMoney(IconData icon, String firstText, String secondText) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: !state.isDarkMode
              ? const Color(0xff323045)
              : const Color(0xffF7EDFC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      state.isDarkMode ? Colors.white : const Color(0xff1F1723),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    icon,
                    color: state.isDarkMode
                        ? const Color(0xff551B73)
                        : Colors.white,
                    size: 19,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstText,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      secondText,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 13)
            ],
          ),
        ),
      ),
    );
  }
}

class AddMoneyCard extends StatelessWidget {
  const AddMoneyCard(
      {super.key,
      this.firstText,
      this.secondText,
      this.copy,
      this.imageString});
  final String? firstText;
  final String? secondText;
  final bool? copy;
  final String? imageString;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        width: MediaQuery.of(context).size.width,
        //   height: 40,
        padding: const EdgeInsets.only(top: 4, left: 8, right: 16, bottom: 4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: !state.isDarkMode ? const Color(0xff323045) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: state.isDarkMode
                        ? Colors.white
                        : const Color(0xff1F1723),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: ShapeDecoration(
                          color: state.isDarkMode
                              ? Colors.white
                              : const Color(0xff1F1723),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1.33,
                              top: 1.33,
                              child: SizedBox(
                                width: 13.33,
                                height: 13.33,
                                child: Image.asset(imageString.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(firstText.toString(),
                          style: TextStyles()
                              .greyTextStyle400()
                              .copyWith(fontSize: 10)),
                      const SizedBox(height: 4),
                      Text(secondText.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                child: copy == true
                    ? InkWell(
                        onTap: () {
                          BottomPopUpModal()
                              .copyToClipboard(secondText.toString(), context);
                        },
                        child: Icon(
                          MdiIcons.contentCopy,
                          size: 13,
                        ),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }
}
