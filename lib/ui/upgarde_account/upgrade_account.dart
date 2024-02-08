import 'dart:io';

import 'package:airruppies/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photo ID Card',
                        style: TextStyles().whiteTextStyle(context).copyWith(
                            fontWeight: FontWeight.w800, fontSize: 23),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Position all 4 corners of the page clearly',
                        style: TextStyles().whiteTextStyle(context).copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      // SizedBox(
                      //   height: 40,
                      // ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              itemCount: imageFileList!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
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
            ),
            Container(
              height: 194,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
