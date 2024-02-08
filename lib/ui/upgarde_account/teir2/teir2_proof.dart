import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/upgarde_account/teir2/id_type_component.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Teir2ProofPage extends StatefulWidget {
  const Teir2ProofPage({super.key});

  @override
  State<Teir2ProofPage> createState() => _Teir2ProofPageState();
}

class _Teir2ProofPageState extends State<Teir2ProofPage> {
  List<Option> options = [
    Option(title: 'NATIONAL IDENTITY NUMBER', value: 0),
    Option(title: 'INTERNATIONAL PASSPORT', value: 1),
    Option(title: 'DRIVER\'S LICENSE', value: 2),
  ];

  int selectedOption = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().backButton(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upgrade To Tier 2',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 7),
                    Text('Select Identity Type',
                        style: TextStyles().greyTextStyle().copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 40),
                    Text('Method of verification',
                        style: TextStyles().greyTextStyle().copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          BottomPopUpModal().bottomPopup(
                              context,
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  child: const IdTypeComponent()));
                        },
                        child: proofItem('Identity Card', 'Issued in Nigeria')),
                    // Column(
                    //   children: options.map((option) {
                    //     return RadioListTile<int>(
                    //       title: Text(
                    //         option.title,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .displaySmall!
                    //             .copyWith(fontSize: 14),
                    //       ),
                    //       value: option.value,
                    //       groupValue: selectedOption,
                    //       activeColor: themes().primaryColor,
                    //       onChanged: (int? value) {
                    //         setState(() {
                    //           selectedOption = value!;
                    //         });
                    //       },
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
              // MyButton(
              //   text: 'Continue',
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Teir2Media( option:    options[   selectedOption])));
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget proofItem(String firstString, String secondString) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: !state.isDarkMode
                ? const Color(0xff1F1723)
                : const Color(0xffF9F9FA)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: SvgPicture.asset(!state.isDarkMode
                        ? 'assets/svgs/Icon Verification Method (1).svg'
                        : 'assets/svgs/Icon Verification Method.svg'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstString,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        secondString,
                        style: TextStyles().greyTextStyle().copyWith(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Option {
  Option({required this.title, required this.value});
  final String title;
  final int value;
}
