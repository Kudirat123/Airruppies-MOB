import 'package:airruppies/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BottomPopUpModal {
  void bottomPopup(context, dynamic widget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      barrierColor: const Color.fromARGB(100, 12, 33, 115),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<ThemeProvider>(
          builder: (_, state, __) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                //color: !state.isDarkMode ? Color(0xff323045):   Colors.white,
                color: !state.isDarkMode ? Colors.black : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: widget,
              )),
        );
      },
    );
  }

  Future<void> copyToClipboard(String text, context) async {
    await Clipboard.setData(ClipboardData(text: text));
    bottomPopup(
        context,
        Text(
          'Copied to ClipBoard',
          style: Theme.of(context).textTheme.displaySmall!,
        ));
  }

  void filterBottomModel(context, dynamic widget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      barrierColor: const Color.fromARGB(100, 12, 33, 115),
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}
