import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
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
                    final data = snapshot.data;
                    return Column(
                      children: [
                        const SizedBox(height: 40),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/24992385?v=4"),
                        ),
                        const SizedBox(height: 20),
                        itemProfile('UserID', '${data!.id}', CupertinoIcons.arrow_right_arrow_left_square_fill),
                        const SizedBox(height: 10),
                        itemProfile('Name', '${data.name}', CupertinoIcons.person),
                        const SizedBox(height: 10),
                        itemProfile('Phone', '${data.mobile}', CupertinoIcons.phone),
                        const SizedBox(height: 10),
                        itemProfile('Email', '${data.email}', CupertinoIcons.mail),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {},
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
                                  "Edit Profile!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }

                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: RememberUserPrefs.getUserDetails(),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}