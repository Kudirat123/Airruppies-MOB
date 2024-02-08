import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';

class VerifywithPinWidget extends StatefulWidget {
  const VerifywithPinWidget({super.key, required this.data});
 final  Map<String, String?> data;

  @override
  State<VerifywithPinWidget> createState() => _VerifywithPinWidgetState();
}

class _VerifywithPinWidgetState extends State<VerifywithPinWidget> {
  TextEditingController? pin;

  @override
  void initState() {
    super.initState();
    pin = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars().whiteAppBarWithBackButton('Verify with PIN', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Verify this transaction with your PIN ',
                style: TextStyles()
                    .blackTextStyle()
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ReUsablePin(
              textController: pin,
            ),
            const SizedBox(
              height: 200,
            ),
            MyButton(
              text: 'Submit',
              onPressed: () {
                SettingsService().verifyPin(context, pin!.text.toString(),
                    SettingsService().changePassword(context, widget.data));
              },
            )
          ],
        ),
      ),
    );
  }
}
