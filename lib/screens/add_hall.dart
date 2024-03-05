import 'package:flutter/material.dart';


class AddHall extends StatefulWidget {
  const AddHall({super.key});

  @override
  State<AddHall> createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, description, hall_capacity, address, parking_capacity, ownerId, owner_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  // Beautiful image added here
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/p1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Hall, Your Pride!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Showcase it to the World!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Hall Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.deepOrange),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Hall Name';
                      }
                      name = text;
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Hall Details About Your Hall';
                      }
                      description = text;
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Hall Capacity",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      prefixIcon: Icon(Icons.reduce_capacity, color: Colors.deepOrange),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Hall Name';
                      }
                      hall_capacity = text;
                      return null;
                    },
                  ),
                  Text('         No of Guests it can accommodate', style: TextStyle(color: Colors.blueGrey),),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Address",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      prefixIcon: Icon(Icons.location_on_rounded, color: Colors.deepOrange),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Input Required';
                      }
                      address = text;
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Parking Capacity",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      prefixIcon: Icon(Icons.car_repair, color: Colors.deepOrange),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Input Required';
                      }
                      parking_capacity = text;
                      return null;
                    },
                  ),
                  Text('         No of Vehicles it can accommodate', style: TextStyle(color: Colors.blueGrey),),

                  SizedBox(height: 18),
                  // ... (other TextFormField widgets with similar styling)

                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // Handle form submission

                      }
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.orange],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Add My Hall!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:hall_booking_app/screens/sign_in.dart';

import '../utilities/datastore.dart';

class AddHall extends StatefulWidget {
  const AddHall({super.key});

  @override
  State<AddHall> createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, email, password, confirmPassword, mobile, address;
  String _selectedUserType = usertype[0];
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
                    const Text(
                      "Your Hall, Your Pride!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " Showcase it to the World!",
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
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
*/
