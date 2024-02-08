import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/bill_payment/model/cable_model/cable_detail_model.dart';
import 'package:airruppies/ui/data/airtime_service/data_service.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class DataPinWidget extends StatefulWidget {
const DataPinWidget({super.key, this.body, this.dataItem});
final  Map<String, Object?>? body;
final  CableDetailModel? dataItem;

  @override
  State<DataPinWidget> createState() => _DataPinWidgetState();
}

class _DataPinWidgetState extends State<DataPinWidget> {
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
      appBar: AppBars().myWhiteAppBar('Transaction Details', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SummaeyCard(
                  firstText: 'Transaction Type',
                  secondText: 'Data',
                ),
                SummaeyCard(
                  firstText: 'Amount',
                  secondText: widget.dataItem!.amount.toString(),
                ),
                SummaeyCard(
                  firstText: 'Date',
                  secondText: tools.parseDate(DateTime.now()),
                ),
                SummaeyCard(
                  firstText: 'Plan',
                  secondText: widget.dataItem!.name.toString(),
                ),
                SummaeyCard(
                  firstText: 'Network',
                  secondText: widget.body!['network'].toString(),
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
                      'session_id':
                          tools.generateRandomString(20), //unique session id
                      'phoneNumber': widget.body!['beneficiary'].toString(),
                      'bouquet': widget.dataItem!.id
                          .toString(), // 'the id on the data plan'
                      'amount': widget.dataItem!.amount.toString(),
                      'serviceProvider':
                          widget.body!['network'].toString().toLowerCase()
                    };

                    DataService()
                        .buyPinData(context, pinController!.text, body);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SendMoneySuccessWidget()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
