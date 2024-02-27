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
              color: Colors.red, // Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Ahad!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Good Morning', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/user.JPG'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Videos', CupertinoIcons.play_rectangle, Colors.deepOrange),
                  itemDashboard('Analytics', CupertinoIcons.graph_circle, Colors.green),
                  itemDashboard('Audience', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard('Comments', CupertinoIcons.chat_bubble_2, Colors.brown),
                  itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo),
                  itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                  itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent),
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
              blurRadius: 5
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white)
        ),
        const SizedBox(height: 8),
        Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium)
      ],
    ),
  );
}

/*
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
              child: Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                   itemDashboard("Hello", CupertinoIcons.wand_rays_inverse, Colors.deepOrange)
                  ],
                
                ),
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
*/

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