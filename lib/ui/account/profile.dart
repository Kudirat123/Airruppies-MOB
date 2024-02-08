import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/account/my_account/my_account.dart';
import 'package:airruppies/ui/account/settings/settings.dart';
import 'package:airruppies/ui/account/social_media.dart';
import 'package:airruppies/ui/account/update_profile_picture/update_picture_page.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/invitations/invitation.dart';
import 'package:airruppies/ui/invitations/myBonus.dart';
import 'package:airruppies/ui/upgarde_account/teir2/teir2_proof.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:airruppies/utils/tools.dart' as tools;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Map<String, dynamic>? userData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    isLoading = true;
    userData = Provider.of<AccountState>(context, listen: false).userDetails;
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  pageNumber: 0,
                )));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<ThemeProvider>(
        builder: (_, bar, __) => Scaffold(
          //  backgroundColo
          //
          //r: themes().primaryColor,
          body: SafeArea(
            child: Container(
              color: bar.isDarkMode ? themes().primaryColor : Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            //   height: 900,
                            decoration: BoxDecoration(
                                color: !bar.isDarkMode
                                    ? const Color(0xff1F1723)
                                    : themes().whiteColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svgs/profile_svgs/Coin.svg'),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            userData!['earned_referral_bonus'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      // SvgPicture.asset(
                                      //     'assets/svgs/profile_svgs/Badge.svg')
                                      accountTierWidget(
                                          userData!['account_level'])
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        builder: (context) {
                                          return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:
                                                  const ChangeProfilePicture());
                                        },
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              themes().primaryColor,
                                          radius: 40,
                                          backgroundImage: NetworkImage(userData?[
                                                  'image'] ??
                                              'crfr'), // Replace with your image URL
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: themes().primaryColor,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3),
                                                shape: BoxShape.circle),
                                            child: const Padding(
                                              padding: EdgeInsets.all(6.0),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${userData!['firstname']}  ${userData!['lastname']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Account No :  ${userData?['virtual_account'].toString() == 'null' ? 'Contact our help desk ' : userData?['virtual_account']['account_number']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyAccountWidget()));
                                    },
                                    child: const ProfileCard(
                                      text: 'View Profile',
                                      imageText:
                                          'assets/svgs/profile_svgs/profile_tile/people.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Teir2ProofPage()));
                                    },
                                    child: const ProfileCard(
                                      text: 'Upgrade Wallet',
                                      imageText:
                                          'assets/svgs/profile_svgs/profile_tile/Hash.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InvitationWidget()));
                                    },
                                    child: const ProfileCard(
                                      text: 'Refer a friend',
                                      imageText:
                                          'assets/svgs/profile_svgs/profile_tile/card.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ProfileCard(
                                    text: 'Support',
                                    imageText:
                                        'assets/svgs/profile_svgs/profile_tile/card.svg',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyBonusWidget()));
                                    },
                                    child: const ProfileCard(
                                      text: 'My Bonus',
                                      imageText:
                                          'assets/svgs/profile_svgs/profile_tile/reward 1.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingsWidget()));
                                    },
                                    child: const ProfileCard(
                                      text: 'Setting',
                                      imageText:
                                          'assets/svgs/profile_svgs/profile_tile/Vector.svg',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  const SizedBox(
                                      height: 50, child: SocialMediaWidget()),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await tools.removeFromStore(
                                          'fingerPrintLoginValue');

                                      await tools.removeFromStore('username');
                                      await tools.removeFromStore('password');

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginWidget()));
                                    },
                                    child: Text(
                                      'Logout',
                                      style: TextStyles()
                                          .blackTextStyle()
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container accountTierWidget(String text) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(33, 255, 188, 31),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyles()
                  .blackTextStyle400()
                  .copyWith(color: const Color(0xfff6a609), fontSize: 12),
            ),
            Icon(
              MdiIcons.sealVariant,
              color: const Color(0xffFFBC1F),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key, this.text, this.imageText});
  final String? text;
  final String? imageText;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      child: Consumer<ThemeProvider>(
        builder: (_, state, __) => Scaffold(
          backgroundColor:
              !state.isDarkMode ? const Color(0xff1F1723) : themes().whiteColor,
          body: Container(
            height: 67,
            decoration: BoxDecoration(
                color: !state.isDarkMode
                    ? const Color(0xff323045)
                    : const Color(0xffF7EDFC),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            !state.isDarkMode ? Colors.black : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            widget.imageText.toString(),
                            color:
                                state.isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        widget.text.toString(),
                        style: TextStyles().blackTextStyle().copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
