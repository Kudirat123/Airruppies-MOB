import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/invitations/myBonus.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/modal/bottom_popup_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class InvitationWidget extends StatefulWidget {
  const InvitationWidget({super.key});

  @override
  State<InvitationWidget> createState() => _InvitationWidgetState();
}

class _InvitationWidgetState extends State<InvitationWidget> {
  bool isLoading = false;

  Map<String, dynamic>? invitationData;

  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    isLoading = true;
    invitationData =
        Provider.of<AccountState>(context, listen: false).invitationDetails;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBars().whiteAppBarWithBackButton('Invitation', context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                  'assets/svgs/invitation_svgs/undraw_subscriber_vabu.svg'),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text('Invite Friends & Make extra Cash',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w800, fontSize: 23)),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                  'Copy your referral link below, share it with your friends and make 100NGN on each referral.',
                  textAlign: TextAlign.center,
                  style: TextStyles()
                      .greyTextStyle()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: !state.isDarkMode
                        ? const Color(0xff1F1723)
                        : const Color(0xffF5F7FB),
                    borderRadius: BorderRadius.circular(6)),
                height: 82,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${invitationData?['referral_id']}',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w400, fontSize: 30),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          BottomPopUpModal().copyToClipboard(
                              '${invitationData?['referral_id']}', context);
                        },
                        child: Icon(
                          MdiIcons.clipboardMultipleOutline,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  text: 'Invite Friends',
                  onPressed: () {
                    Share.share(
                        "Join Air Ruppies, the hottest fintech app in town! 🚀 Use code ${invitationData?['referral_id']} to get started and experience seamless financial freedom. 💸 #Air Ruppies #FintechRevolution");
                  }),
              const SizedBox(
                height: 16,
              ),
              SecondaryButton(
                text: 'View your Referral Earnings',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBonusWidget()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
