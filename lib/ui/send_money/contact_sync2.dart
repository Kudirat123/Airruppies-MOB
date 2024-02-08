import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/airruppies_to_airruppies/p2p_amount.dart';
import 'package:airruppies/ui/send_money/invite_contact_sync.dart';
import 'package:airruppies/ui/send_money/model/contact_model.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactSync2Widget extends StatefulWidget {
  const ContactSync2Widget({super.key, this.contactList, this.syncedContact});
  final List<Contact>? contactList;
  final List<ContactSyncModel>? syncedContact;

  @override
  State<ContactSync2Widget> createState() => _ContactSync2WidgetState();
}

class _ContactSync2WidgetState extends State<ContactSync2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBars().whiteAppBarWithBackButton('Local contact', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: MyButton(text: 'Air Ruppies Contacts')),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: SecondaryButton(
                    text: 'invite contact',
                    onPressed: () {
                      //  Loaders().showModalLoading(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InviteContactSync2Widget()));
                    },
                  ))
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
              Container(
                child: widget.syncedContact!.isEmpty
                    ? const Text('None of your contact use airrupies')
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.syncedContact!.length,
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
                                    backgroundColor: themes().primaryColor,
                                    radius: 24,
                                    child: Text(widget
                                                .syncedContact![index].name
                                                .toString()
                                                .toLowerCase() !=
                                            'null'
                                        ? widget.syncedContact![index].name[0]
                                        : ''),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.syncedContact![index].name
                                                    .toString() !=
                                                'null'
                                            ? widget.syncedContact![index].name
                                                .toString()
                                            : 'User not saved',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        widget.syncedContact![index].phone
                                            .toString(),
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
                                  child: MyButton(
                                    text: 'Send',
                                    onPressed: () async {
                                      var userDetails = await BankService()
                                          .checkForAirruppiesCustomer(
                                              context,
                                              widget
                                                  .syncedContact![index].phone);
                                      // ignore: avoid_print
                                      print(userDetails);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  P2PTransactionAmountPage(
                                                      data: userDetails['data']
                                                          [0])));
                                    },
                                  ))
                            ],
                          );
                        }),
              )
            ],
          ),
        ),
      ),
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
