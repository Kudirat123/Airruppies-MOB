import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';

class DropdownTextFormField extends StatefulWidget {
  const DropdownTextFormField(
      {Key? key, required this.options, required this.hintText})
      : super(key: key);
  final List<String> options;
  final String hintText;

  @override
  _DropdownTextFormFieldState createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> field) {
        return Container(
          decoration: BoxDecoration(
              color: themes().cardColor,
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedOption,
                    hint: Text(widget.hintText),
                    decoration: InputDecoration(
                      //  labelText: widget.labelText,
                      labelStyle:
                          TextStyles().greyTextStyle().copyWith(fontSize: 13),

                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(88, 118, 125, 255),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(88, 118, 125, 255),
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(88, 118, 125, 255),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(88, 118, 125, 255),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(88, 118, 125, 255),
                        ),
                      ),
                    ),
                    dropdownColor: themes().cardColor,
                    iconEnabledColor: Colors.green,
                    items: widget.options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyles().whiteTextStyle(context),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value;
                      });
                      field.didChange(value);
                    },
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .60,
                    child: OutlineInput()),
              ],
            ),
          ),
        );
      },
    );
  }
}
