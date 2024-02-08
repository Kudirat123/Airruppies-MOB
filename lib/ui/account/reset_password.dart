import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/verify_with_pin.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';

class InAppResetPassword extends StatefulWidget {
  //Map<String, String> data;
  const InAppResetPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<InAppResetPassword> createState() => _InAppResetPasswordState();
}

class _InAppResetPasswordState extends State<InAppResetPassword> {
  TextEditingController? oldpasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmPasswordController;

  @override
  void initState() {
    oldpasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
      appBar:
          AppBars().whiteAppBarWithBackButton('Reset your password', context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
           
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'At least 8 characters, with uppercase and lowercase letters',
                    textAlign: TextAlign.center,
                    style: TextStyles().greyTextStyle()),
                const SizedBox(
                  height: 55,
                ),
                OutlineInput(
                  controller: oldpasswordController,
                  preffixWidget: const Icon(Icons.lock),
                  labelText: 'Old Password',
                ),
                const SizedBox(
                  height: 25,
                ),
                OutlineInput(
                  controller: newPasswordController,
                  preffixWidget: const Icon(Icons.lock),
                  labelText: 'New Password',
                ),
                const SizedBox(
                  height: 25,
                ),
                OutlineInput(
                  controller: confirmPasswordController,
                  preffixWidget: const Icon(Icons.lock),
                  labelText: 'Confirm Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  text: 'Submit',
                  onPressed: () {
                    var data = {
                      'old_password':oldpasswordController?.text,
                      'password': newPasswordController?.text,
                      'password_confirmation': confirmPasswordController?.text
                    };

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               VerifywithPinWidget(data: data)));
                  },
                ),
              ],
            )),
      ),
    );
  }
}
