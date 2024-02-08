import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/invitations/model/bonus_friend_model.dart';
import 'package:airruppies/ui/invitations/redeem_bonus.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyBonusWidget extends StatefulWidget {
  const MyBonusWidget({super.key});

  @override
  State<MyBonusWidget> createState() => _MyBonusWidgetState();
}

class _MyBonusWidgetState extends State<MyBonusWidget> {
  bool isLoading = true;

  Map<String, dynamic>? bonusData;

  List<BonusFriendModel>? bonusFriendList;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    isLoading = true;
    bonusData = Provider.of<AccountState>(context, listen: false).bonuDetails;

    bonusFriendList = bonusData!['referrals']
        .map<BonusFriendModel>((element) => BonusFriendModel.fromJson(element))
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBars().whiteAppBarWithBackButton('My Bonus', context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        var data = {
                          'Amount': bonusData?['earnedBonus'],
                          'bonus_type': 'Earned Bonus'
                        };

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RedeemBonusWidget(data: data)));
                      },
                      child: bonusCard(
                          'Earned Bonuses',
                          'assets/svgs/invitation_svgs/Vector.svg',
                          'N ${bonusData?['earnedBonus']}'),
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        var data = {
                          'Amount': bonusData?['redeemedBonus'],
                          'bonus_type': 'Earned Bonus'
                        };

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RedeemBonusWidget(data: data)));
                      },
                      child: bonusCard(
                          'Redeemed Bonuses',
                          'assets/svgs/invitation_svgs/Vector1.svg',
                          'N ${bonusData?['redeemedBonus']}'),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Text(
                  'Your friends',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: bonusFriendList!.isEmpty
                      ? Container()
                      : Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(49, 36, 70, 205)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Friend',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                Text(
                                  'Referal ID',
                                  style: TextStyles().blackTextStyle().copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                Container(
                    child: bonusFriendList!.isEmpty
                        ? Container()
                        : MyBonusFriendCard(bonusFriendList: bonusFriendList)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bonusCard(String mainText, String iconString, String amount) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        height: 136,
        decoration: BoxDecoration(
            color: !state.isDarkMode
                ? const Color(0xff1F1723)
                : const Color(0xffF7EDFC),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    iconString,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    amount,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyBonusFriendCard extends StatefulWidget {
  MyBonusFriendCard({super.key, this.bonusFriendList});
  List<BonusFriendModel>? bonusFriendList;

  @override
  State<MyBonusFriendCard> createState() => _MyBonusFriendCardState();
}

class _MyBonusFriendCardState extends State<MyBonusFriendCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.bonusFriendList?.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(124, 227, 227, 227))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.bonusFriendList![index].referredUser,
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Text(
                    'N${widget.bonusFriendList![index].amountEarned.toString()}',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
