import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hall_booking_app/screens/image_upload.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? chosenImage;
  bool showLocalImage = false;

  pickImageFrom(ImageSource imageSource, int id) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if(xFile == null){
      return;
    }
    chosenImage = File(xFile.path);
    setState(() {
      showLocalImage = true;
    });
    uploadImage(id);
    //now save to the server using the API
  }

  Future<void> uploadImage(int id) async {
    var uploadurl = Uri.parse('http://booking.mysoft.pk/api/user/login.php');
    try{
      List<int> imageBytes = chosenImage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
            'id':id,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
  }

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
                          backgroundImage: showLocalImage ? FileImage(chosenImage!) as ImageProvider :
                          data!.photo == null ? AssetImage('assets/images/sam.jpg') as ImageProvider :
                          NetworkImage("https://avatars.githubusercontent.com/u/24992385?v=4"),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined),
                          onPressed: (){
                            showBottomSheet(
                                context: context, builder: (context){
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text("From Camera"),
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          pickImageFrom(ImageSource.camera, data!.id);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.browse_gallery),
                                        title: const Text("From Gallery"),
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          pickImageFrom(ImageSource.gallery, data!.id);
                                        },
                                      ),

                                    ],
                                  );
                            });//bottom-sheet
                          }, //on pressed body
                        ),
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
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)
                              {
                                return ImageUpload();
                              }
                              ));
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