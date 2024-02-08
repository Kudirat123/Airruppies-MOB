import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';

import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePinWidget extends StatefulWidget {
  const ChangePinWidget({super.key});

  @override
  State<ChangePinWidget> createState() => _ChangePinWidgetState();
}

class _ChangePinWidgetState extends State<ChangePinWidget> {
  TextEditingController? oldPin;
  TextEditingController? newPin;
  TextEditingController? confirmNewPin;

  @override
  void initState() {
    oldPin = TextEditingController();
    newPin = TextEditingController();
    confirmNewPin = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars()
          .whiteAppBarWithBackButton('Change Transaction PIN', context),
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
                'Enter your old transaction PIN ',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ReUsablePin(
              textController: oldPin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Enter your new transaction PIN ',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ReUsablePin(
              textController: newPin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Confirm your new transaction PIN  ',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ReUsablePin(
              textController: confirmNewPin,
            ),
            const SizedBox(
              height: 45,
            ),
            MyButton(
              text: 'Submit',
              onPressed: () {
                var body = {
                  'old_pin': oldPin?.text,
                  'pin': newPin?.text,
                  'pin_confirmation': confirmNewPin?.text,
                  'location': Provider.of<AuthState>(context, listen: false)
                      .userLocation
                };
                // ignore: avoid_print
                print(body);

                SettingsService().createPinInAppp(context, body);
              },
            )
          ],
        ),
      ),
    );
  }
}
