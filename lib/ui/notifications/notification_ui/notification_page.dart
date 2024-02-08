import 'package:airruppies/themes.dart';
import 'package:airruppies/ui/notifications/notification_model/notification_%20model.dart';
import 'package:airruppies/ui/notifications/notification_service/notification_service.dart';
import 'package:airruppies/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel>? notificationList;

  bool? loading = true;

  Future<void> getNotificationList() async {
    notificationList = await NotificationService().getNotification(context);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getNotificationList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor, 
      appBar: AppBars().whiteAppBarWithBackButton('Notification', context),
      body:loading! ? const Center(child: CircularProgressIndicator()):
      
       Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: notificationList!.isEmpty
              ? Center(child: Text('No Notification' , style: TextStyles().purpleTextStyle(),))
              : Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                           

                                   badges.Badge(
                        position: badges.BadgePosition.topEnd(top: 2, end: -3),
                        showBadge: notificationList![index].readAt.toString().toLowerCase() == 'null',
                        ignorePointer: false,
                        child:    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: themes().primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      'assets/svgs/Union.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                  )),
                      ),




                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notificationList![index].data.title,
                                    style: Theme.of(context).textTheme.displaySmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    notificationList![index].data.body,
                                    style: TextStyles()
                                        .greyTextStyle400()
                                        .copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                

                                      DateFormat('yyyy-MM-dd   ,  H:m').format(DateTime.parse(notificationList![index]
                                          .createdAt.toString()
                                          )
                                      ),
                                    
                                    style: TextStyles()
                                        .greyTextStyle400()
                                        .copyWith(fontSize: 12),
                                  )
                                ],
                              ))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 20,
                          );
                        },
                        itemCount: notificationList!.length)
                  ],
                ),
        ),
      ),
    );
  }
}
