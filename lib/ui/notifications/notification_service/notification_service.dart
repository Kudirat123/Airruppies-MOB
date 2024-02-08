import 'dart:async';

import 'package:airruppies/ui/authentication/auth_state.dart';
import 'package:airruppies/ui/notifications/notification_model/notification_%20model.dart';
import 'package:airruppies/utils/network.dart';
import 'package:provider/provider.dart';

class NotificationService {
  //Update Profile

  Future<List<NotificationModel>> getNotification(context) async {
    Completer<List<NotificationModel>> completer =
        Completer<List<NotificationModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'notifications?',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        // ignore: avoid_print
        print(result);
        List<NotificationModel> notificationList = result['data']
            .map<NotificationModel>(
                (element) => NotificationModel.fromJson(element))
            .toList();

        completer.complete(notificationList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }

  Future<List<NotificationModel>> markAllAsRead(context) async {
    Completer<List<NotificationModel>> completer =
        Completer<List<NotificationModel>>();
    var token = Provider.of<AuthState>(context, listen: false).token;

    HttpRequest(
      'notifications?',
      method: 'GET',
      context: context,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      shouldPopOnError: false,
      onSuccess: (_, result) async {
        // ignore: avoid_print
        print(result);
        List<NotificationModel> notificationList = result['data']
            .map<NotificationModel>(
                (element) => NotificationModel.fromJson(element))
            .toList();

        completer.complete(notificationList);
      },
      onFailure: (_, result) {
        // ignore: avoid_print
        print(result);
        completer.completeError(result);
      },
    ).send();

    return completer.future;
    // }
  }
}
