import 'package:flutter/material.dart';
import 'package:hall_booking_app/screens/pre_registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          IconButton(onPressed: () async{
            final SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.remove("currentUserId");
            await preferences.remove("currentUserName");
            await preferences.remove("currentUserEmail");
            await preferences.remove("currentUserMobile");
            await preferences.remove("currentUserType");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context){
                      return PreRegistrationScreen();
                    }
                ), (route) => false);
          }, icon: Icon(Icons.logout)),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepOrange,
              Colors.orange,
            ],),
          ),
        ),
      ),
      body: Column(),
    );
  }
}
