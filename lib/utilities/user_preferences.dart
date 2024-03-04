import 'package:hall_booking_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
//save and remember user info in shared preferences
  static Future<void> saveRememberUser(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = userInfo.id;
    String userName = userInfo.user_name;
    String userEmail = userInfo.user_email;
    String userMobile = userInfo.user_mobile;
    String userType = userInfo.user_type;
    String photo = userInfo.photo;
    await preferences.setInt("currentUserId", userId);
    await preferences.setString("currentUserName", userName);
    await preferences.setString("currentUserEmail", userEmail);
    await preferences.setString("currentUserMobile", userMobile);
    await preferences.setString("currentUserType", userType);
    await preferences.setString("currentUserPhoto", photo);
  }

  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUserId");
    await preferences.remove("currentUserName");
    await preferences.remove("currentUserEmail");
    await preferences.remove("currentUserMobile");
    await preferences.remove("currentUserPassword");
    await preferences.remove("currentUserType");
    await preferences.remove("currentUserPhoto");
  }

  static Future<int> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = await preferences.getInt("currentUserId") ?? 0;
    return userId;
  }

  static Future<UserDetail> getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = await preferences.getInt("currentUserId") ?? 0;
    String userName = await preferences.getString("currentUserName")  ?? '' ;
    String userEmail = await preferences.getString("currentUserEmail") ?? '';
    String userMobile = await preferences.getString("currentUserMobile") ?? '';
    String userType = await preferences.getString("currentUserType") ?? '';
    String photo = await preferences.getString("currentUserPhoto") ?? '';
    return UserDetail(
      id: userId,
      name: userName,
      email: userEmail,
      mobile: userMobile,
      userType: userType,
      photo: photo);
  }
}

class UserDetail {
  late int id;
  late String name, email, mobile, userType;
  late String photo;

  UserDetail({ required this.id, required this.name, required this.email, required this.mobile, required this.userType, required this.photo});
}
