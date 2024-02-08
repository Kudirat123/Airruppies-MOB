import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/savings/model/user_savings_model.dart';
import 'package:airruppies/ui/savings/savings_service/savings_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class SavingsWithdrawSummary extends StatefulWidget {
  const SavingsWithdrawSummary({super.key, this.data});
final  UserSavingsModel? data;

  @override
  State<SavingsWithdrawSummary> createState() => _SavingsWithdrawSummaryState();
}

class _SavingsWithdrawSummaryState extends State<SavingsWithdrawSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar:
          AppBars().whiteAppBarWithBackButton('Withdrawal Details', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SummaeyCard(
                  firstText: 'Name',
                  secondText: widget.data!.title,
                ),
                const SizedBox(
                  height: 15,
                ),
                SummaeyCard(
                  firstText: 'Withdrawal Amount',
                  secondText: '₦ ${widget.data!.amount}',
                ),
                const SizedBox(
                  height: 15,
                ),
               const  SummaeyCard(
                  firstText: 'Penalty Fee',
                  secondText: '20',
                ),
                const SizedBox(
                  height: 15,
                ),
                SummaeyCard(
                  firstText: 'Withdraw Date',
                  secondText: widget.data!.maturityDate,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 45,
                ),
              ],
            ),
            Column(
              children: [
                MyButton(
                  text: 'Continue',
                  onPressed: () {
                    var reference = tools.generateRandomString(20);
                    var body = {
                      // 'old_pin': '2512',
                      'amount': widget.data!.amount,
                      'session_id': reference,
                      'location': '5.343433,7.739793'
                    };
                    SavingsService()
                        .withdrawSavings(context, body, widget.data!.id);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  text: 'Decline',
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SuccessAirFixedWidget()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sendMoney(IconData icon, String firstText, String secondText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF7EDFC),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: Colors.grey,
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
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    secondText,
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            //const Icon(Icons.arrow_forward_ios, size: 13)
          ],
        ),
      ),
    );
  }
}

class SummaeyCard extends StatelessWidget {
 const  SummaeyCard({super.key, this.firstText, this.secondText});

 final String? firstText;
final  String? secondText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color(0xffD7DEE7),
          thickness: 0.4,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              firstText.toString(),
              style: TextStyles().greyTextStyle().copyWith(fontSize: 12),
            ),
            Text(
              secondText.toString(),
              style: Theme.of(context).textTheme.displaySmall!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ],
    );
  }
}
