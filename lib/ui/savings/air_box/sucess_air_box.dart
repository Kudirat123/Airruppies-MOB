import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessAirBox extends StatefulWidget {
  const  SuccessAirBox({super.key, this.data});
  final dynamic data;

  @override
  State<SuccessAirBox> createState() => _SuccessAirBoxState();
}

class _SuccessAirBoxState extends State<SuccessAirBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding:   const EdgeInsets.all(20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const SizedBox(
                    height: 100,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/savings/savingsPlan/✔️.svg',
                    width: 200,
                  ),
                    const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.data['saving_plan']['title']} Created Successful',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                    const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Has been added to your Finpay Card Balance',
                    textAlign: TextAlign.center,
                    style: TextStyles()
                        .greyTextStyle()
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
                  )
                ],
              ),
            ),
            Padding(
              padding:   const EdgeInsets.symmetric(vertical: 20),
              child: SecondaryButton(
                text: 'View Saving Plan',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>    MyHomePage(pageNumber: 0,)));
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
