import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetPinWidget extends StatefulWidget {
  // String email;
  // Map<String, String> data;

  const ResetPinWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPinWidget> createState() => _ResetPinWidgetState();
}

class _ResetPinWidgetState extends State<ResetPinWidget> {
  String? currentText;

  var textEditingController;
  late DateTime alert;
  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(const Duration(seconds: 60));

    SettingsService().getPinCode(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
      appBar:
          AppBars().whiteAppBarWithBackButton('Reset Transaction PIN', context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
           
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'A reset code has been sent to your email and phone number',
                      textAlign: TextAlign.center,
                      style: TextStyles().greyTextStyle()),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      keyboardType: TextInputType.number,
                      pastedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),

                       textStyle: TextStyles().blackTextStyle(),
               
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        borderWidth: 1.5,
                        activeFillColor: Colors.white,
                        inactiveColor: const Color(0xffF9F9FA),
                        selectedFillColor: Colors.white,
                        selectedColor: const Color(0xffF9F9FA),
                        disabledColor: const Color(0xffF9F9FA),
                        inactiveFillColor: const Color(0xffF9F9FA),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: textEditingController,
                      //  keyboardType: TextI,

                      onCompleted: (v) {
                        debugPrint('Completed');
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint('Allowing to paste $text');
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
                const SizedBox(
                  height: 40,
                ),
                TimerBuilder.scheduled([alert], builder: (context) {
                  // This function will be called once the alert time is reached
                  var now = DateTime.now();
                  var reached = now.compareTo(alert) >= 0;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Icon(
                        //   reached ? Icons.alarm_on : Icons.alarm,
                        //   color: reached ? Colors.red : Colors.green,
                        //   size: 48,
                        // ),
                        !reached
                            ? TimerBuilder.periodic(const Duration(seconds: 1),
                                alignment: Duration.zero, builder: (context) {
                                // This function will be called every second until the alert time
                                var now = DateTime.now();
                                var remaining = alert.difference(now);
                                return Text(formatDuration(remaining)
                                    // remaining.toString().trim(),

                                    );
                              })
                            : InkWell(
                              onTap: () {
                                setState(() {
                                  SettingsService().getPinCode(context);
                                alert = DateTime.now()
                                    .add(const Duration(seconds: 60));
                                    
                                  
                                });
                                
                              },
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Still not getting OPT?  ',
                                          style: TextStyles()
                                              .greyTextStyle()
                                              .copyWith(fontSize: 14)),
                                      TextSpan(
                                          text: ' Resend Otp',
                                          style: TextStyles()
                                              .purpleTextStyle()
                                              .copyWith(fontSize: 14)),
                                    ],
                                  )),
                            ),
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    text: 'Continue',
                    onPressed: () {
                      // setState(() {
                      //   widget.data['token'] = currentText.toString();
                      // });
                      SettingsService().resetPin(context, {'otp': currentText});
                    }),
                const SizedBox(
                  height: 20,
                ),
                // RichText(
                //     textAlign: TextAlign.center,
                //     text: TextSpan(
                //       children: <TextSpan>[
                //         TextSpan(
                //             text: 'Want to switch?  ',
                //             style: TextStyles()
                //                 .greyTextStyle()
                //                 .copyWith(fontSize: 14)),
                //         TextSpan(
                //             text: ' Email address',
                //             style: TextStyles()
                //                 .purpleTextStyle()
                //                 .copyWith(fontSize: 14)),
                //       ],
                //     )),
              ],
            )),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  resendResetPinWidget() {


    // if (textController1.text.isEmpty) {
    //   setState(() {
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => HomeNavBar()));
    //   });
    // } else {
    //Navigator.push(context,
    //    MaterialPageRoute(builder: (context) => LoadingListPage()));
    //
    var body = {
      //"email": widget.email,
    };
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (kDebugMode) {
      print(body);
    }
    HttpRequest('/user/auth/forgot-password',
        body: body,
        headers: header,
        context: context,
        loader: LoaderType.popup, onSuccess: (_, result) async {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: result['message'],
        ),
      );
    }, onFailure: (_, result) {
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: result['message'],
        ),
      );

      // print(result['details']);
      return;
    }).send();

    // }
  }
}
