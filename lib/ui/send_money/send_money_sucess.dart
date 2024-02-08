import 'dart:io';

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/navbar.dart';
import 'package:airruppies/ui/savings/air_fixed/air_fixed_summary.dart';
import 'package:airruppies/ui/send_money/transaction_history_details.dart';
import 'package:airruppies/utils/theme_manager.dart';
import 'package:airruppies/widget/button/button.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:share/share.dart';

class SendMoneySuccessWidget extends StatefulWidget {
  const SendMoneySuccessWidget({super.key, this.data});
  final dynamic data;

  @override
  State<SendMoneySuccessWidget> createState() => _SendMoneySuccessWidgetState();
}

class _SendMoneySuccessWidgetState extends State<SendMoneySuccessWidget> {
  ScreenshotController screenshotController = ScreenshotController();

  bool? hide = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, state, __) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: hide == false
                      ? Container()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4000),
                                  child: Container(
                                      color: themes().primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'assets/svgs/Union.svg',
                                          height: 40,
                                          width: 40,
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Airruppies',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 70,
                            )
                          ],
                        ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 550,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 500,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: !state.isDarkMode
                                    ? Colors.black
                                    : const Color(0xffF5F7FE),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: !state.isDarkMode
                                        ? const Color(0xff323045)
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Transfer Successful',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16),
                                      ),
                                      Text(
                                        'Your transaction has been successfully completed.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const ModeSelectionNairaWidget(),
                                          Text(
                                            '${widget.data['amount']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 22),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      SummaeyCard(
                                        firstText: widget.data['name']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'airrupies'
                                            ? 'Bank name'
                                            : 'Transaction Type',
                                        secondText: widget.data['name']
                                                    .toString()
                                                    .toLowerCase() ==
                                                'airrupies'
                                            ? 'airrupies'
                                            : '${widget.data['bank_name']}',
                                      ),
                                      SummaeyCard(
                                        firstText: 'Account name',
                                        secondText:
                                            '${widget.data['account_name']}',
                                      ),
                                      SummaeyCard(
                                        firstText: 'Account Number',
                                        secondText:
                                            '${widget.data['account_number']}',
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      SizedBox(
                                        child: hide == true
                                            ? Container()
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TransactionHistoryDetails(
                                                                  data: widget
                                                                      .data)));
                                                },
                                                child: Text(
                                                  'History Transaction',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(
                                                          color: themes()
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
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
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    SvgPicture.asset(
                      'assets/svgs/savings/savingsPlan/✔️.svg',
                      width: 150,
                    ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: hide == true
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SecondaryButton(
                                text: 'Share',
                                onPressed: () {
                                  _generateAndSavePDF(context);
                                },
                              )),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                  child: MyButton(
                                      text: 'Done',
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage(
                                                      pageNumber: 0,
                                                    )));
                                      }))
                            ],
                          ),
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generateAndSavePDF(BuildContext context) async {
    setState(() {
      hide = true;
    });
    final pdf = pdfWidgets.Document();

    final widgetScreenshot = await screenshotController.capture();

    final image = pdfWidgets.MemoryImage(
      widgetScreenshot!,
    );

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          return pdfWidgets.Image(image);
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final pdfFile = File('${output.path}/page.pdf');
    await pdfFile.writeAsBytes(await pdf.save());
    _shareImage(widgetScreenshot, '${output.path}/page.pdf');

    //final snackBar = SnackBar(content: Text('PDF saved to ${pdfFile.path}'));
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//share
  Future<void> _shareImage(Uint8List imageBytes, String path) async {
    setState(() {
      hide = false;
    });
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/image.png');
      await tempFile.writeAsBytes(imageBytes);

      await Share.shareFiles([tempFile.path], text: 'The Receipt!');
    } catch (e) {
      // ignore: avoid_print
      print('Error sharing image: $e');
    }
  }
}
