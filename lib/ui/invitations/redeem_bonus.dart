import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/account_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedeemBonusWidget extends StatefulWidget {
 const RedeemBonusWidget({super.key, required this.data});
 final Map<String, dynamic> data;

  @override
  State<RedeemBonusWidget> createState() => _RedeemBonusWidgetState();
}

class _RedeemBonusWidgetState extends State<RedeemBonusWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton('My Bonus', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bonusCard(
                'Redeemed Bonuses',
                'assets/svgs/invitation_svgs/Vector1.svg',
                'N ${widget.data['Amount']}'),
            Text(
              'You  are allowed to redeem your bonus upon reaching 5000 points',
              textAlign: TextAlign.center,
              style: TextStyles()
                  .greyTextStyle()
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            MyButton(
              text: 'Redeem Bonus',
              onPressed: () {
                var body = {'amount': widget.data['Amount']};
                AccountSerice().withdrawBonus(context, body);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget bonusCard(String mainText, String iconString, String amount) {
    return Container(
      height: 110,
      width: 150,
      decoration: BoxDecoration(
          color: const Color(0xffF7EDFC),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: TextStyles()
                  .blackTextStyle()
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
                  style: TextStyles()
                      .blackTextStyle()
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 22),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
