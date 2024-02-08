import 'package:airruppies/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBars {
  AppBar myWhiteAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Container(),
      // leading: Row(
      //   children: [
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     CircularButton(
      //         Icon(
      //           Icons.arrow_back,
      //           color: FlutterFlowTheme.of(context).primaryColor,
      //         ),
      //         context),,
      //   ],
      // ),
      title: Text(title,
          style: Theme.of(context).textTheme.displaySmall!
              .copyWith(fontWeight: FontWeight.w800, fontSize: 20)),
      centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  AppBar myPurpleAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: themes().primaryColor,
      elevation: 0,
      // leading: Row(
      //   children: [
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     CircularButton(
      //         Icon(
      //           Icons.arrow_back,
      //           color: FlutterFlowTheme.of(context).primaryColor,
      //         ),
      //         context),,
      //   ],
      // ),
      title: Text(title,
          style: TextStyles()
              .whiteTextStyle(context)
              .copyWith(fontWeight: FontWeight.w800, fontSize: 20)),
      centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  AppBar whiteAppBarWithBackButton(String title, BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.grey ,
            
            ),
          ),
        ],
      ),
      title: Text(title,
          style: Theme.of(context).textTheme.displaySmall!
              .copyWith(fontWeight: FontWeight.w800, fontSize: 20)),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  AppBar backButton(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
               color: Colors.grey ,
             
            ),
          ),
        ],
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
