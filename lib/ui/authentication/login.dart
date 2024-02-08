import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/authentication/auth_service.dart';
import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/authentication/forgot_password/email_forgot_password.dart';
import 'package:airruppies/ui/authentication/registration/bvn.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/input/outlineInput.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

//import 'package:truman_staff/utils/tools.dart' as tools;

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool LoginWidgetPasswordVisibility = false;

  bool staffLoginPasswordVisibility = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController(); //..text = 'admin@mail.com';
    passwordController = TextEditingController(); //..text = 'password';
  }

  DateTime? currentBackPressTime;
  Future<bool> _onWillPop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginWidget()));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the back button is pressed within 2 seconds of the last press
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Press back again to exit the app')),
          );
          return false; // Prevent exiting the app on the first back press
        }
        return true; // Exit the app on the second back press
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(

          child: SizedBox(

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .9,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text('Hi, Welcome Back!  ',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text('Sign in to your account.',
                                  style: TextStyles()
                                      .greyTextStyle()
                                      .copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 48,
                              ),
                              OutlineInput(
                                controller: emailController,
                                labelText: 'Email/Phone Number',
                                validator: tools.Validators.validateEmail,
                                preffixWidget: Icon(MdiIcons.phone,
                                    color: themes().greyText),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              OutlineInput(
                                controller: passwordController,
                                labelText: 'Password',
                                obscureText: !staffLoginPasswordVisibility,

                                preffixWidget: Icon(MdiIcons.lock,
                                    color: themes().greyText),

                                //validator: tools.Validators.validateEmail,

                                suffixWidget: InkWell(
                                  onTap: () => setState(
                                    () => staffLoginPasswordVisibility =
                                        !staffLoginPasswordVisibility,
                                  ),
                                  child: Icon(
                                    staffLoginPasswordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: themes().iconColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPassword()));
                                      },
                                      child: Text('Forgot Password',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  MyButton(
                                    text: 'Login',
                                    onPressed: () async {

                                      //incase it doesnt work out comment out
                                      // var userDeviceId =
                                      //     await tools.getFromStore('deviceId');
                                      // var userLocation =
                                      //     await tools.getFromStore('location');
                                      // Provider.of<AuthState>(context,
                                      //         listen: false)
                                      //     .getDeviceIdandLocation(
                                      //         userDeviceId, userLocation);


                                      if (!_formKey.currentState!.validate()) {
                                      } else {
                                        var body = {
                                          'identifier': emailController.text,
                                          'password': passwordController.text,
                                          'location': Provider.of<AuthState>(
                                                  context,
                                                  listen: false)
                                              .userLocation,

                                          // 'location': '-122.084, 37.4219983',
                                          'device_id':
                                              // 'mobile'
                                              Provider.of<AuthState>(context,
                                                      listen: false)
                                                  .userDeviceId
                                        };
                                        print(body);
                                        AuthService().login(context, body);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BvnWidget()));
                                    },
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Don’t have account? ',
                                                style: TextStyles()
                                                    .greyTextStyle()),
                                            TextSpan(
                                                text: 'Sign Up',
                                                style: TextStyles()
                                                    .purpleTextStyle()),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text('Or login with',
                                      style: TextStyles()
                                          .greyTextStyle()
                                          .copyWith(fontSize: 14)),
                                ),
                                const Expanded(
                                    child: Divider(
                                  height: 1,
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child:
                                  // tools.getFromStore('fingerPrintLoginValue') !=
                                  //         true
                                  //     ? Container()
                                  //     :

                                  BorderButton(
                                text: 'Fingerprint/Face ID',
                                onPressed: () async {

                                  //incase ui fails comment out
                                  var userDeviceId =
                                      await tools.getFromStore('deviceId');
                                  var userLocation =
                                      await tools.getFromStore('location');
                                  Provider.of<AuthState>(context, listen: false)
                                      .getDeviceIdandLocation(
                                          userDeviceId, userLocation);

                                  var body = {
                                    'identifier':
                                        await tools.getFromStore('username'),
                                    'password':
                                        await tools.getFromStore('password'),

                                    'location': Provider.of<AuthState>(context,
                                            listen: false)
                                        .userLocation,

                                    // 'location': '-122.084, 37.4219983',
                                    'device_id':
                                        // 'mobile'
                                        Provider.of<AuthState>(context,
                                                listen: false)
                                            .userDeviceId

                                  };
                                  tools.biometericAttemptLogin(context, body);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //              FingerPrintWidget()));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // _signUp() {
  //   if (!_formKey.currentState!.validate()) return;
  //   var body = {
  //     "email": emailController.text.trim(),
  //     "password": passwordController.text,
  //   };

  //   if (kDebugMode) {
  //     print(body);
  //   }
  //   HttpRequest(
  //     '/admin/auth/login',
  //     body: body,
  //     context: context,
  //     loader: LoaderType.popup,
  //     onSuccess: (_, result) async {
  //       print(result);
  //       await Provider.of<AdminState>(context, listen: false)
  //           .setToken(context, result['access_token'], result);

  //       result['role'] == 'sales'
  //           ? Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => SalesStaffHomeBar()))
  //           : Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => StaffHomeBar()));
  //     },
  //     onFailure: (_, result) {
  //       print(result);
  //       showTopSnackBar(
  //         Overlay.of(context)!,
  //         CustomSnackBar.error(
  //           message: result['message'],
  //         ),
  //       );

  //       return;
  //     },
  //   ).send();

  //   // }
  // }
}
