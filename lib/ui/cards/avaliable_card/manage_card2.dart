import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/send_money.dart';
import 'package:airruppies/ui/send_money/via_bluetooth/bluetooth_send_money.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageCard2Widget extends StatefulWidget {
   const ManageCard2Widget({super.key});

  @override
  State<ManageCard2Widget> createState() => _ManageCard2WidgetState();
}

class _ManageCard2WidgetState extends State<ManageCard2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton ('Manage Card', context),
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const SendMoneyWidget()));
              },
              child: sendMoney(MdiIcons.pound, 'Mange pin',
                  'Lorem ipsum dolor sit amet'),
            ),
             const SizedBox(
              height: 12,
            ),
            InkWell( 
                 onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const BluetoothSendMoneyWidget()));
              },
              child: sendMoney(MdiIcons.wallet, 'Block Card',
                  'Lorem ipsum dolor sit amet'),
            )
          ],
        ),
      ),
    );
  }

  Widget sendMoney(IconData icon, String firstText, String secondText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:  const Color(0xffF7EDFC),
      ),
      child: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              decoration:  const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding:  const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color:  const Color(0xff551B73),
                  size: 19,
                ),
              ),
            ),
             const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstText,
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
                  ),
                   const SizedBox(
                    height: 7,
                  ),
                  Text(
                    secondText,
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
             const Icon(Icons.arrow_forward_ios, size: 13)
          ],
        ),
      ),
    );
  }
}
