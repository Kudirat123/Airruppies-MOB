import 'package:airruppies/themes.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutlineInput extends StatefulWidget {
  OutlineInput(
      {Key? key,
      this.controller,
      this.maxLines,
      this.labelText,
      this.validator,
      this.icon,
      this.onChanged,
      this.textCenter,
      this.keyboardType,
      this.onTap,
      this.readOnly,
      this.obscureText,
      this.suffixWidget,
      this.preffixWidget})
      : super(key: key);
  final int? maxLines;
  String? icon;
  String? labelText;
  Widget? preffixWidget;
  TextInputType? keyboardType;
  dynamic onTap;
  bool? obscureText;
  bool? readOnly;
  dynamic onChanged;

  Widget? suffixWidget;
  bool? textCenter;
  // late TextAlign textAlign = TextAlign.left;

  TextEditingController? controller;
  final String? Function(String value)? validator;

  @override
  State<OutlineInput> createState() => _OutlineInputState();
}

class _OutlineInputState extends State<OutlineInput> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => TextFormField(
        controller: widget.controller,
        textAlign:
            widget.textCenter == true ? TextAlign.center : TextAlign.left,
        style: widget.textCenter == null
            ? !state.isDarkMode
                ? TextStyles().whiteTextStyle(context).copyWith(fontSize: 15)
                : TextStyles().blackTextStyle().copyWith(fontSize: 15)
            : !state.isDarkMode
                ? TextStyles()
                    .whiteTextStyle(context)
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w700)
                : TextStyles()
                    .blackTextStyle()
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly ?? false,

        obscureText: widget.obscureText ?? false,
        maxLines: widget.maxLines ?? 1,
        validator: widget.validator != null
            ? (String? value) => widget.validator!(value!)
            : null,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyles().greyTextStyle().copyWith(
                fontSize: 13,
              ),
          prefixIcon: widget.preffixWidget,
          suffixIcon: widget.suffixWidget ??
              SizedBox(
                child: widget.icon == null
                    ? Container(
                        width: 20,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Image.asset(widget.icon.toString()),
                      ),
              ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color:!state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF9F9FA),
            ),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: !state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF9F9FA),
            ),
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: !state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF9F9FA),
            ),
          ),
          //   prefix: widget.preffixWidget,
          filled: true,
          fillColor: !state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF9F9FA),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: !state.isDarkMode ? const Color(0xff1F1723): const Color(0xffF9F9FA),
            ),
          ),
        ),
        //  style: FlutterFlowTheme.of(context).bodyText1,
      ),
    );
  }
}

class BlackOutlineInput extends StatefulWidget {
  BlackOutlineInput(
      {Key? key, this.controller, this.maxLines, this.validator, this.onTap})
      : super(key: key);
  final int? maxLines;
  VoidCallback? onTap;
  TextEditingController? controller;
  final String? Function(String value)? validator;

  @override
  State<BlackOutlineInput> createState() => _BlackOutlineInputState();
}

class _BlackOutlineInputState extends State<BlackOutlineInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: true,
      onTap: widget.onTap,
      obscureText: false,
      maxLines: widget.maxLines,
      validator: widget.validator != null
          ? (String? value) => widget.validator!(value!)
          : null,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xffB5B5B5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xffB5B5B5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xffB5B5B5),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xffB5B5B5),
          ),
        ),
      ),
      //  style: FlutterFlowTheme.of(context).bodyText1,
    );
  }
}
