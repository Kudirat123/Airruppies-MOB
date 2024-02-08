import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/send_money/bank_send_money/bank_send_money1.dart';
import 'package:airruppies/ui/send_money/model/user_nearme_model.dart';
import 'package:airruppies/ui/send_money/send_money_service/send_money_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BluetoothSendMoneyWidget extends StatefulWidget {
  const BluetoothSendMoneyWidget({super.key});

  @override
  State<BluetoothSendMoneyWidget> createState() =>
      _BluetoothSendMoneyWidgetState();
}

class _BluetoothSendMoneyWidgetState extends State<BluetoothSendMoneyWidget> {
  List<UserNearMeModel>? userNearMeList;

  bool? loading;

  // FlutterBlue flutterBlue = FlutterBlue.instance;
  // List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    getUserNearMe();
    super.initState();

  
  }

  Future<void> getUserNearMe() async {
    setState(() {
      loading = true;
    });

    userNearMeList = await BankService().getUserNearMe(
      context,
    );

    setState(() {
      loading = false;
    });
  }

  // void scanForDevices() {
  //   flutterBlue.startScan(timeout:  const Duration(seconds: 4));

  //   flutterBlue.scanResults.listen((scanResult) {
  //     for (ScanResult result in scanResult) {
  //       if (!devicesList.contains(result.device)) {
  //         setState(() {
  //           devicesList.add(result.device);
  //           print(devicesList);
  //         });
  //       }
  //     }
  //   });

  //   flutterBlue.stopScan();
  // }

  // Future<void> pairDevice(BluetoothDevice device) async {
  //   await device.connect();
  //   print('Device paired: ${device.name}');

  //   device.state.listen((event) {
  //     if (event == BluetoothDeviceState.connected) {
  //       print('Device connected: ${device.name}');
  //       //handleDeviceConnected(device);
  //     } else if (event == BluetoothDeviceState.disconnected) {
  //       print('Device disconnected: ${device.name}');
  //       //handleDeviceDisconnected(device);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().whiteAppBarWithBackButton('Send Money', context),
      body: SafeArea(
        child: loading!
            ? Center(
                child: CircularProgressIndicator(
                color: themes().primaryColor,
              ))
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: MyButton(text: 'AirRuppies')),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: SecondaryButton(
                          text: 'Transfer',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BankSendMoneyWidget()));
                          },
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'Make a USSD transfer from your bank account into your air ruppies account',
                      textAlign: TextAlign.center,
                      style: TextStyles().blackTextStyle().copyWith(
                          fontSize: 12,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Text(
                          'Nearby you',
                          textAlign: TextAlign.center,
                          style: TextStyles().blackTextStyle().copyWith(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(
                        'assets/svgs/send_money_svgs/empty-box 1.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Can’t find anything Air Ruppies account near by. Try Again',
                      textAlign: TextAlign.center,
                      style: TextStyles().blackTextStyle().copyWith(
                          fontSize: 12,
                          color: const Color(0xffA2A0A8),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: MyButton(
                          text: 'Reload',
                          onPressed: () {
                            getUserNearMe();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const SelectBankWidget()));
                          },
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.image, required this.text});
  final Widget image;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        const SizedBox(height: 8.0),
        text,
      ],
    );
  }
}
