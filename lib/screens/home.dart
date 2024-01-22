import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vidyaniketan",
            style: TextStyle(
                fontSize: 24,fontWeight: FontWeight.w600,color: Colors.white
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
