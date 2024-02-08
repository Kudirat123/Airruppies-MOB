import 'dart:async';

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/ui/onboarding/onboarding.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  var newUser = true;
  Position? location;

  var deviceId;

  @override
  void initState() {
    super.initState();
    getUserLocationAndDeviceId(context);
    isNewUser();

    Timer(const Duration(seconds: 3), () {
      // ignore: avoid_print
      print('yes');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                newUser ? const OnboardingScreen() : const LoginWidget()),
      );
    });
  }

  //get user location
  getUserLocationAndDeviceId(context) async {
    Provider.of<ThemeProvider>(context, listen: false)
        .toggleTheme(await tools.getFromStore('DarkMode') ?? false);

    location = await tools.getUserLocation();
    // ignore: avoid_print
    print(location);
    deviceId = await tools.getId();
    // ignore: avoid_print
    print(deviceId);
    tools.putInStore('deviceId', deviceId);
    tools.putInStore(
        'location', '${location!.longitude},${location!.latitude}');
  }

  // void passData() {
  //   var data =
  //       Provider.of<AuthState>(context, listen: false).getDeviceIdandLocation();
  // }

  isNewUser() async {
    setState(() async {
      newUser = await tools.getFromStore('newUser');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/Union.svg',
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Air Ruppies',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans().copyWith(
                              color: Colors.white,
                              fontSize: 44,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Text(
                      'Making payment an attitude',
                      style: TextStyles().whiteTextStyle(context).copyWith(
                          fontSize: 13, color: const Color(0xffDCDBE0)),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text('Air Ruppies is a financial platform to',
                      textAlign: TextAlign.center,
                      style: TextStyles().whiteTextStyle(context).copyWith(
                          fontSize: 13, color: const Color(0xffDCDBE0))),
                  Text('manage your business and money.  ',
                      textAlign: TextAlign.center,
                      style: TextStyles().whiteTextStyle(context).copyWith(
                          fontSize: 13, color: const Color(0xffDCDBE0))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
