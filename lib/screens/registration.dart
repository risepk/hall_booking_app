import 'dart:convert';
import 'package:hall_booking_app/utilities/datastore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/screens/sign_in.dart';
import 'package:http/http.dart' as http;

import '../api/api_connection.dart';
import '../model/user.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, email, password, confirmPassword, mobile, address;

  validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {'user_email': email},
      );
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['emailFound'] == true) {
          Fluttertoast.showToast(
            msg: "Email Address Already Registered.",
            fontSize: 25,
            backgroundColor: Colors.red,
          );
          return;
        } else {
          //save it to db
          //Fluttertoast.showToast(msg: "Proceed for signup with $email");
          registerAndSaveUserRecord();
        }
      } else {
        Fluttertoast.showToast(msg: "Error: Accessing API Server");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "error: $e");
    }
  }

  String _selectedUserType = usertype[0];

  registerAndSaveUserRecord() async {
    User user = User(
        id: 0,
        user_name: name,
        user_email: email,
        user_password: password,
        user_mobile: mobile,
        user_type: _selectedUserType);
    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: user.toJson(),
      );
      if (res.statusCode == 200) {
        var responseBodyOfSignUp = jsonDecode(res.body);
        if (responseBodyOfSignUp['success'] == true) {
          formKey.currentState!.reset();
          Fluttertoast.showToast(
            msg: "Register Successfully Please Login!",
            fontSize: 23,
            backgroundColor: Colors.green,
          );
        } else {
          Fluttertoast.showToast(msg: "Error Occurred Please Try Again Later");
        }
      } else {
        Fluttertoast.showToast(msg: "Cannot Hit API");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
          child: Center(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Create Account",
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
                  "Join the Celebration: Your Dream Venue Awaits!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter Your Name';
                    }
                    name = text;
                    return null;
                  },
                ),
                SizedBox(height: 18),
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
                      return 'Please Enter Valid Email E.g john@gmail.com';
                    }
                    email = text;
                    return null;
                  },
                ),
                SizedBox(height: 18),
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
                SizedBox(height: 18),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Confirm Password",
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
                      return 'Please provide value';
                    }
                    if (text != password) {
                      return 'Passwords do not match';
                    }
                    confirmPassword = text;
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Mobile",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                    suffixIcon: Icon(Icons.install_mobile),
                    prefixIcon: Icon(Icons.phone),
                  ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please provide value';
                      }
                      if (text.length < 11) {
                        return 'Enter a valid Mobile #';
                      }

                      mobile = text;
                      return null;
                    },
                ),
                SizedBox(height: 10),
                Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField(
                    value: _selectedUserType,
                    hint: const Text("User Type"),
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                    ),

                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedUserType = value!;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        _selectedUserType = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "can't empty";
                      } else {
                        return null;
                      }
                    },
                    items: usertype.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      validateUserEmail();
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
                        "Register!",
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
                    const Text(
                      "Already Have Account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignIn();
                          }));
                        },
                        child: Text(
                          "Login",
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
    );
  }
}
