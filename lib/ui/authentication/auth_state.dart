import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  String? token;
  String? userLocation = '2.334,3.444';
  String? userDeviceId = 'mobile';

  void getDeviceIdandLocation(String deviceId, String location) {

    //userDeviceId = deviceId;
    userLocation = location;


    // ignore: avoid_print
    print(userDeviceId);
    notifyListeners();
  }
}
