import 'package:airruppies/themes.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';

class MessageToast {
  ShowMToast toast = ShowMToast();

  void errorMessage(BuildContext context) {
    toast.errorToast(context,
        message: 'Message not Send',
        image: 'assets/twitter_logo.png',
        backgroundColor: Colors.white,
        alignment: Alignment.topCenter);
  }

  void successMessgae(BuildContext context) {
    toast.successToast(context,
        message: 'Message Sent',
        image: 'assets/twitter_logo.png',
        backgroundColor: Colors.white,
        alignment: Alignment.topCenter,
        duration: 1500,
        width: 10);
  }

  Future dialogMessage(context, String title, String subTitle) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return Center(
          child: Dialog(
              backgroundColor: Colors.transparent, //must have
              elevation: 0,
              child: SizedBox(
                height: size.height * .6,
                child: Stack(
                  children: [
                    Positioned(
                        top: (size.height * .2) / 2,
                        child: Container(
                          height: size.height * .5,
                          width: size.width - 80,
                          decoration: BoxDecoration(
                              color: themes().cardColor,
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * .6,
                              child: Text(title,
                                  textAlign: TextAlign.center,
                                  style: TextStyles()
                                      .whiteTextStyle(context)
                                      .copyWith(fontSize: 14)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(subTitle,
                              textAlign: TextAlign.center,
                              style: TextStyles()
                                  .greyTextStyle()
                                  .copyWith(fontSize: 12)),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: SizedBox(
                            width: 100,
                            child: MyButton(
                              text: 'Okay',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.height * .3,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                        ),
                        child: Center(
                          child: Container(
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                      'assets/phone_assets/illustration base.png',
                                      height: 500,
                                      width: 500),
                                ),
                                Positioned(
                                  bottom: 77,
                                  left: 56,
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/login_assets/robot 3.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Future coinMessage(context, String subTitle, String buttonTitle) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return Center(
          child: Dialog(
              backgroundColor: Colors.transparent, //must have
              elevation: 0,
              child: SizedBox(
                height: size.height * .6,
                child: Stack(
                  children: [
                    Positioned(
                        top: (size.height * .2) / 2,
                        child: Container(
                          height: size.height * .5,
                          width: size.width - 80,
                          decoration: BoxDecoration(
                              color: themes().cardColor,
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(subTitle,
                              textAlign: TextAlign.center,
                              style: TextStyles()
                                  .greyTextStyle()
                                  .copyWith(fontSize: 12)),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: SizedBox(
                            width: 100,
                            child: MyButton(
                              text: buttonTitle ?? 'Okay',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.height * .3,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                    'assets/phone_assets/illustration base.png',
                                    height: 500,
                                    width: 500),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 25,
                                child: SizedBox(
                                  child: Image.asset(
                                    'assets/login_assets/BTC 1.png',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
