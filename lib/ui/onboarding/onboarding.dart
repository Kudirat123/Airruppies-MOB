import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/ui/authentication/registration/bvn.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final List<String> _slideImages = [
    'assets/svgs/onboarding_svgs/3d-casual-life-open-safe-box-with-piggy-bank 1.png',
    'assets/svgs/onboarding_svgs/3d-casual-life-mobile-banking-cashback 1.jpg',
    'assets/svgs/onboarding_svgs/3d-casual-life-mobile-banking-cashback 1.jpg',
  ];

  final List<String> _slideMainText = [
    'Managing your money is about to get a lot better.',
    'Making Payment an Attitude',
    'Make Air Ruppies transfer Under 30Sec'
  ];

  final List<String> topText = ['Welcome to ', 'Payment', 'Transfer'];
  final List<String> topText2 = ['AirRupples', '', ''];

  @override
  void initState() {
    tools.putInStore('newUser', false);

 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: topText[_currentIndex],
                          style: TextStyles().greyTextStyle()),
                      TextSpan(
                          text: topText2[_currentIndex],
                          style: TextStyles().purpleTextStyle()),
                    ],
                  )),
                  Text('Skip',
                      style: TextStyles()
                          .blackTextStyle()
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w700))
                ],
              ),
              const SizedBox(height: 25.0),
              Text(
                _slideMainText[_currentIndex],
                style: TextStyles()
                    .blackTextStyle()
                    .copyWith(fontWeight: FontWeight.w800, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: CarouselSlider(
                  items: _slideImages.map((imagePath) {
                    return Image.asset(imagePath);
                  }).toList(),
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Lorem ipsum dolor sit amet consectetur. In dis pretium senectus ullamcorper diam ultricies purus.',
                style: TextStyles().greyTextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50.0),
              DotsIndicator(
                dotsCount: _slideImages.length,
                position: _currentIndex.toDouble().toInt(),
                decorator: DotsDecorator(
                  size: const Size.square(8.0),
                  activeSize: const Size(20.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: themes().primaryColor,
                ),
              ),
              const SizedBox(height: 50.0),
              MyButton(
                text: 'Create an account',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BvnWidget()));
                },
              ),
              const SizedBox(height: 20.0),
              SecondaryButton(
                text: 'Login',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWidget()));
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
