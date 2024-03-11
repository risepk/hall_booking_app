import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/screens/add_hall.dart';
import 'package:hall_booking_app/screens/hall_map.dart';
import 'package:hall_booking_app/screens/profile_screen.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';

import 'before_login.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? photo;
  late UserDetail userData;
  @override
  void initState() {
    super.initState();
    loadUserData();
    RememberUserPrefs.getUserDetails();
  }
  Future<void> loadUserData() async {
    try {
      final data = await RememberUserPrefs.getUserDetails();
      setState(() {
        userData = data;
        photo = data.photo;
      });
    } catch (error) {
      // Handle the error, you can log it or show a default value
      print("Error loading user data: $error");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange, // Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                FutureBuilder(
                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: RememberUserPrefs.getUserDetails(),
                  builder: (context, snapshot) {
                    // Checking if future is resolved or not
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final data = snapshot.data!;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                          title: Text(data.name.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white)),
                          subtitle: Text('Welcome Hall Owner',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white54)),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }));
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: data.photo.isEmpty
                                  ? AssetImage('assets/images/sam.jpg') as ImageProvider
                                  : NetworkImage(data.photo),
                            ),
                          ),
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Colors.deepOrange, //Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return AddHall();
                      }));
                    },
                    child: itemDashboard('Register Hall',
                        CupertinoIcons.music_house_fill, Colors.deepOrange),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return HallMap();
                      }));

                    },
                    child: itemDashboard(
                        'My Halls', CupertinoIcons.building_2_fill, Colors.green),
                  ),
                  itemDashboard(
                      'About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard(
                      'Contact', CupertinoIcons.phone, Colors.pinkAccent),
                  InkWell(
                    onTap: () {
                      RememberUserPrefs.logout();
                      Fluttertoast.showToast(
                          msg: "You have Successfully Logout!");
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return BeforeLogin();
                      }));
                    },
                    child: itemDashboard(
                        'Logout', Icons.logout_rounded, Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}
