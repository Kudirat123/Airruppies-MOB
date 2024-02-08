import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/upgarde_account/teir2/teir2_proof.dart';
import 'package:airruppies/ui/upgarde_account/teir2/teir_media.dart';
import 'package:flutter/material.dart';

class IdTypeComponent extends StatefulWidget {
  const IdTypeComponent({super.key});

  @override
  State<IdTypeComponent> createState() => _IdTypeComponentState();
}

class _IdTypeComponentState extends State<IdTypeComponent> {
  @override
  final List<Option> options = [
    Option(title: 'NATIONAL IDENTITY NUMBER', value: 0),
    Option(title: 'INTERNATIONAL PASSPORT', value: 1),
    Option(title: 'DRIVER\'S LICENSE', value: 2),
  ];

  int selectedOption = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: options.map((option) {
          return InkWell(
            onTap: () {},
            child: RadioListTile<int>(
              title: Text(
                option.title,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 14),
              ),
              value: option.value,
              groupValue: selectedOption,
              activeColor: themes().primaryColor,
              onChanged: (int? value) {
                setState(() {
                  selectedOption = value!;
                });

                // ignore: avoid_print
                print('yes');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Teir2Media(option: options[selectedOption])));
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
