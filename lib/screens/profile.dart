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
  String className = "Class: ";
  String rollNumber = "Roll No: ";

  @override
  void initState() {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    usersRef.doc(auth?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('fname');
        studName = studName+" "+snapshot.get('lname');
        className = className+snapshot.get("class").toString();
        rollNumber = rollNumber+snapshot.get("rollid").toString();
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Color(0xFF0f6cbd),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage("assets/images/profile.png"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(studName,style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            Text(
                              className+" | "+rollNumber,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.white
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                  ,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFe4f1ff),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        ), //BoxShadow
                      ],
                    ),
                    child: Row(

                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFe4f1ff),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        ), //BoxShadow
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFe4f1ff),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        ), //BoxShadow
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFe4f1ff),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1,color: Color(0xFF0f6cbd)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        ), //BoxShadow
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      );
  }
}