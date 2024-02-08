import 'package:airruppies/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyboardKey extends StatefulWidget {
  const KeyboardKey({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
  }) : super(key: key);
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  dynamic renderLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }

    return Text(widget.label,
        style: GoogleFonts.manrope(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: themes().whiteColor));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .12,
        width: 20,
        child: Center(
          child: renderLabel(),
        ),
      ),
    );
  }
}
