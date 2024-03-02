import 'package:flutter/material.dart';
import 'package:hall_booking_app/screens/registration.dart';
import 'package:hall_booking_app/screens/sign_in.dart';

class BeforeLogin extends StatelessWidget {
  const BeforeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/2.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "\nHall Booking App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Discover Your Dream Hall Here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Explore all the weeding/Events halls based on your Budget, Capacity or Location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 190,
              // color: Colors.orange,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return RegistrationScreen();
                            }));
                          },
                          child: myButton(title: "Register", color: Colors.white60)),
                        ),
                    Expanded(child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context){
                              return SignIn();
                            }
                        ));
                      },
                      child: myButton(title: "Login"),
                    )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  myButton({String? title, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color ?? Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Text(
          title ?? "title",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
