import 'package:airruppies/themes.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ReUsablePin extends StatefulWidget {
  ReUsablePin({super.key, this.textController});
  TextEditingController? textController;

  @override
  State<ReUsablePin> createState() => _ReUsablePinState();
}

class _ReUsablePinState extends State<ReUsablePin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          //backgroundColor: Colors.white,
          keyboardType: TextInputType.number,
          //  textStyle: Theme.of(context).textTheme.displaySmall!,
          textStyle: TextStyles().blackTextStyle(),

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
            inactiveColor: const Color(0xFFF9F9FA),
            selectedFillColor: Colors.white,
            selectedColor: const Color(0xFFF9F9FA),
            disabledColor: const Color(0xFFF9F9FA),
            inactiveFillColor: const Color(0xFFF9F9FA),
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          // errorAnimationController: errorController,
          controller: widget.textController,
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
              var currentText = value;
            });
          },
          beforeTextPaste: (text) {
            debugPrint('Allowing to paste $text');
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ));
  }
}

class OtherWidget {
  Widget divider() {
    return const Divider(
      color: Color(0xffD7DEE7),
      thickness: 0.4,
    );
  }

  InputDecoration resubleInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyles().greyTextStyle().copyWith(
            fontSize: 13,
          ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(
          color: Color(0xffF9F9FA),
        ),
      ),

      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(
          color: Color(0xffF9F9FA),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(
          color: Color(0xffF9F9FA),
        ),
      ),
      //   prefix: widget.preffixWidget,
      filled: true,
      fillColor: const Color(0xffF9F9FA),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(
          color: Color(0xffF9F9FA),
        ),
      ),
    );
  }


}

class NairaWidget extends StatelessWidget {
  const NairaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('₦', style: TextStyle(color: Colors.white , fontSize: 20));
  }
}

class ModeSelectionNairaWidget extends StatelessWidget {
  const ModeSelectionNairaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
         builder: (_, state, __) =>  Text(
      '₦',
      style:TextStyle(color: !state.isDarkMode ? Colors.white : Colors.black  ),
    ));
  }
}
