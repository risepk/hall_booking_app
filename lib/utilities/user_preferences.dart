import 'dart:convert';
import 'package:hall_booking_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
//save and remember user info in shared preferences
static Future<void> saveRememberUser(User userInfo) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userId = jsonDecode(userInfo.id as String);
  String userName = jsonDecode(userInfo.user_name);
  String userEmail = jsonDecode(userInfo.user_email);
  String userMobile = jsonDecode(userInfo.user_mobile);
  String userType = jsonDecode(userInfo.user_type);
  await preferences.setInt("currentUserId", userId);
  await preferences.setString("currentUserName", userName);
  await preferences.setString("currentUserEmail", userEmail);
  await preferences.setString("currentUserMobile", userMobile);
  await preferences.setString("currentUserType", userType);
}
}
