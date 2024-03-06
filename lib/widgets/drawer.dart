import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';


class AltDrawer extends StatefulWidget {
  const AltDrawer({super.key});


  @override
  State<AltDrawer> createState() => _AltDrawerState();
}

class _AltDrawerState extends State<AltDrawer> {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFe4f1ff),
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
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Assignments
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text("Assignments"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Events
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text("Events"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Bus tracking
            ListTile(
              leading: const Icon(Icons.gps_fixed),
              title: const Text("Bus Tracking"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Attendance
            ListTile(
              leading: const Icon(Icons.co_present_rounded),
              title: const Text("Attendance"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
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

            const Divider(
              thickness: 1,
            ),

            //Quiz
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text("Quiz"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Profile Tile
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text("Profile"),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const Divider(
              thickness: 1,
            ),

            //Logout Tile
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Logout"),
              onTap: (){
                FirebaseAuth.instance.signOut().then((value)
                {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
                });
              },
            )


          ],
        ),
      ),
    );
  }
}
