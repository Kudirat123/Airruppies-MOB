import 'package:airruppies/themes.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialMediaWidget extends StatefulWidget {
  const SocialMediaWidget({super.key});

  @override
  State<SocialMediaWidget> createState() => _SocialMediaWidgetState();
}

class _SocialMediaWidgetState extends State<SocialMediaWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> socialMediaIcons = [
      'assets/svgs/profile_svgs/Vector (8).svg',
      'assets/svgs/profile_svgs/Vector (9).svg',
      'assets/svgs/profile_svgs/Group (10).svg',
      'assets/svgs/profile_svgs/Group (11).svg'
    ];
    return Consumer<ThemeProvider>(
      builder: (_, state, __) =>Scaffold(
        backgroundColor: !state.isDarkMode ? const Color(0xff1F1723) : themes().whiteColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  socialMediaIcons.length,
                  (index) => Container(
                      decoration: BoxDecoration(
                        color: !state.isDarkMode
                            ? Colors.black
                            : const Color(0xffF7EDFC),
    
    
                            borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(socialMediaIcons[index]),
                      ))),
            ),
          )),
    );
  }
}
