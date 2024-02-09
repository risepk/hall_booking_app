import 'package:flutter/material.dart';

class PostRegistrationScreen extends StatefulWidget {
  const PostRegistrationScreen({super.key});

  @override
  State<PostRegistrationScreen> createState() => _PostRegistrationScreenState();
}

class _PostRegistrationScreenState extends State<PostRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  "HALLS BOOKING APP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Text(
                  "Welcome to Hall Booking App \n How Can we Help You Today?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 185,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.holiday_village,
                                color: Colors.white,
                                size: 35,
                              ),
                              Text(
                                "Hall Owners",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Register Your Hall for Free and get Your Hall Booking Easily!",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              /*   Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Login.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Register!",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                            ],
                          )),
                      Container(
                          width: 185,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.supervised_user_circle,
                                color: Colors.white,
                                size: 35,
                              ),
                              Text(
                                "Hall Seekers",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Looking for an Event, Gethering or Weeding Hall? Lets Book one!",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Divider(),
                    Text(
                      "AVAILABLE HALLS",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),

                    Container(
                      height: 200,
                      color: Colors.red,
                      child: Row(
                        children: [
                          Text(
                            "Salman Weeding Hall",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),Container(
                      height: 200,
                      color: Colors.green,
                    ),Container(
                      height: 200,
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
