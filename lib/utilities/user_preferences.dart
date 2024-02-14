import 'dart:convert';

import 'package:hall_booking_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
//save and remember user info in shared preferences
static Future<void> saveRememberUser(User userInfo) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String UserJsonData = jsonDecode(userInfo.toJson());
  await preferences.setString("currentUser", userJsonData);
}
}