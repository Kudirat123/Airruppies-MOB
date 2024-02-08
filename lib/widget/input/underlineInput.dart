import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InlineInput extends StatefulWidget {
  InlineInput(
      {Key? key,
      this.controller,
      this.label,
      this.suffixWidget,
      this.preffixWidget,
      this.textAlignment,
      this.validator,
      this.readonly,
      this.onTap})
      : super(key: key);
  String? label;
  TextEditingController? controller;
  Widget? suffixWidget;
  Widget? preffixWidget;
  TextAlign? textAlignment;
   var  readonly  ;
  final String? Function(String value)? validator;
  dynamic onTap;

  @override
  State<InlineInput> createState() => _InlineInputState();
}

class _InlineInputState extends State<InlineInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly:  widget.readonly ?? false,

      obscureText: false,
      textAlign: widget.textAlignment ?? TextAlign.left,
      onTap: widget.onTap,
      //  validator: widget.validator != null
      //     ? (value) => widget.validator!(value!)
      //     :   tools.Validators.isNotEmpty,

      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        labelText: widget.label,
        labelStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xff94A3B8)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff16790D),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        suffixIcon: widget.suffixWidget,
       prefixIcon: widget.preffixWidget,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
      //   style: FlutterFlowTheme.of(context).bodyText1,
    );
  }
}

class UnEditableInlineInput extends StatefulWidget {
  UnEditableInlineInput(
      {Key? key,
      this.controller,
      this.label,
      this.suffixWidget,
      this.onTap,
      this.validator})
      : super(key: key);
  String? label;
  TextEditingController? controller;
  Widget? suffixWidget;
  dynamic onTap;
  final String? Function(String value)? validator;

  @override
  State<UnEditableInlineInput> createState() => _UnEditableInlineInputState();
}

class _UnEditableInlineInputState extends State<UnEditableInlineInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: true,
      obscureText: false,
      validator: widget.validator != null
          ? (String? value) => widget.validator!(value!)
          : null,

      onTap: widget.onTap,
      readOnly: true,

      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(31, 147, 163, 185),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94A3B8),
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        labelText: widget.label,
        labelStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xff94A3B8)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff16790D),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        suffixIcon: widget.suffixWidget,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
      //   style: FlutterFlowTheme.of(context).bodyText1,
    );
  }
}
