import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

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
  String phoneNumber = "";
  String busNo = "";
  String addr = "";
  String teacherName = "";
  File? _image;

  @override
  void initState() {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    usersRef.doc(auth?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      setState(() {
        studName = snapshot.get('fname');
        studName = "$studName "+snapshot.get('lname');
        className = className+snapshot.get("class").toString();
        rollNumber = rollNumber+snapshot.get("rollid").toString();
        phoneNumber = snapshot.get("number").toString();
        teacherName = snapshot.get("teachername").toString();
        busNo = snapshot.get("busNo").toString();
        addr = snapshot.get("addr").toString();
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
                        GestureDetector(
                          onTap: () async {
                            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            setState(() {
                              if (pickedFile != null) {
                                _image = File(pickedFile.path);
                              }
                            });
                          },
                          child: _image != null ? ClipOval(
                            child: Image.file(
                              _image!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ):
                          Image.asset(
                              "assets/images/profile.png",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.call,
                            color: Colors.blue.shade900,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(phoneNumber,style: TextStyle(
                            fontSize: 20
                          ),)
                        ],
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.teacher,
                            color: Colors.blue.shade900,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            teacherName,style: TextStyle(
                              fontSize: 20,
                          ),)
                        ],
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.bus,
                            color: Colors.blue.shade900,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "BusNumber: $busNo",
                            style: TextStyle(
                              fontSize: 20
                          ),)
                        ],
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            color: Colors.blue.shade900,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                              addr,style: TextStyle(
                                fontSize: 20
                            ),
                            softWrap: true,
                            ),
                          )
                        ],
                      ),
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