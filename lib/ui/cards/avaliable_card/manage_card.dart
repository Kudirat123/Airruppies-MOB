import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/cards/avaliable_card/manage_card2.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageCardWidget extends StatefulWidget {
  const ManageCardWidget({super.key});

  @override
  State<ManageCardWidget> createState() => _ManageCardWidgetState();
}

class _ManageCardWidgetState extends State<ManageCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton('Card', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                BottomPopUpModal().bottomPopup(
                  context,
                  SizedBox(height: 300, child: CardInfoWidget()),
                );
              },
              child: Text(
                'Show more details',
                style: TextStyles()
                    .purpleTextStyle()
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageCard2Widget()));
              },
              child: const ReusablePirpleCard(
                firstText: 'Manage Card',
                secondText: 'vrgrgrg',
                icon: Icons.ac_unit_rounded,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardInfoWidget extends StatelessWidget {
  CardInfoWidget({super.key});
  final List<String> intrestList = [
    'Card Number',
    'Expiry Date',
    'CVV',
    'Account number',
  ];

  final List<String> percentageList = [
    '5607 7434 3455 4578',
    '04/34',
    '567',
    '53184555665',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interest Rate',
                style: TextStyles()
                    .blackTextStyle()
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              Icon(MdiIcons.close)
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        intrestList[index],
                        style: TextStyles()
                            .blackTextStyle()
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        percentageList[index],
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 28,
                );
              },
              itemCount: intrestList.length),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              BottomPopUpModal().bottomPopup(
                context,
                SizedBox(height: 300, child: CardInfoWidget()),
              );
            },
            child: Text(
              'View Card Pin',
              style: TextStyles()
                  .purpleTextStyle()
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}

class ReusablePirpleCard extends StatelessWidget {
  const ReusablePirpleCard({
    super.key,
    required this.icon,
    required this.firstText,
    required this.secondText,
  });

  final IconData icon;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF7EDFC),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: const Color(0xff551B73),
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
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    secondText,
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 10, fontWeight: FontWeight.w400),
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
