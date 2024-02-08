import 'dart:io';

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/settings/settings_service.dart';
import 'package:airruppies/ui/upgarde_account/teir2/teir2_proof.dart';
import 'package:airruppies/utils/loaders.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Teir2Media extends StatefulWidget {
  const Teir2Media({
    super.key,
    this.option,
  });
  final Option? option;
  @override
  _Teir2MediaState createState() => _Teir2MediaState();
}

class _Teir2MediaState extends State<Teir2Media> {
  final picker = ImagePicker();
  File? _pickedImage;

  Future _pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _pickedImage = File(pickedImage.path);
        imageFileList!.add(XFile(_pickedImage!.path));
      }
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  late List<String> imageResponseList = [];

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
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Photo ID Card',
                      style: TextStyles().whiteTextStyle(context).copyWith(
                          fontWeight: FontWeight.w800, fontSize: 23),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Position all 4 corners of the page clearly and upload both the front page and the back page',
                      style: TextStyles().whiteTextStyle(context).copyWith(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            itemCount: imageFileList!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(imageFileList![index].path),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 264,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => selectImages(),
                          child: SvgPicture.asset(
                              'assets/svgs/upgrade_account/Gallery.svg')),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () => _pickImage(ImageSource.camera),
                          child: SvgPicture.asset(
                              'assets/svgs/upgrade_account/Photo.svg')),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 40,
                        width: 40,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                    child: MyButton(
                      text: 'Submit',
                      onPressed: () async {
                        Loaders().showModalLoading(context);
                        for (XFile imageFile in imageFileList!) {
                          var imageResult = await SettingsService()
                              .uploadDocumnet(
                                  imageFile.path,
                                  context,
                                  widget.option.toString(),
                                  widget.option.toString());

                          String imageString =
                              imageResult['data']['id'].toString();
                          // ignore: avoid_print
                          print(imageString);

                          imageResponseList.add(imageString);
                          // ignore: avoid_print
                          print(imageResponseList);
                        }
                        Navigator.pop(context);
                        var body = {
                          'type': widget.option.toString(),
                          'url': imageResponseList
                        };

                        SettingsService().upgradeAccount(context, body);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
