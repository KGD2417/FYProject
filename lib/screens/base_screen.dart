import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/assign_screen.dart';
import 'package:vidyaniketan_app/screens/home.dart';
import 'package:vidyaniketan_app/screens/lecture_screen.dart';

import '../widgets/drawer.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AssignmentScreen(),
    LectureScreen(),
    HomeScreen(),
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
      ),
      drawer: MyDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.home_outlined,size: kBottomNavigationBarItemSize),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.assignment,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.assignment_outlined,size: kBottomNavigationBarItemSize),
              label: "Assignments",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.view_timeline,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.view_timeline_outlined,size: kBottomNavigationBarItemSize),
              label: "Lectures",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_box,size: kBottomNavigationBarItemSize),
              icon: Icon(Icons.account_box_outlined,size: kBottomNavigationBarItemSize),
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