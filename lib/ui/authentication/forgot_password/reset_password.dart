import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    Key? key,
    this.body,
  }) : super(key: key);
  //Map<String, String> data;
final   dynamic body;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBars().backButton(context),
        backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Reset Password',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'At least 8 characters, with uppercase and lowercase letters',
                    textAlign: TextAlign.center,
                    style: TextStyles().greyTextStyle()),
                const SizedBox(
                  height: 48,
                ),
                const SizedBox(
                  height: 5,
                ),
                OutlineInput(
                  controller: passwordController,
                  preffixWidget: const Icon(Icons.lock),
                  labelText: 'New Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 5,
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
                    var body = {
                      'identifier': widget.body['identifier'],
                      'password': passwordController!.text,
                      'password_confirmation': confirmPasswordController!.text
                    };

                    AuthService().ResetPasswordfunction(context, body);
                  },
                ),
              ],
            )),
      ),
    );
  }

  // _resetPassword() {
  //   // Loading(context);
  //   var formKey;
  //   setState(() {
  //     widget.data['password'] = passwordController!.text;
  //     widget.data['password_confirmation'] = confirmPasswordController!.text;
  //   });

  //   var body = widget.data;
  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   if (kDebugMode) {
  //     print(body);
  //   }
  //   HttpRequest('/user/auth/reset-password',
  //       body: body,
  //       headers: header,
  //       context: context,
  //       loader: LoaderType.popup, onSuccess: (_, result) async {
  //     // Provider.of<DefaultState>(context, listen: false)
  //     //     .setToken(context, result['access_token'], result);

  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => const Login()));
  //   }, onFailure: (_, result) {

  //     showTopSnackBar(
  //       Overlay.of(context)!,
  //       CustomSnackBar.error(
  //         message: result['message'],
  //       ),
  //     );

  //     print(result['details']);
  //     return;
  //   }).send();

  //   // }
  // }
}
