import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/assign_screen.dart';
import 'package:vidyaniketan_app/screens/home.dart';
import 'package:vidyaniketan_app/screens/lecture_screen.dart';
import 'package:vidyaniketan_app/screens/profile.dart';

import '../widgets/drawer.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AssignmentScreen(),
    LectureScreen(),
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