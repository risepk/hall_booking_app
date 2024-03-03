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
    String? photo = userInfo.photo;
    await preferences.setInt("currentUserId", userId);
    await preferences.setString("currentUserName", userName);
    await preferences.setString("currentUserEmail", userEmail);
    await preferences.setString("currentUserMobile", userMobile);
    await preferences.setString("currentUserType", userType);
    if(photo != null){
      await preferences.setString("currentUserPhoto", photo);
    }
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
    int userId = await preferences.getInt("currentUserId")!;
    return userId;
  }

  static Future<UserDetail> getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = await preferences.getInt("currentUserId")!;
    String? userName = await preferences.getString("currentUserName") ?? null;
    String? userEmail = await preferences.getString("currentUserEmail") ?? null;
    String? userMobile = await preferences.getString("currentUserMobile") ?? null;
    String? userType = await preferences.getString("currentUserType") ?? null;
    String? photo = await preferences.getString("currentUserPhoto") ?? null;
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
  String? name, email, mobile, userType, photo;

  UserDetail({ required this.id, this.name, this.email, this.mobile, this.userType, this.photo});
}
