import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/screens/dashboard_screen.dart';
import 'package:hall_booking_app/screens/owner_registration.dart';
import 'package:hall_booking_app/screens/pre_registration_screen.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_connection.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email, password;

  loginUserNow() async {
    //List<UserDetail> userDetails = [];
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {'user_email': email, 'user_password': password},
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        var jsonObject = json.decode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(
            msg: "Your are Successfully Logged-In.",
            fontSize: 25,
            backgroundColor: Colors.green,
          );

          // Access specific values in the JSON
          //bool success = jsonObject['success'];
          Map<String, dynamic> userData = jsonObject['userData'];
          // Access values within userData
          int userId = int.parse(userData['id']);
          String userName = userData['user_name'];
          String userEmail = userData['user_email'];
          String userMobile = userData['user_mobile'];
          String userType = userData['user_type'];
          String userPassword = userData['user_password'];
          User userInfo = User(
              id: userId,
              user_name: userName,
              user_email: userEmail,
              user_password: userPassword,
              user_mobile: userMobile,
              user_type: userType);
          RememberUserPrefs.saveRememberUser(userInfo);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return const DashBoard();
          }), (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(msg: "Please Provide Valid Email/Password");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: Cannot Hit API");
      }
    } catch (e) {
      print("*********************");
      print(e.toString());
      Fluttertoast.showToast(
        msg: "ERROR : ${e.toString()}",
        fontSize: 25,
        backgroundColor: Colors.red,
      );
    } //catch ends
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Login - Hall Booking App',
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              //Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (emailValid == false) {
                    return 'Please Enter Valid Email E.g ali@gmail.com';
                  }
                  email = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              //Password
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter password';
                  }
                  if (text.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(text)) {
                    return 'Password must contain both letters and numbers';
                  }
                  password = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      loginUserNow();
                    }
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const OwnerRegistration();
                    }));
                  },
                  child: const Text('Not Registered ? Tap Here!')),
            ],
          ),
        ),
      ),
    );
  }
}
