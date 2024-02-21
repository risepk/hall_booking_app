import 'dart:convert';
import 'package:hall_booking_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
//save and remember user info in shared preferences
  static Future<void> saveRememberUser(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = userInfo.id ?? 0;
    String userName = userInfo.user_name;
    String userEmail = userInfo.user_email;
    String userMobile = userInfo.user_mobile;
    String userType = userInfo.user_type;
    await preferences.setInt("currentUserId", userId);
    await preferences.setString("currentUserName", userName);
    await preferences.setString("currentUserEmail", userEmail);
    await preferences.setString("currentUserMobile", userMobile);
    await preferences.setString("currentUserType", userType);
  }

  static Future<int> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = await preferences.getInt("currentUserId") ?? 0;
    return userId;
  }
  static Future<LoggedInUser> readUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = await preferences.getInt("currentUserId");
    String? userName = await preferences.getString("currentUserName");
    String? userEmail = await preferences.getString("currentUserEmail");
    String? userMobile = await preferences.getString("currentUserMobile");
    String? userType = await preferences.getString("currentUserType");
    return LoggedInUser(
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userMobile: userMobile,
      userType: userType);
  }
}

class LoggedInUser {
  int? userId;
  String? userName;
  String? userEmail;
  String? userMobile;
  String? userType;

  LoggedInUser({this.userId,
    this.userName,
    this.userEmail,
    this.userMobile,
    this.userType});
}
