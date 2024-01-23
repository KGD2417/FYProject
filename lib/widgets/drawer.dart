import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueAccent,
      child: Column(
        children: [
          //Drawer Header
          const DrawerHeader(child: Icon(Icons.add_chart)),

          //Home Tile
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: (){
              Navigator.pop(context);
            },
          ),

          //Profile Tile
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: const Text("Profile"),
            onTap: (){
              Navigator.pop(context);
            },
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
    );
  }
}
