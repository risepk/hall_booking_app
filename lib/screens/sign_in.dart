import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/screens/registration.dart';
import 'package:http/http.dart' as http;

import '../api/api_connection.dart';
import '../model/user.dart';
import '../utilities/user_preferences.dart';
import 'dashboard_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          Fluttertoast.showToast(
            msg: "Please Provide Valid Email or Password",
            fontSize: 20,
            backgroundColor: Colors.red,

          );
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
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Lets Connect!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome back you've been missed! Glad to see you again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Your Registered Email Please';
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
                  SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      prefixIcon: Icon(Icons.key),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 200),
                      Text(
                        "Reset Password",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        loginUserNow();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(colors: [
                            Colors.deepOrange,
                            Colors.orange,
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return RegistrationScreen();
                            }));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
