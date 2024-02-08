import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/airruppies_to_airruppies/p2p_amount.dart';
import 'package:airruppies/ui/send_money/beneficiaries/beneficiaries_send_money.dart';
import 'package:airruppies/ui/send_money/contact_sync.dart';
import 'package:airruppies/ui/send_money/model/user_nearme_model.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SendMoneyWidget extends StatefulWidget {
  const SendMoneyWidget({super.key});

  @override
  State<SendMoneyWidget> createState() => _SendMoneyWidgetState();
}

class _SendMoneyWidgetState extends State<SendMoneyWidget> {
  TextEditingController? phoneNumber;

  var userDetails;

  bool? loading = false;

  List<UserNearMeModel>? userNearMeList = [];
  @override
  void initState() {
    super.initState();
    phoneNumber = TextEditingController();
  }

  getUserDetails(String input) async {
    // Your implementation here

    var userDetail = await BankService()
        .checkForAirruppiesCustomer(context, phoneNumber!.text.toString());
    setState(() {
      userDetails = userDetail;
      // ignore: avoid_print
      print(userDetail['data'][0]);
    });
  }

  Future<void> getUserNearMe() async {
    setState(() {
      loading = true;
    });

    userNearMeList = await BankService().getUserNearMe(
      context,
    );

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBars().whiteAppBarWithBackButton('Send Money', context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Expanded(child: MyButton(text: 'AirRuppies')),
                //      const SizedBox(
                //       width: 20,
                //     ),
                //     Expanded(
                //         child: SecondaryButton(
                //       text: 'Transfer',
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                      const SendMoneyBeneficiaryPage()));
                //       },
                //     ))
                //   ],
                // ),
                //  const SizedBox(
                //   height: 28,
                // ),
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
                  labelText: 'Phone Number/Username',
                  controller: phoneNumber,
                  //  onChanged: getUserDetails,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: userDetails == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userDetails['data'][0] == null
                                  ? ''
                                  : userDetails['data'][0]['name'],
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.displaySmall!,
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    text: userDetails == null ? 'check ' : 'Continue',
                    onPressed: () {
                      userDetails == null
                          ? getUserDetails(phoneNumber!.text)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      P2PTransactionAmountPage(
                                        data: userDetails['data'][0],
                                      )));
                    }),
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
                        color: !state.isDarkMode
                            ? const Color(0xff323045)
                            : const Color.fromRGBO(247, 237, 252, 1),
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

                Container(
                  child: loading!
                      ? const CircularProgressIndicator()
                      : Container(
                          child: userNearMeList!.isEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Nearby you',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SvgPicture.asset(
                                        'assets/svgs/send_money_svgs/empty-box 1.svg'),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Can’t find anything airRuppies account near by. Try Again',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 12,
                                              color: const Color(0xffA2A0A8),
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    SizedBox(
                                        width: 200,
                                        height: 40,
                                        child: MyButton(
                                          text: 'Reload',
                                          onPressed: () {
                                            getUserNearMe();
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const SelectBankWidget()));
                                          },
                                        ))
                                  ],
                                )
                              : GridView.count(
                                  shrinkWrap: true,
                                  //  crossAxisSpacing: 3.0,
                                  mainAxisSpacing: 19.0,
                                  crossAxisCount:
                                      4, // Number of items in each row
                                  children: List.generate(
                                      userNearMeList!.length, (index) {
                                    return InkWell(
                                      onTap: () async {
                                        var userDetails = await BankService()
                                            .checkForAirruppiesCustomer(context,
                                                userNearMeList![index].phone);

                                        // ignore: avoid_print
                                        print(userDetails);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    P2PTransactionAmountPage(
                                                        data:
                                                            userDetails['data']
                                                                [0])));
                                      },
                                      child: GridItem(
                                        image: CircleAvatar(
                                          backgroundColor:
                                              themes().primaryColor,
                                          radius: 27,
                                          child: Text(
                                              (userNearMeList![index].name[0])
                                                  .toString()),
                                        ),
                                        text: Text(
                                          userNearMeList![index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(fontSize: 10),
                                        ),
                                      ),
                                    );
                                  }),
                                )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
