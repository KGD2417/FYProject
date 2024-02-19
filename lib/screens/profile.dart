import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final auth = FirebaseAuth.instance.currentUser;
  String studName="";

  @override
  void initState() {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    usersRef.doc(auth?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('username');
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/images/profile.png",height: 160,width: 160,),
                      Text(studName,style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),)
                    ],
                  )
                  ,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Color(0xFF0f6cbd),
                  ),
                )
              ],
            )
          ),
        ),
      );
  }
}