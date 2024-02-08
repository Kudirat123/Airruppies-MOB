import 'package:airruppies/themes.dart';
import 'package:flutter/material.dart';

class Loaders {
  void showModalLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //CircularProgressIndicator(strokeWidth: 1,),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: themes().primaryColor,
                    )),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5))),
          // child: Container(
          //   width: 120,
          //   height: 120,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       CircularProgressIndicator(
          //         strokeWidth: 2.5,
          //       ),
          //       Text("Loading"),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }

  void showModalTextLoading(BuildContext context , String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //CircularProgressIndicator(strokeWidth: 1,),

                Text(text , style: TextStyles().whiteTextStyle(context),),
                const SizedBox(height: 20,),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: themes().primaryColor,
                    )),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5))),
          // child: Container(
          //   width: 120,
          //   height: 120,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       CircularProgressIndicator(
          //         strokeWidth: 2.5,
          //       ),
          //       Text("Loading"),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }



}
