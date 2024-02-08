import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/models/transaction_model.dart';
import 'package:airruppies/ui/transactions/transaction_details.dart';
import 'package:airruppies/ui/transactions/transaction_service/transaction_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:airruppies/widget/other/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllTransactionWidget extends StatefulWidget {
  const AllTransactionWidget({super.key});

  @override
  State<AllTransactionWidget> createState() => _AllTransactionWidgetState();
}

class _AllTransactionWidgetState extends State<AllTransactionWidget> {
  List<TransactionModel>? listOfTransactions;

  bool loading = true;
  @override
  void initState() {
    getTransaction();
  }

  Future<void> getTransaction() async {
    listOfTransactions = await TransactionSerice().getTransactionList(context);
    // ignore: avoid_print
    print(listOfTransactions);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar:
            AppBars().whiteAppBarWithBackButton('Transaction History', context),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                color: themes().primaryColor,
              ))
            : Container(
                child: listOfTransactions!.isEmpty
                    ? Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Center(
                            child: Text(
                          'No Transaction',
                          style: TextStyles().purpleTextStyle(),
                        )))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // MyButton(
                                  //   text: 'fund Wallet',
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 FirstAddMoneyWidget()));
                                  //   },
                                  // ),

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Transactions',
                                  //       overflow: TextOverflow.ellipsis,
                                  //       style:
                                  //           TextStyles().blackTextStyle400(),
                                  //     ),
                                  //     Text(
                                  //       'See All',
                                  //       overflow: TextOverflow.ellipsis,
                                  //       style: TextStyles().purpleTextStyle(),
                                  //     ),
                                  //   ],
                                  // ),

                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: listOfTransactions!.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              InkWell(
                                        focusColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        hoverColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        highlightColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        splashColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute<Widget>(
                                          //         builder: (BuildContext context) =>
                                          //             TransactionReceipt()));
                                        },
                                        child: TransactionDetails(
                                            data: listOfTransactions![index]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ));
  }
}

class TransactionDetails extends StatefulWidget {
  TransactionDetails({
    super.key,
    this.data,
  });
  TransactionModel? data;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionDetailsPage(data: widget.data)));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 22),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: widget.data!.image.toString() != 'null'
                          ? Image.network(widget.data!.image)
                          : Image.asset('assets/images/BIllPayment.png'),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Text(
                                widget.data!.name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const ModeSelectionNairaWidget(),
                              Text(
                                widget.data!.amount,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.data!.isCredit
                                  ? Icon(
                                      MdiIcons.arrowLeftThin,
                                      color: Colors.green,
                                      size: 17,
                                    )
                                  : Icon(MdiIcons.arrowRightThin,
                                      color: Colors.red, size: 17),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  widget.data!.type,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles()
                                      .greyTextStyle400()
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.data!.createdAt,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles()
                                .greyTextStyle400()
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Column(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: <Widget>[
                //     Text(
                //       '${boolTransactionType ? '+' : '-'} ₦${NumberFormat('#,####.00').format(double.parse(widget.amount))}',
                //       textAlign: TextAlign.end,
                //       style: TextStyles().defaultText(16, FontWeight.w400,
                //           boolTransactionType ? Colors.green : Colors.red),
                //     ),
                //      SizedBox(
                //       height: 12,
                //     ),
                //     Text(
                //       widget.createdAt.toString().toLowerCase() == 'null'
                //           ? ''
                //           : DateFormat.yMd()
                //               .add_jm()
                //               .format(DateTime.parse(widget.createdAt)),
                //       textAlign: TextAlign.end,
                //       style:
                //           TextStyles().greyTextStyle400().copyWith(fontSize: 12),
                //     ),
                //   ],
                // ),
              ],
            ),
            //  Padding(
            //   padding: EdgeInsets.symmetric(vertical: 12),
            //   child: GreyDivider(),
            // )
          ],
        ),
      ),
    );
  }
}
