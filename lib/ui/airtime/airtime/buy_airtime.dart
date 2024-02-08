import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/airtime/airtime/airtime2.dart';
import 'package:airruppies/ui/data/buy_data.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';

class BuyAirtimeWidget extends StatefulWidget {
  const BuyAirtimeWidget({super.key});

  @override
  State<BuyAirtimeWidget> createState() => _BuyAirtimeWidgetState();
}

class _BuyAirtimeWidgetState extends State<BuyAirtimeWidget> {
  TextEditingController? phoneNumber;

  @override
  void initState() {
    phoneNumber = TextEditingController();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton ('Buy Data/Airtime', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: MyButton(text: 'Airtime')),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: SecondaryButton(
                  text: 'Data',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Data2Widget()));
                  },
                ))
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            OutlineInput(
              labelText: 'Enter Number',
              controller: phoneNumber,
              suffixWidget: const Icon(Icons.person_outlined),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(text: 'Continue', onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  Airtime2Widget(amount :phoneNumber!.text )));


            },),


            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Contact',
                  style: Theme.of(context).textTheme.displaySmall!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                ),
                Text('See All',
                    style: TextStyles().blackTextStyle().copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: themes().primaryColor))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [],
            ),
            // GridView.count(
            //   shrinkWrap: true,
            //   //  crossAxisSpacing: 3.0,
            //   mainAxisSpacing: 19.0,
            //   crossAxisCount: 4, // Number of items in each row
            //   children: List.generate(8, (index) {
            //     return InkWell(
            //       onTap: () {
            //         // Navigator.push(
            //         //     context,
            //         //     MaterialPageRoute(
            //         //         builder: (context) => const Airtime2Widget()));
            //       },
            //       child: GridItem(
            //         image: CircleAvatar(
            //           radius: 27,
            //           child: Text((index + 1).toString()),
            //         ),
            //         text: Text(
            //           'Item ${index + 1}',
            //           style:
            //               TextStyles().blackTextStyle().copyWith(fontSize: 11),
            //         ),
            //       ),
            //     );
            //   }),
            // ),
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
