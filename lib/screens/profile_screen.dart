import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hall_booking_app/utilities/user_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      // Camera permission is already granted
      return;
    }

    if (status.isDenied) {
      // Camera permission is denied, request it
      status = await Permission.camera.request();
      if (status.isGranted) {
        // Camera permission granted
        return;
      }
    }

    if (status.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this app
      // You may want to direct the user to the settings to manually enable the permission
      openAppSettings();
    }
  }

  File? chosenImage;
  bool showLocalImage = false;

  pickImageFrom(ImageSource imageSource, int id) async {
    XFile? xFile = await ImagePicker().pickImage(source: imageSource);
    if(xFile == null){
      return;
    }
    //print('@@@@@@@@@@@@@@@@Image picked: ${xFile.path}');
    chosenImage = File(xFile.path);
    setState(() {
      showLocalImage = true;
    });
    //now save to the server using the API
    uploadImage(id, chosenImage);
  }

  Future<void> uploadImage(int id, File? chosenImage) async {
    var uploadUrl = Uri.parse('http://booking.mysoft.pk/api/user/profile-picture.php');

    try {
      var request = http.MultipartRequest('POST', uploadUrl)
        ..fields['id'] = '$id'
        ..files.add(await http.MultipartFile.fromPath('image', chosenImage!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle the response
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);

        if (jsonData["error"]) {
          print(jsonData["msg"]);
          Fluttertoast.showToast(msg: " ${jsonData["msg"]}",
            fontSize: 25, backgroundColor: Colors.green,
          );
        } else {
          print("Upload successful");
          Fluttertoast.showToast(msg: "Upload Successful!",
            fontSize: 25, backgroundColor: Colors.green,
          );
          String? photo = jsonData["photo"];
          // Upload successful, now handle the photo URL or other data
          if(photo != null) {
            SharedPreferences preferences = await SharedPreferences
                .getInstance();
            await preferences.setString('currentUserPhoto', photo);
            Fluttertoast.showToast(msg: " Locally Updated ",
              fontSize: 25, backgroundColor: Colors.green,
            );
          }
        }
      } else {
        print("Error during connection to server");
      }
    } catch (e) {
      print("*************    $e    *************");
    }
  }


  /*Future<void> uploadImage(int id, File? chosenImage) async {
    var uploadurl = Uri.parse('http://booking.mysoft.pk/api/user/upload-image.php');
    try{
      List<int> imageBytes = await chosenImage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
            'id':"$id",
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
          print("Upload successful");
          Fluttertoast.showToast(msg: "Upload successful",
            fontSize: 25, backgroundColor: Colors.green,
          );
          String? photo = jsondata["photo"];
          //upload successful now change the photo in shared preferences
          SharedPreferences preferences = await SharedPreferences.getInstance();
          if(photo != null) {
            await preferences.setString('currentUserPhoto', photo);
            Fluttertoast.showToast(msg: "Local Image Sync with online",
              fontSize: 25, backgroundColor: Colors.green,
            );
          } else {
            Fluttertoast.showToast(msg: "PHOTO IS NULL",
              fontSize: 25, backgroundColor: Colors.red,
            );
          }
        }
      }else{
        print("Error during connection to server");
        Fluttertoast.showToast(msg: "Error during connection to server",
          fontSize: 25, backgroundColor: Colors.red,
        );
      }
    }catch(e){
      print("*************    $e    *************");
      Fluttertoast.showToast(msg: e.toString(),
        fontSize: 25, backgroundColor: Colors.red,
      );
    }
  }*/

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
                          data!.photo.isEmpty ? AssetImage('assets/images/sam.jpg') as ImageProvider :
                          NetworkImage("${data.photo}"),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined),
                          onPressed: (){
                            showBottomSheet(
                                context: context, builder: (context){
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                          tileColor: Colors.green,
                                        leading: const Icon(Icons.camera, color: Colors.white,),
                                        title: const Text("From Camera", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                        onTap: (){
                                          Navigator.of(context).pop();

                                          pickImageFrom(ImageSource.camera, data!.id);
                                        },
                                      ),
                                      ListTile(
                                        tileColor:Colors.blue,
                                        leading: const Icon(Icons.browse_gallery, color: Colors.white,),
                                        title: const Text("From Gallery", style: TextStyle(
                                          color: Colors.white,
                                        ),),
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
                             /* Navigator.of(context).push(MaterialPageRoute(builder: (context)
                              {
                                return ImageUpload();
                              }
                              ));*/
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