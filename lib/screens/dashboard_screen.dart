import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text("Hi Faiz M", style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    color: Colors.white,
                  ),),
                  subtitle: Text("Welcome Back!", style: TextStyle(
                      color: Colors.white60
                  ),),
                  trailing: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://scontent.fisb3-3.fna.fbcdn.net/v/t39.30808-1/315988270_6265945786766687_4801831675516795154_n.jpg?stp=dst-jpg_p200x200&_nc_cat=100&ccb=1-7&_nc_sid=11e7ab&_nc_eui2=AeGn3gg47h8j3QqIKXtioXXKt4vvOr1kZgK3i-86vWRmAu9xVgZgyo4obOf36dgudMZHCMZ13KDnDMwVixpcjiPU&_nc_ohc=LGD4bdqNn8oAX-gxE4K&_nc_ht=scontent.fisb3-3.fna&oh=00_AfAqooLaDUx-45lbMcBohUoGHcRTiVlEGJUeb3k-3w2mmA&oe=65DE2794"),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Theme
                .of(context)
                .primaryColor,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100)
                  )
              ),
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                 //itemDashboard("Hello", CupertinoIcons.wand_rays_inverse, Colors.deepOrange)

                ],

              ),
            ),
          )
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Theme
                  .of(context)
                  .primaryColor
                  .withOpacity(.2),
              spreadRadius: 5,
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,

            ),
            child: Icon(iconData, color: Colors.white,),
          ),
          SizedBox(height: 8),
          Text(title, style: Theme
              .of(context)
              .textTheme
              .titleMedium,)
        ],
      ),
    );
  }
}


/*class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),),
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
                      return BeforeLogin();
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
}*/
