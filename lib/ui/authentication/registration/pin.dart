import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/registration_service.dart';
import 'package:airruppies/utils/network.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreatePin extends StatefulWidget {
  // String email;
  // Map<String, String> data;

  const CreatePin({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  String? currentText;

  TextEditingController? textEditingController;
  late DateTime alert;
  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(const Duration(seconds: 60));

    textEditingController= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().whiteColor,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Text('Create New Pin',
                        style: TextStyles().blackTextStyle().copyWith(
                            fontWeight: FontWeight.w900, fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Add a pin number to make your wallet more secure',
                        textAlign: TextAlign.center,
                        style: TextStyles().greyTextStyle()),
                    const SizedBox(
                      height: 48,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          keyboardType: TextInputType.number,
                          textStyle: TextStyles().blackTextStyle(),
                          pastedTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.white,
                          length: 4,
                          obscureText: true,
                          obscuringCharacter: '*',
                          // obscuringWidget: const FlutterLogo(
                          //   size: 24,
                          // ),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          // validator: (v) {
                          //   if (v!.length < 3) {
                          //     return 'I'm from validator';
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
                            inactiveColor:
                                const Color.fromARGB(105, 214, 214, 218),
                            selectedFillColor: Colors.white,
                            selectedColor:
                                const Color.fromARGB(105, 214, 214, 218),
                            disabledColor:
                                const Color.fromARGB(105, 214, 214, 218),
                            inactiveFillColor:
                                const Color.fromARGB(255, 214, 214, 218),
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
                           onTap: () {
                          //   // ignore: avoid_print
print('Pressed');
                          },
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
                      height: 30,
                    ),
                    MyButton(
                        text: 'Submit',
                        onPressed: () {
                          var body = {
                            // 'old_pin': '2512',
                            'pin': textEditingController?.text,
                            'pin_confirmation':  textEditingController?.text,
                            'location': '5.343433,7.739793'
                          };
                          RegistrationSerice().createPin(context, body);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
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

  resendCreatePin() {
  //  var formKey;

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
      //'email': widget.email,
    };
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (kDebugMode) {
      // ignore: avoid_print
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

      // // ignore: avoid_print
print(result['details']);
      return;
    }).send();

    // }
  }
}
