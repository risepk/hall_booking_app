// class UserModel {
//   late bool success;
//   late List<UserDetail> userDetail;
//
//   UserModel({required this.success, required this.userDetail});
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     var list = json['userData'] as List;
//     List<UserDetail> userDetail =
//         list.map((userDetail) => UserDetail.fromJson(userDetail)).toList();
//     return UserModel(
//       success: json['success'],
//       userDetail: userDetail,
//     );
//   }
// }
//
// class UserDetail {
//   int? id;
//   late String user_name;
//   late String user_email;
//   late String user_password;
//   late String user_mobile;
//   late String user_type;
//
//   UserDetail(
//       {this.id,
//       required this.user_name,
//       required this.user_email,
//       required this.user_password,
//       required this.user_mobile,
//       required this.user_type});
//
//   factory UserDetail.fromJson(Map<String, dynamic> json) {
//     return UserDetail(
//         id: int.parse(json['id']),
//         user_name: json['user_name'],
//         user_email: json['user_email'],
//         user_password: json['user_password'],
//         user_mobile: json['user_mobile'],
//         user_type: json['user_type']);
//   }
// }
