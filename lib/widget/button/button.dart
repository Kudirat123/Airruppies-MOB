import 'package:airruppies/themes.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyButton extends StatelessWidget {
   const MyButton({Key? key, required this.text, this.onPressed, this.height})
      : super(key: key);
  final String text;

  final int? height;

 final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: themes().primaryColor,
            borderRadius: BorderRadius.circular(12)),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          text,
          style: TextStyles().DefaultText(14, FontWeight.w400, Colors.white),
        )),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
 const  IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(final BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: TextStyles()
                        .DefaultText(14, FontWeight.w600, Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

class SecondaryButton extends StatefulWidget {
const   SecondaryButton({Key? key, required this.text, this.onPressed, this.height})
      : super(key: key);
 final  String text;

 final  int? height;

 final  dynamic  onPressed;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => InkWell(
        onTap: widget.onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
              color: !state.isDarkMode ? const Color(0xff1F1723):  const Color(0xffF7EDFC),
              borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Text(
            widget.text,
            style: state.isDarkMode ?  TextStyles()
                .DefaultText(14, FontWeight.w400, themes().primaryColor)  :  TextStyles()
                .greyTextStyle(),
          )),
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  BorderButton({Key? key, required this.text, this.onPressed, this.height})
      : super(key: key);
  String text;

  int? height;

  var onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
       builder: (_, state, __) =>  InkWell(
        onTap: onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
              border: Border.all(color: themes().iconColor),
              borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Text(
            text,
            style: !state.isDarkMode ? Theme.of(context).textTheme.displaySmall!:
            
             TextStyles()
                .DefaultText(16, FontWeight.w700, themes().blackColor),
          )),
        ),
      ),
    );
  }
}

class NoColorButton extends StatelessWidget {
  NoColorButton(
      {Key? key, required this.text, this.onPressed, this.height, this.color , this.textColor})
      : super(key: key);
  String text;
  Color? color;
  Color? textColor;

  int? height;

  var onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          text,
          style: TextStyles()
              .DefaultText(14, FontWeight.w400, textColor!),
        )),
      ),
    );
  }
}
