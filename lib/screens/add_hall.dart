import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';
import 'package:http/http.dart' as http;


class AddHall extends StatefulWidget {
  const AddHall({super.key});

  @override
  State<AddHall> createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, description, address, owner_name, hall_capacity, parking_capacity;

  late int ownerId;

  Future<void> saveHallData() async {
    var uploadurl = Uri.parse(
        'https://booking.mysoft.pk/api/user/add-hall.php');
    try {
      var userDetail = await RememberUserPrefs.getUserDetails();
      ownerId = await userDetail.id;
      owner_name = await userDetail.name;
      var response = await http.post(uploadurl,
          body: {
            'name': name,
            'description': description,
            'hall_capacity': int.parse(hall_capacity).toString(),
            'address': address,
            'parking_capacity': int.parse(parking_capacity).toString(),
            'ownerid': ownerId.toString(),
            'owner_name': owner_name,
          });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          Fluttertoast.showToast(
            msg: "Weeding Hall Added Successfully",
            fontSize: 25,
            backgroundColor: Colors.green,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Error on Server Side please check server error log",
          fontSize: 25,
          backgroundColor: Colors.red,
        );
         }
    }
    catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        fontSize: 25,
        backgroundColor: Colors.red,
      );
    }
  }

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
                        prefixIcon: Icon(Icons.person, color: Colors
                            .deepOrange),
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
                        prefixIcon: Icon(Icons.reduce_capacity, color: Colors
                            .deepOrange),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter Hall Name';
                        }
                        hall_capacity = text;
                        return null;
                      },
                    ),
                    Text('         No of Guests it can accommodate',
                      style: TextStyle(color: Colors.blueGrey),),
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
                        prefixIcon: Icon(
                            Icons.location_on_rounded, color: Colors
                            .deepOrange),
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
                        prefixIcon: Icon(Icons.car_repair, color: Colors
                            .deepOrange),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Input Required';
                        }
                        parking_capacity = text;
                        return null;
                      },
                    ),
                    Text('         No of Vehicles it can accommodate',
                      style: TextStyle(color: Colors.blueGrey),),

                    SizedBox(height: 18),
                    // ... (other TextFormField widgets with similar styling)

                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Handle form submission
                          saveHallData();
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

