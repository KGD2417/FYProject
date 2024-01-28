
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/base_screen.dart';
import 'package:vidyaniketan_app/screens/driver_screen.dart';
import 'package:vidyaniketan_app/screens/home.dart';
import 'package:vidyaniketan_app/screens/login.dart';
import 'package:vidyaniketan_app/screens/teacher_screen.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    String role = "";
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            User? user = snapshot.requireData;
            CollectionReference usersRef = FirebaseFirestore.instance.collection('users');


            usersRef.doc(user!.phoneNumber.toString()).get().then((DocumentSnapshot documentsnapshot){
              role = documentsnapshot.get('role');
            });

            if(role=="stud") {
              return BaseScreen();
            }
            else if(role=="driver"){
              return DriverScreen();
            }
            else if(role=="teacher"){
              return TeachScreen();
            }
            else{
              print("Role ID is: "+role);
              return LoginScreen();
            }

          }
          else {
            return LoginScreen();
          }

        },
      ),
    );
  }
}