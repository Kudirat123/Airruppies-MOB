import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Modal {
  void comingSoonToast(String message, context) {
    showTopSnackBar(
        Overlay.of(context!),
        const CustomSnackBar.info  (
          message: 'Coming Soon',
        ));
  }


    void error(String message, context) {
    showTopSnackBar(
        Overlay.of(context!),
        CustomSnackBar.error  (
          message: message,
        ));
  }


     void success(String message, context) {
    showTopSnackBar(
        Overlay.of(context!),
        CustomSnackBar.success  (
          message: message,
        ));
  }
}
