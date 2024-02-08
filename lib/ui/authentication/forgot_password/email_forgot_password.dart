import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ForgotPassword extends StatefulWidget {
   const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController? emailController;

  bool _switchedOn = false;

  @override
  void initState() {
    emailController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars().backButton(context),
      body: SafeArea(
        
        child: Padding(
          padding:  const EdgeInsets.all(15.0),
          child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Password Recovery',
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontWeight: FontWeight.w900)),
                   const SizedBox(
                    height: 8,
                  ),
                  Text('Enter your Phone number to recover your password',
                      textAlign: TextAlign.center,
                      style: TextStyles().greyTextStyle()),
                   const SizedBox(
                    height: 48,
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                  OutlineInput(
                    controller: emailController,
                    preffixWidget:  Icon(!_switchedOn?  MdiIcons.phone : MdiIcons.email),
                  ),
                   const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                      text: 'Continue',
                      onPressed: () {
                        AuthService().getOtpforResetPassword(context, {
                          'identifier': emailController
                              ?.text //field can be an email or phone number
                        });
                      }),
                   const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _switchedOn = !_switchedOn;
                      });
                    },
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Want to switch?  ',
                                style: TextStyles().greyTextStyle()),
                            TextSpan(
                                text: _switchedOn
                                    ? 'Phone Number'
                                    : ' Email address',
                                style: TextStyles().purpleTextStyle()),
                          ],
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  // _signUp() {
  //   var formKey;

  //   // if (textController1.text.isEmpty) {
  //   //   setState(() {
  //   //     Navigator.push(
  //   //         context, MaterialPageRoute(builder: (context) => HomeNavBar()));
  //   //   });
  //   // } else {
  //   //Navigator.push(context,
  //   //    MaterialPageRoute(builder: (context) => LoadingListPage()));
  //   //
  //   var body = {
  //     "email": emailController!.text.trim(),
  //   };
  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   if (kDebugMode) {
  //     print(body);
  //   }
  //   HttpRequest('/user/auth/forgot-password',
  //       body: body,
  //       headers: header,
  //       context: context,
  //       loader: LoaderType.popup, onSuccess: (_, result) async {
  //     Navigator.pop(context);

  //     var data = {
  //       "email": emailController!.text,
  //       "token": "",
  //       "password": "",
  //       "password_confirmation": ""
  //     };

  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //                 Otp(email: emailController!.text, data: data)));
  //   }, onFailure: (_, result) {
  //     Navigator.pop(context);
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
