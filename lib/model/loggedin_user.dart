import 'package:shared_preferences/shared_preferences.dart';

class LoggedInUser {
  late int id;
  String? name, email, mobileNo, userType;

  LoggedInUser({
    required this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.userType,
  });
   Future<LoggedInUser> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = await preferences.getInt("currentUserId") ?? 0;
    String? userName = await preferences.getString("currentUserName") ?? null;
    String? userEmail = await preferences.getString("currentUserEmail") ?? null;
    String? userMobile = await preferences.getString("currentUserMobile") ??
        null;
    String? userType = await preferences.getString("currentUserType") ?? null;
    return LoggedInUser(id: userId, name: userName, email: userEmail, mobileNo: userMobile, userType: userType);
  }
}
