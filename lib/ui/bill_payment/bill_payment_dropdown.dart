import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BillPaymentDropDownWidget extends StatefulWidget {
   const BillPaymentDropDownWidget({super.key});

  @override
  State<BillPaymentDropDownWidget> createState() =>
      _BillPaymentDropDownWidgetState();
}

class _BillPaymentDropDownWidgetState extends State<BillPaymentDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
           const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Cable Tv',
                style: TextStyles()
                    .blackTextStyle()
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
              ),
               Icon(MdiIcons.close)
            ],
          ),
           const SizedBox(
            height: 15,
          ),
          OutlineInput(
            labelText: 'Search',
            preffixWidget:  Icon(MdiIcons.magnify),
          ),
           const SizedBox(
            height: 15,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics:  const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int) {
                return Row(
                  children: [
                     const CircleAvatar(
                      radius: 20,
                      child: Text('d'),
                    ),
                     const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          'Alex Armstrong',
                          style: TextStyles().blackTextStyle().copyWith(
                              fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                         const SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Alex Armstrong',
                          style: TextStyles().greyTextStyle().copyWith(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return  const SizedBox(
                  height: 20,
                );
              },
              itemCount: 4)
        ],
      ),
    );
  }
}
