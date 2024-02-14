class User {
  late String user_name;
  late String user_email;
  late String user_password;
  late String user_mobile;
  late String user_type;

  User({
      required this.user_name,
      required this.user_email,
      required this.user_password,
      required this.user_mobile,
      required this.user_type
      });
  Map<String, dynamic> toJson() => {
   'user_name': user_name,
   'user_email': user_email,
   'user_password': user_password,
   'user_mobile': user_mobile,
   'user_type': user_type,
  };
}