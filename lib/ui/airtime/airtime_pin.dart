import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/airtime/airtime_service/airtime_service.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class AirtimePinWidget extends StatefulWidget {
  const AirtimePinWidget({super.key, this.data});
 final  Map<String, dynamic>? data;

  @override
  State<AirtimePinWidget> createState() => _AirtimePinWidgetState();
}

class _AirtimePinWidgetState extends State<AirtimePinWidget> {
  TextEditingController? pinController;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().myWhiteAppBar('Airtime Summary', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SummaeyCard(
                  firstText: 'Transaction Type',
                  secondText: 'Airtime',
                ),
                SummaeyCard(
                  firstText: 'Amount',
                  secondText: widget.data!['amount'],
                ),
                SummaeyCard(
                  firstText: 'Date',
                  secondText: tools.parseDate(DateTime.now()),
                ),
                SummaeyCard(
                  firstText: 'Beneficiary',
                  secondText: widget.data!['beneficiary'],
                ),
                SummaeyCard(
                  firstText: 'Network',
                  secondText: widget.data!['network'],
                ),
                const SizedBox(
                  height: 48,
                ),
                ReUsablePin(
                  textController: pinController,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Verify this transaction with your PIN',
                  textAlign: TextAlign.center,
                  style: TextStyles().blackTextStyle().copyWith(
                      fontSize: 15,
                      color: const Color(0xffA2A0A8),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              children: [
                MyButton(
                  text: 'Make Payment',
                  onPressed: () {
                    var body = {
                      'session_id': tools.generateRandomString(20),
                      'amount': widget.data!['amount'],
                      'phoneNumber': widget.data!['beneficiary'],
                      'serviceProvider':
                          widget.data!['network'].toString().toLowerCase()
                    };

                    AirtimeSerice().buyPinAirtime(
                        context, pinController!.text.toString(), 
                      body
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  text: 'Cancel',
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
