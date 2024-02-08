import 'dart:io';

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/account_service.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeProfilePicture extends StatefulWidget {
  const ChangeProfilePicture({super.key});

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  final picker = ImagePicker();
  File? _pickedImage;

  Future _pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  Future<void> selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    // ignore: avoid_print
    print('Image List Length:${imageFileList!.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().whiteColor,
      //appBar: AppBars().whiteAppBarWithBackButton('Photo', context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: _pickedImage != null
                    ? Image.file(
                        _pickedImage!,
                        height: 70,
                        width: 70,
                      )
                    : null),
            const SizedBox(
              height: 40,
            ),
            BorderButton(
              text: 'Choose from photo',
              onPressed: () {
                //_pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SecondaryButton(
              text: 'Take a Photo',
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              text: 'Submit',
              onPressed: () async {
                Loaders().showModalLoading(context);

                var userDetails =
                    Provider.of<AccountState>(context, listen: false)
                        .userDetails;

                var data = await SettingsService().uploadDocumnet(
                    _pickedImage!.path.toString(),
                    context,
                    'profile Image',
                    'profile image');

                var body = {
                  'image': data['data']['url'],
                  'firstname': userDetails!['firstname'],
                  'lastname': userDetails['lastname'],
                  'middlename': userDetails['middlename'],
                  'sex': userDetails['sex'] ?? 'null',
                  // Address details
                  'country': 'Nigeria',
                  'state': userDetails['address']['state'],
                  'lga': userDetails['address']['lga'],
                  'address': userDetails['address']['address'],
                  // contact info
                  'phone': userDetails['phone'],
                  'username': userDetails['username'],
                  'email': userDetails['email'],
                };
                Navigator.pop(context);
                AccountSerice().updateProfile(context, body);

                // print(data);
              },
            )
          ],
        ),
      ),
    );
  }
}
