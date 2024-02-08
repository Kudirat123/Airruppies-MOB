import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AirRuppiesBeneficiaryWidget extends StatefulWidget {
   const AirRuppiesBeneficiaryWidget({super.key});

  @override
  State<AirRuppiesBeneficiaryWidget> createState() => _AirRuppiesBeneficiaryWidgetState();
}

class _AirRuppiesBeneficiaryWidgetState extends State<AirRuppiesBeneficiaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          children: [
        
            
            OutlineInput(
              labelText: 'Serach',
              preffixWidget:  Icon(MdiIcons.magnify),
            ),
             const SizedBox(
              height: 20,
            ),
             const Row(
              children: [],
            ),
            ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return Container(
                    height: 20,
                  );
                },
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                           const CircleAvatar(
                            radius: 24,
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
                              Text(
                                '3244574701',
                                style: TextStyles().greyTextStyle().copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                      
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
   const GridItem({super.key, required this.image, required this.text});
  final Widget image;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
         const SizedBox(height: 8.0),
        text,
      ],
    );
  }
}
