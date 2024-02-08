import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/send_money_state/send_money_state.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InviteContactSync2Widget extends StatefulWidget {
  // final List<Contact>? nonAirruppies;
  const InviteContactSync2Widget({
    super.key,
  });

  @override
  State<InviteContactSync2Widget> createState() =>
      _InviteContactSync2WidgetState();
}

class _InviteContactSync2WidgetState extends State<InviteContactSync2Widget> {
  String? number;

  bool? loading = true;

  @override
  void initState() {
    getListFromState();
    super.initState();
  }

  Future<void> getListFromState() async {
    setState(() {
      loading = true;
    });
    contactList = Provider.of<BankState>(context, listen: false).contactList;
    // ignore: avoid_print
    print(contactList);

    setState(() {
      loading = false;
    });
  }

  List<Contact>? contactList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('Local contact', context),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                            child:
                                SecondaryButton(text: 'AirRuppies Contacts')),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: MyButton(text: 'invite contact'))
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    OutlineInput(
                      labelText: 'Search',
                      preffixWidget: Icon(MdiIcons.magnify),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      children: [],
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contactList!.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: themes().primaryColor,
                                    child: Text(
                                        contactList![index].phones!.isEmpty
                                            ? ''
                                            : contactList![index]
                                                .displayName
                                                .toString()[0]
                                                .toString()),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contactList![index]
                                                    .displayName
                                                    .toString() ==
                                                'null'
                                            ? ''
                                            : contactList![index]
                                                .displayName
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        contactList![index].phones!.isEmpty
                                            ? ''
                                            : contactList![index]
                                                    .phones?[0]
                                                    .value
                                                    .toString() ??
                                                '',
                                        style: TextStyles()
                                            .greyTextStyle()
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: 35,
                                  width: 80,
                                  child: SecondaryButton(
                                    text: 'invite',
                                    onPressed: () {
                                      // ignore: avoid_print
                                      print(contactList![index]
                                          .phones?[0]
                                          .value
                                          .toString());
                                      launchUrl(smsLaunchUri(contactList![index]
                                          .phones?[0]
                                          .value
                                          .toString()));
                                    },
                                  ))
                            ],
                          );
                        })
                  ],
                ),
              ),
            ),
    );
  }

  Uri smsLaunchUri(String? userNumber) {
    return Uri(
      scheme: 'sms',
      path: userNumber,
      queryParameters: <String, String>{
        'body': Uri.decodeQueryComponent('join Airruppies '),
      },
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.image, required this.text});
  final Widget image;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const SizedBox(height: 8.0),
        text,
      ],
    );
  }
}
