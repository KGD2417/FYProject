import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/assign_screen.dart';
import 'package:vidyaniketan_app/screens/bus_list.dart';
import 'package:vidyaniketan_app/screens/events_list.dart';
import 'package:vidyaniketan_app/screens/home.dart';
import 'package:vidyaniketan_app/screens/lecture_screen.dart';
import 'package:vidyaniketan_app/screens/profile.dart';
import 'package:vidyaniketan_app/screens/stud_att_screen.dart';
import 'package:vidyaniketan_app/screens/stud_quiz.dart';

import '../widgets/drawer.dart';
import 'login.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {


  int _selectedIndex = 0;

  static const List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    AssignmentScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var kBottomNavigationBarItemSize = 24.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vidyaniketan",
          style: TextStyle(
              fontSize: 24,fontWeight: FontWeight.w600,color: Colors.white
          ),
        ),

          actions: <Widget>[
            PopupMenuButton(
              color: Color(0xFFe4f1ff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(0xFF0f6cbd),width: 1)
              ),
              icon: const Icon(Iconsax.global),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(child: Text("English",style: Theme.of(context).textTheme.bodyLarge,)),
                PopupMenuItem(child: Text("Hindi",style: Theme.of(context).textTheme.bodyLarge,)),
                PopupMenuItem(child: Text("Marathi",style: Theme.of(context).textTheme.bodyLarge,)),
              ],
            ),
          ]
      ),
      drawer: Drawer(backgroundColor: Color(0xFFe4f1ff),
    shadowColor: Colors.blue,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
    side: BorderSide(
    color: Color(0xFF0f6cbd), style: BorderStyle.solid, width: 2),),
    child: SingleChildScrollView(
    child: Column(
    children: [
    //Drawer Header
    Container(
    width: double.infinity,
    height: 200,
    color: Colors.blue,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset("assets/images/profile.png",height: 110),
    Text("Kshitij Desai",style: Theme.of(context).textTheme.headlineSmall,),
    ],
    ),
    ),
    //Home Tile
    ListTile(
    leading: const Icon(Icons.home),
    title: const Text("Home"),
    onTap: (){
    Navigator.pop(context);
    setState(() {
      _selectedIndex = 0;
    });
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Assignments
    ListTile(
    leading: const Icon(Icons.assignment),
    title: const Text("Assignments"),
    onTap: (){
    Navigator.pop(context);
    setState(() {
    _selectedIndex = 1;
    });
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Events
    ListTile(
    leading: const Icon(Icons.event),
    title: const Text("Events"),
    onTap: (){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EventListPage()));
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Bus tracking
    ListTile(
    leading: const Icon(Icons.gps_fixed),
    title: const Text("Bus Tracking"),
    onTap: (){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusListScreen()));
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Attendance
    ListTile(
    leading: const Icon(Icons.co_present_rounded),
    title: const Text("Attendance"),
    onTap: (){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAttendanceScreen()));
    },
    ),

    Divider(
    thickness: 1,
    ),
    //Report Card
    ListTile(
    leading: const Icon(Icons.description),
    title: const Text("Report Card"),
    onTap: (){
    Navigator.pop(context);
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Quiz
    ListTile(
    leading: const Icon(Icons.quiz),
    title: const Text("Quiz"),
    onTap: (){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizListScreen()));
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Profile Tile
    ListTile(
    leading: const Icon(Icons.account_circle_rounded),
    title: const Text("Profile"),
    onTap: (){
    Navigator.pop(context);
    setState(() {
      _selectedIndex = 3;
    });
    },
    ),

    Divider(
    thickness: 1,
    ),

    //Logout Tile
    ListTile(
    leading: const Icon(Icons.logout_rounded),
    title: const Text("Logout"),
    onTap: (){
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
    },
    )


    ],
    ),
    ),),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF0f6cbd),
          elevation: 50,
          iconSize: 55,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.home_outlined,size: kBottomNavigationBarItemSize,color: Colors.blueGrey,),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.assignment,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.assignment_outlined,size: kBottomNavigationBarItemSize,color: Colors.blueGrey),
              label: "Assignments",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_box,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.account_box_outlined,size: kBottomNavigationBarItemSize,color: Colors.blueGrey),
              label: "Profile",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
