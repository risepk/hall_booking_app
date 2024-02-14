import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/model/user.dart';
import 'package:hall_booking_app/screens/login_screen.dart';
import 'package:hall_booking_app/utilities/datastore.dart';
import 'package:http/http.dart' as http;
import '../api/api_connection.dart';

class OwnerRegistration extends StatefulWidget {
  const OwnerRegistration({super.key});

  @override
  State<OwnerRegistration> createState() => _OwnerRegistrationState();
}

class _OwnerRegistrationState extends State<OwnerRegistration> {
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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Sign Up - Hall Booking App',
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
              //Name
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  name = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
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
              //Confirm password
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(),
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
              const SizedBox(
                height: 16,
              ),
              //Mobile No
              TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  border: OutlineInputBorder(),
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
              const SizedBox(
                height: 16,
              ),
              //usertype
              DropdownButtonFormField(
                value: _selectedUserType,
                hint: const Text("User Type"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
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
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      validateUserEmail();
                    }
                  },
                  child: const Text('Save')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  child: const Text('Already Registered Login Here')),
            ],
          ),
        ),
      ),
    );
  }
}

/*

class OwnerRegistration extends StatefulWidget {
  @override
  _OwnerRegistrationState createState() => _OwnerRegistrationState();
}

class _OwnerRegistrationState extends State<OwnerRegistration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your email';
                  }
                  // You can add more complex email validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your password';
                  }
                  // You can add more complex password validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your contact number';
                  }
                  // You can add more complex contact validation if needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform signup logic here
                    // For now, just print the form data
                    print('Name: ${_nameController.text}');
                    print('Email: ${_emailController.text}');
                    print('Password: ${_passwordController.text}');
                    print('Contact: ${_contactController.text}');
                    print('Address: ${_addressController.text}');
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
