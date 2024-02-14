class User {
  int? id;
  late String user_name;
  late String user_email;
  late String user_password;
  late String user_mobile;
  late String user_type;

  User({
      this.id,
      required this.user_name,
      required this.user_email,
      required this.user_password,
      required this.user_mobile,
      required this.user_type
      });

  User.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    user_name = json['user_name'];
    user_email = json['user_email'];
    user_password = json['user_password'];
    user_mobile = json['user_mobile'];
    user_type = json['user_type'];
  }

  Map<String, dynamic> toJson() => {
   'user_name': user_name,
   'user_email': user_email,
   'user_password': user_password,
   'user_mobile': user_mobile,
   'user_type': user_type,
  };
}