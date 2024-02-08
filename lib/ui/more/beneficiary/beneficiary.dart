import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/more/beneficiary/airRuppies_beneficiary.dart';
import 'package:airruppies/ui/more/beneficiary/airtime_beneficiary.dart';
import 'package:airruppies/ui/more/beneficiary/bank_beneficiary.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeneficiaryWidget extends StatefulWidget {
  const BeneficiaryWidget({super.key});

  @override
  State<BeneficiaryWidget> createState() => _BeneficiaryWidgetState();
}

class _BeneficiaryWidgetState extends State<BeneficiaryWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton('Beneficiary', context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //           child: SecondaryButton(
            //         text: 'Crypto',
            //         onPressed: () {},
            //       )),
            //        SizedBox(
            //         width: 20,
            //       ),
            //       Expanded(
            //           child: MyButton(
            //               text: 'Gift Card',
            //               onPressed: () {},
            //               color: themes().primaryColor))
            //     ],
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F7FE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TabBar(
                  // isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: themes().primaryColor,
                  ),
                  labelColor: Colors.white,
                  padding: const EdgeInsets.all(3),
                  labelStyle: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                  unselectedLabelColor: themes().greyText,

                  tabs: const [
                    Tab(text: 'Air Ruppies'),
                    Tab(text: 'Bank'),
                    Tab(text: 'Airtime/Data'),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: _tabController, children: const [
                AirRuppiesBeneficiaryWidget(),
                BankBeneficiaryWidget(),
                AirtimeBeneficiaryWidget()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
