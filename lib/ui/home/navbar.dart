import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/profile.dart';

import 'package:airruppies/ui/cards/first_cards.dart';
import 'package:airruppies/ui/home/dashbaord.dart';
import 'package:airruppies/ui/savings/savings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.pageNumber})
      : super(
          key: key,
        );
  int? pageNumber;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    widget.pageNumber = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the back button is pressed within 2 seconds of the last press
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                const Duration(seconds: 3)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Press back again to exit the app')),
          );
          return false; // Prevent exiting the app on the first back press
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
        return true; // Exit the app on the second back press
      },
      child: CurvedNavBar(
        actionButton: CurvedActionBar(
            onTab: (value) {
              // ignore_for_file: avoid_print
              print(value);
            },
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: themes().primaryColor, shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/svgs/Union.svg')),
            ),
            inActiveIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: themes().primaryColor, shape: BoxShape.circle),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/svgs/Union.svg')),
            ),
            text: ''),
        activeColor: const Color(0XFF551B73),
        navBarBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        inActiveColor: const Color(0XFF52525C),
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.home,
                color: Color(0XFF551B73),
              ),
              inActiveIcon: const Icon(
                Icons.home,
                color: Color(0xff52525C),
              ),
              text: 'Home'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                MdiIcons.piggyBank,
                color: const Color(0XFF551B73),
              ),
              inActiveIcon: Icon(
                MdiIcons.piggyBank,
                color: const Color(0xff52525C),
              ),
              text: 'Saving'),
          FABBottomAppBarItem(
              activeIcon: const Icon(
                Icons.wallet,
                color: Color(0XFF551B73),
              ),
              inActiveIcon: const Icon(
                Icons.wallet,
                color: Color(0xff52525C),
              ),
              text: 'Cards'),
          FABBottomAppBarItem(
              activeIcon: Icon(
                MdiIcons.account,
                color: const Color(0XFF551B73),
              ),
              inActiveIcon: Icon(
                MdiIcons.account,
                color: const Color(0xff52525C),
              ),
              text: 'Account'),
        ],
        bodyItems: const [
          HomeDashboard(),
          Savings(),
          FirstCardWidget(),
          ProfileWidget()
        ],
        // actionBarView: Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.orange,
        // ),
      ),
    );
  }
}
