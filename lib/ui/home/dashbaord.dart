

import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/account/account_service/account_service.dart';
import 'package:airruppies/ui/account/account_state.dart/account_state.dart';
import 'package:airruppies/ui/home/dashboard_service/dashboard_service.dart';
import 'package:airruppies/ui/home/home_widget/advert_board.dart';
import 'package:airruppies/ui/home/home_widget/home_card.dart';
import 'package:airruppies/ui/home/home_widget/home_items.dart';
import 'package:airruppies/ui/home/models/advert_model.dart';
import 'package:airruppies/ui/home/models/transaction_model.dart';
import 'package:airruppies/ui/notifications/notification_ui/notification_page.dart';

import 'package:airruppies/ui/transactions/transaction_service/transaction_service.dart';
import 'package:airruppies/ui/transactions/transactions.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  Map<String, dynamic>? userData;

  List<AdvertModel>? advertData;

  bool? isAdvertLoading = true;

  List<TransactionModel>? listOfTransactions;
    DateTime? currentBackPressTime;

  Future<void> getUserDetail() async {
  AccountSerice().getProfile(context);
    userData = Provider.of<AccountState>(context, listen: false).userDetails;

    setState(() {});
  }

  //get advertList

  Future<void> getAdvertData() async {
    advertData = await DashBoardService().getAdvertisment(context);
    listOfTransactions = await TransactionSerice().getTransactionList(context);
    setState(() {
      isAdvertLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetail();
    getAdvertData();
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
          backgroundColor:Theme.of(context).scaffoldBackgroundColor, 
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                         CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20.0,
                            backgroundImage:
                                NetworkImage(     userData!['image'].toString().toLowerCase() == 'null' ?  'https://example.com/avatar.jpg' :userData!['image'] ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
    
                          Text(
                            'Hi, ${userData!['username']}',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
    
                          //accountTierWidget(userData!['account_level'])
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NotificationPage()));
                        },
                        child: badges.Badge(
                          position: badges.BadgePosition.topEnd(top: 2, end: -1),
                          showBadge: userData!['has_notifications'],
                          ignorePointer: false,
                          child: const Icon(Icons.notifications),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: const HomeCard()),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                      height: 126,
                      width: MediaQuery.of(context).size.width,
                      child: const HomeItem()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isAdvertLoading!
                      ? CircularProgressIndicator(
                          color: themes().primaryColor,
                        )
                      : Column(
                          children: [
                            SizedBox(
                                height: advertData!.isEmpty ? 0 : 110,
                                width: MediaQuery.of(context).size.width,
                                child: AdvertBoard(advertList: advertData)),
                            Container(
                              child: listOfTransactions!.isEmpty
                                  ? Center(
                                      child: Text(
                                    'No Transaction',
                                    style: TextStyles().purpleTextStyle(),
                                  ))
                                  : Padding(
                                      padding: const EdgeInsets.only(bottom: 40),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Transaction',
                                                  style: Theme.of(context).textTheme.displaySmall
                                                    ,
                                                ),
                                                InkWell( 
                                                  onTap: (){
                                                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllTransactionWidget()));
    
                                                    
                                                  },
                                                  child: Text(
                                                    'See All',
                                                    style: TextStyles()
                                                        .purpleTextStyle().copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                             const SizedBox(height: 20,),
                                            ListView.builder(
                                              itemCount: listOfTransactions!.length > 4 ? 4 : listOfTransactions!.length
                                                      ,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context,
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
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
              ]),
            ),
          )),
    );
  }

  Container accountTierWidget(String text) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(33, 255, 188, 31),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyles()
                  .blackTextStyle400()
                  .copyWith(color: const Color(0xfff6a609), fontSize: 10),
            ),
            Icon(
              MdiIcons.sealVariant,
              size: 15,
              color: const Color(0xffFFBC1F),
            )
          ],
        ),
      ),
    );
  }
}
