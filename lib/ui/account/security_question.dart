import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';

class SecurityQuestionWidget extends StatefulWidget {
  const SecurityQuestionWidget({super.key});

  @override
  State<SecurityQuestionWidget> createState() => _SecurityQuestionWidgetState();
}

class _SecurityQuestionWidgetState extends State<SecurityQuestionWidget> {
  var result;
  TextEditingController? answerController;

  @override
  void initState() {
    super.initState();
    exampleUsage();
    answerController = TextEditingController();
  }

  Future<void> exampleUsage() async {
    try {
      result = await SettingsService().getSecurityQuestion(context);
      // Use the result here
    } catch (error) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBars().whiteAppBarWithBackButton('Security Questions', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(result['data']),
            const SizedBox(
              height: 20,
            ),
            OutlineInput(
              labelText: 'Answer',
              controller: answerController,
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              text: 'Submit',
              onPressed: () {
                var body = {'answer': answerController?.text};
                SettingsService().submitQuestion(context , body);
              },
            )
          ],
        ),
      ),
    );
  }
}
