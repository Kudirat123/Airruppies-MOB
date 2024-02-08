import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/registration_service.dart';
import 'package:airruppies/ui/authentication/login.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BvnWidget extends StatefulWidget {
   const BvnWidget({Key? key}) : super(key: key);

  @override
  State<BvnWidget> createState() => _BvnWidgetState();
}

class _BvnWidgetState extends State<BvnWidget> {
  TextEditingController? bvnController;



  @override
  void initState() {
    bvnController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes().whiteColor,
      appBar: AppBars().backButton(context),
      body: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(
                      height: 40,
                    ),
                    Text('Get Started',
                        style: TextStyles()
                            .blackTextStyle()
                            .copyWith(fontWeight: FontWeight.w900 , fontSize: 24)),
                     const SizedBox(
                      height: 8,
                    ),
                    Text('Create an account to continue!',
                        textAlign: TextAlign.center,
                        style: TextStyles().greyTextStyle()),
                     const SizedBox(
                      height: 48,
                    ),
                    OutlineInput(
                      controller: bvnController,
                      labelText: 'BVN',
                      preffixWidget:  Icon(MdiIcons.shieldAlert),
                    ),
                     const SizedBox(
                      height: 70,
                    ),
                    MyButton(
                        text: 'Submit',
                        onPressed: () {
                          // setState(() {
                          //   widget.data['token'] = currentText.toString();
                          // });
                          RegistrationSerice()
                              .submitBvn(context, {'bvn': bvnController?.text});
                        }),
                     const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(

                          onTap: (){
                            Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 const LoginWidget()));


                          },
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Already have an account? ',
                                      style: TextStyles().greyTextStyle()),
                                  TextSpan(
                                      text: ' Login',
                                      style: TextStyles().purpleTextStyle()),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('licenseced by CBN AS A MMO',
                        style: TextStyles()
                            .blackTextStyle()
                            .copyWith(fontSize: 11)),
                    Text('licenseced by CBN AS A MMO',
                        style: TextStyles()
                            .blackTextStyle()
                            .copyWith(fontSize: 11)),
                  ],
                )
              ],
            )),
      ),
    );
  }

  // _signUp() {
  //   var formKey;

  //   // if (textController1.text.isEmpty) {
  //   //   setState(() {
  //   //     Navigator.push(
  //   //         context, MaterialPageRoute(builder: (context) => HomeNavBar()));
  //   //   });
  //   // } else {
  //   //Navigator.push(context,
  //   //    MaterialPageRoute(builder: (context) => LoadingListPage()));
  //   //
  //   var body = {
  //     "email": bvnController!.text.trim(),
  //   };
  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   if (kDebugMode) {
  //     print(body);
  //   }
  //   HttpRequest('/user/auth/forgot-password',
  //       body: body,
  //       headers: header,
  //       context: context,
  //       loader: LoaderType.popup, onSuccess: (_, result) async {
  //     Navigator.pop(context);

  //     var data = {
  //       "email": bvnController!.text,
  //       "token": "",
  //       "password": "",
  //       "password_confirmation": ""
  //     };

  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //                 Otp(email: bvnController!.text, data: data)));
  //   }, onFailure: (_, result) {
  //     Navigator.pop(context);
  //     showTopSnackBar(
  //       Overlay.of(context)!,
  //       CustomSnackBar.error(
  //         message: result['message'],
  //       ),
  //     );

  //     print(result['details']);
  //     return;
  //   }).send();

  //   // }
  // }
}
