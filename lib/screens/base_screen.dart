import 'package:cloud_firestore/cloud_firestore.dart';
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
  final auth = FirebaseAuth.instance;
  String studName = "";

  static const List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    AssignmentScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    final user = auth.currentUser;
    usersRef.doc(user?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('fname');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var kBottomNavigationBarItemSize = 24.0;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Vidyaniketan",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: <Widget>[
            PopupMenuButton(
              color: Color(0xFFe4f1ff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Color(0xFF0f6cbd), width: 1)),
              icon: const Icon(Iconsax.global),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    child: Text(
                  "English",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                PopupMenuItem(
                    child: Text(
                  "Hindi",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                PopupMenuItem(
                    child: Text(
                  "Marathi",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ],
            ),
          ]),
      drawer: Drawer(
        backgroundColor: Color(0xFFe4f1ff),
        shadowColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          side: BorderSide(
              color: Color(0xFF0f6cbd), style: BorderStyle.solid, width: 2),
        ),
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
                    Image.asset("assets/images/profile.png", height: 110),
                    Text(
                      studName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),

              //Home Tile
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),

                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Assignments
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text("Assignments"),

                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Events
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventListPage()));
                },
                child: ListTile(
                  leading: const Icon(Icons.event),
                  title: const Text("Events"),

                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Bus tracking
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BusListScreen()));
                },
                child: ListTile(
                  leading: const Icon(Icons.gps_fixed),
                  title: const Text("Bus Tracking"),
                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Attendance
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAttendanceScreen()));
                },
                child: ListTile(
                  leading: const Icon(Icons.co_present_rounded),
                  title: const Text("Attendance"),
                ),
              ),

              Divider(
                thickness: 1,
              ),
              //Report Card
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text("Report Card"),

                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Quiz
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizListScreen()));
                },
                child: ListTile(
                  leading: const Icon(Icons.quiz),
                  title: const Text("Quiz"),
                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Profile Tile
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                child: ListTile(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text("Profile"),
                ),
              ),

              Divider(
                thickness: 1,
              ),

              //Logout Tile
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                child: ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text("Logout"),
                ),
              )
            ],
          ),
        ),
      ),
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
              activeIcon: Icon(Icons.home, size: kBottomNavigationBarItemSize),
              icon: Icon(
                Icons.home_outlined,
                size: kBottomNavigationBarItemSize,
                color: Colors.blueGrey,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon:
                  Icon(Icons.assignment, size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.assignment_outlined,
                  size: kBottomNavigationBarItemSize, color: Colors.blueGrey),
              label: "Assignments",
            ),
            BottomNavigationBarItem(
              activeIcon:
                  Icon(Icons.account_box, size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.account_box_outlined,
                  size: kBottomNavigationBarItemSize, color: Colors.blueGrey),
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
