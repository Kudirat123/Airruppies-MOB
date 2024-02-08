import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/home/models/transaction_model.dart';
import 'package:airruppies/ui/transactions/transaction_details.dart';
import 'package:airruppies/ui/transactions/transaction_service/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeTransactionWidget extends StatefulWidget {
  const HomeTransactionWidget({super.key});

  @override
  State<HomeTransactionWidget> createState() => _HomeTransactionWidgetState();
}

class _HomeTransactionWidgetState extends State<HomeTransactionWidget> {
  List<TransactionModel>? listOfTransactions;

  bool loading = true;
  @override
  void initState() {
    getTransaction();
  }

  Future<void> getTransaction() async {
    listOfTransactions =
        TransactionSerice().getTransactionList as List<TransactionModel>?;
    //   Provider.of<TransactionState>(context, listen: false).transactionList;
    // ignore: avoid_print
    print(listOfTransactions);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: loading
              ? const CircularProgressIndicator()
              : Container(
                  child: listOfTransactions!.isEmpty
                      ? Container(
                          child: Text(
                            'No Transaction',
                            style: TextStyles().purpleTextStyle(),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                color: themes().whiteColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
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

                                    Container(
                                      child: listOfTransactions!.length > 1
                                          ? Container()
                                          : Expanded(
                                              child: ListView.builder(
                                                itemCount: 4,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        InkWell(
                                                  focusColor: Colors.white,
                                                  hoverColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  splashColor: Colors.white,
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute<Widget>(
                                                    //         builder: (BuildContext context) =>
                                                    //             TransactionReceipt()));
                                                  },
                                                  child: TransactionDetails(
                                                      data: listOfTransactions![
                                                          index]),
                                                ),
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                )),
    );
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
        padding: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
                          Text(
                            'N ${widget.data!.amount}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
            const SizedBox(
              height: 10,
            ),

            const Divider(
              thickness: 0.5,
            )

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
