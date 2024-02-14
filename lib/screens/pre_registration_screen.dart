import 'package:flutter/material.dart';
import 'package:hall_booking_app/owner_registration.dart';
import 'package:hall_booking_app/screens/custom_card.dart';

class PreRegistrationScreen extends StatefulWidget {
  const PreRegistrationScreen({super.key});

  @override
  State<PreRegistrationScreen> createState() => _PreRegistrationScreenState();
}

class _PreRegistrationScreenState extends State<PreRegistrationScreen> {
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
                      GestureDetector(
                        child: Container(
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
                              ],
                            )),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  OwnerRegistration()),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return const OwnerRegistration();
                          }));*/
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context){
                                return  OwnerRegistration();
                              }
                          ));

                        },
                        child: Container(
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
                                  "Looking for an Event, Gathering or Weeding Hall? Lets Book one!",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Divider(),
                    Text(
                      "AVAILABLE HALLS",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    CustomEventCard(
                        hallName: "Imperial Marquee",
                        address: "Civil Quarters, Peshawar",
                        capacity: 400,
                        contactNo: "03005341876",
                        picture: "assets/images/1.jpg",),
                    SizedBox(height: 7,),
                    CustomEventCard(
                      hallName: "Salman Weeding Hall",
                      address: "Kohat Road, Peshawar",
                      capacity: 200,
                      contactNo: "03005341876",
                      picture: "assets/images/2.jpg",),
                    SizedBox(height: 7,),
                    CustomEventCard(
                      hallName: "Royal Gathering",
                      address: "University Town Peshawar",
                      capacity: 300,
                      contactNo: "03005341876",
                      picture: "assets/images/3.jpg",),
                    SizedBox(height: 7,),
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
