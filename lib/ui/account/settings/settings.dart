import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/change_pin.dart';
import 'package:airruppies/ui/account/reset_password.dart';
import 'package:airruppies/ui/account/reset_pin/reset_pin.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airruppies/utils/tools.dart' as tools;
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  dynamic fingerPrintValue = false;

  bool enablePassword = false;
  dynamic darkMode = false;

  bool? loading;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  getCredential() async {
    setState(() {
      loading = true;
    });

    fingerPrintValue = await tools.getFromStore('fingerPrintLoginValue');
    darkMode = await tools.getFromStore('DarkMode') ?? false;
    fingerPrintValue ??= false;

    //  enablePassword = await tools.getFromStore('fenableLoginValue');
    print(fingerPrintValue);
    setState(() {
      loading = false;
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  pageNumber: 0,
                )));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
        appBar: AppBars().backButton(context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: loading!
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.displaySmall!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'General',
                      style: Theme.of(context).textTheme.displaySmall!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter fingerprint for login',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        CupertinoSwitch(
                          value: fingerPrintValue,
                          activeColor: themes().primaryColor,
                          onChanged: (value) {
                            setState(() {
                              fingerPrintValue = value;
                              tools.putInStore('fingerPrintLoginValue', value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OtherWidget().divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enable Password for login',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        CupertinoSwitch(
                          value: enablePassword,
                          activeColor: themes().primaryColor,
                          onChanged: (value) {
                            setState(() {
                              enablePassword = value;
                              tools.putInStore('fenableLoginValue', value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OtherWidget().divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Switch to Dark Mode',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        CupertinoSwitch(
                          value: darkMode,
                          activeColor: themes().primaryColor,
                          onChanged: (value) {
                            setState(() {
                              darkMode = value;

                              tools.putInStore('DarkMode', value);

                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OtherWidget().divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePinWidget()));
                        },
                        child: settingCard('Change Transaction PIN')),
                    const SizedBox(
                      height: 15,
                    ),
                    OtherWidget().divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InAppResetPassword()));
                        },
                        child: settingCard('Change Password')),
                    const SizedBox(
                      height: 15,
                    ),
                    OtherWidget().divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPinWidget()));
                        },
                        child: settingCard('Reset PIN'))
                  ],
                ),
        ),
      ),
    );
  }

  Widget settingCard(String mainText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mainText,
          style:Theme.of(context).textTheme.displaySmall!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        )
      ],
    );
  }
}
