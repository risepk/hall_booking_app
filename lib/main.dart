import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hall_booking_app/screens/before_login.dart';
import 'package:hall_booking_app/screens/dashboard_screen.dart';
import 'package:hall_booking_app/screens/pre_registration_screen.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
   statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hall Booking App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // This is the theme of your application.
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: RememberUserPrefs.isLoggedIn(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.data == 0) {
              print("*****${dataSnapShot.data}");
              return const BeforeLogin();
            } else {
              return const DashBoard();
            }
          }),
    );
  }
}
