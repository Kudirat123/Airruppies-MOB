import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerClass {
  Future<String?> pickImageFromFiles(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      // User canceled the operation.
      return null;
    }
  }

  Future<String?> pickImageFromCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      // User canceled the operation.
      return null;
    }
  }
}
