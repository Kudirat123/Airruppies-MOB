import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/contact_sync2.dart';
import 'package:airruppies/ui/send_money/model/contact_model.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/ui/send_money/send_money_state/send_money_state.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';

class SyncContact extends StatefulWidget {
  const SyncContact({super.key});

  @override
  State<SyncContact> createState() => _SyncContactState();
}

class _SyncContactState extends State<SyncContact> {
  List<ContactSyncModel>? syncedContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'skip',
                  //       style: TextStyles().blackTextStyle().copyWith(
                  //           fontSize: 12, fontWeight: FontWeight.w500),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(
                    height: 70,
                  ),
                  SvgPicture.asset('assets/svgs/no-records 1.svg'),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Sync your phone contacts',
                    style: TextStyles()
                        .blackTextStyle()
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'See which is also in AirRupples, and send money to them easy and fast',
                    textAlign: TextAlign.center,
                    style: TextStyles()
                        .greyTextStyle()
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              MyButton(
                text: 'Synchronize Now',
                onPressed: () async {
                  Loaders().showModalTextLoading(context, 'Syncing.......');

                  List<Contact> contactList = await getContacts();
                  // // ignore: avoid_print
                //  print(contactList[0].phones![0].value);

                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactSync2Widget(
                              contactList: contactList,
                              syncedContact: syncedContact)));
                  //  _contactsPermissions();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<PermissionStatus> _contactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted ||
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      // ignore: avoid_print
      print(permission);
      return permission;
    }
  }

  Future<List<Contact>> getContacts() async {
    List<Contact>? contacts;
    PermissionStatus contactsPermissionsStatus = await _contactsPermissions();
    if (contactsPermissionsStatus == PermissionStatus.granted) {
      contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
    }
    List<String?>? contatctList = contacts
        ?.map((model) => model.phones!.isEmpty
            ? '08103490675'
            : model.phones![0].value.toString().trim())
        .toList();
    // ignore: avoid_print
    print(contatctList);

    syncedContact = await BankService().sendContact(contatctList, context);

    for (var j = 0; j < syncedContact!.length; j++) {
      contacts = contacts!
          .where((element) => element.phones!.isEmpty
              ? '08011111111' != syncedContact![j].phone
              : element.phones![0].value != syncedContact![j].phone)
          .toList();
      // ignore: avoid_print
      print(contacts);

      Provider.of<BankState>(context, listen: false).contactList = contacts;
    }

    return contacts!;
  }
}
