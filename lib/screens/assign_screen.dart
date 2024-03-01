import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'assign_page.dart';

class HomeAssignmentScreen extends StatefulWidget {
  const HomeAssignmentScreen({super.key});

  @override
  State<HomeAssignmentScreen> createState() => _HomeAssignmentScreenState();
}

class _HomeAssignmentScreenState extends State<HomeAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments"),
        centerTitle: true,
      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('assign')
              .doc('Class1')
              .collection('Subcollections')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LottieBuilder.asset(
                    "assets/images/Loading.json",
                  )
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No subcollections found under Class1.'),
              );
            }

            return Container(
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.black),
                // borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var subcollectionName = snapshot.data!.docs[index].id;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssignPage(listName: subcollectionName),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(subcollectionName),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
    );
  }
}



class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('assign')
                .doc('Class1')
                .collection('Subcollections')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LottieBuilder.asset(
                      "assets/images/Loading.json",
                    )
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No subcollections found under Class1.'),
                );
              }

              return Container(
                decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  // borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var subcollectionName = snapshot.data!.docs[index].id;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignPage(listName: subcollectionName),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(subcollectionName),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
      ),
    );
  }
}


