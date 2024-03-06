import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/widgets/time_days.dart';

import '../widgets/days_list.dart';
import 'bus_screen.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {

  final auth = FirebaseAuth.instance.currentUser;

  final CollectionReference timetable = FirebaseFirestore.instance.collection('timetable');

  String today = "";

  String className = "";

  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;


  Stream<QuerySnapshot> getTimeStreams(){
    final timeStream = timetable.doc("class$className").collection(today).snapshots();
    return timeStream;
  }

  @override
  void initState() {
    today = DateFormat('EEE').format(DateTime.now()).toString();
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    usersRef.doc(auth?.phoneNumber.toString()).get().then((DocumentSnapshot snapshot){
      className = snapshot.get('class');
      setState(() {

      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Table",style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.w600,color: Colors.white
        ),),
      ),
      body:
        Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  )
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          decoration: BoxDecoration(
                            color: daysList[index].currentDay ? Color(0xFF0f6cbd): Color(0xFFe4f1ff),
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
                          child: InkWell(
                            onTap: () {
                              if(daysList[index].actualName=="Mon"){
                                today = "Mon";
                                daysList[0].currentDay=true;
                                daysList[1].currentDay=false;
                                daysList[2].currentDay=false;
                                daysList[3].currentDay=false;
                                daysList[4].currentDay=false;
                              }
                              else if(daysList[index].actualName=="Tue"){
                                today = "Tue";
                                daysList[0].currentDay=false;
                                daysList[1].currentDay=true;
                                daysList[2].currentDay=false;
                                daysList[3].currentDay=false;
                                daysList[4].currentDay=false;
                              }
                              else if(daysList[index].actualName=="Wed"){
                                today = "Wed";
                                daysList[0].currentDay=false;
                                daysList[1].currentDay=false;
                                daysList[2].currentDay=true;
                                daysList[3].currentDay=false;
                                daysList[4].currentDay=false;
                              }
                              else if(daysList[index].actualName=="Thu"){
                                today = "Thu";
                                daysList[0].currentDay=false;
                                daysList[1].currentDay=false;
                                daysList[2].currentDay=false;
                                daysList[3].currentDay=true;
                                daysList[4].currentDay=false;
                              }
                              else if(daysList[index].actualName=="Fri"){
                                today = "Fri";
                                daysList[0].currentDay=false;
                                daysList[1].currentDay=false;
                                daysList[2].currentDay=false;
                                daysList[3].currentDay=false;
                                daysList[4].currentDay=true;
                              }
                              setState(() {

                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(daysList[index].name,style: TextStyle(
                                    color: daysList[index].currentDay? Colors.white:Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: daysList.length,
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: timetable.doc("class$className").collection(today).snapshots(),
              builder: (context,snapshots){
                if(snapshots.hasData){
                  List timeList = snapshots.data!.docs;

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: timeList.length,
                      itemBuilder: (context,index){

                        DocumentSnapshot document =timeList[index];
                        String docId =document.id;

                        //get busNo from each doc
                        Map<String,dynamic> data =
                        document.data() as Map<String,dynamic>;

                        String duration = data['duration'].toString();
                        String subject = data['sub'].toString();
                        String teacher = data['teacher'].toString();


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(

                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                  color: Colors.black,

                                )
                            ),
                            title: Text(
                              docId+" : "+subject,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Duration: "+duration,style: TextStyle(
                                  fontSize: 16
                                ),)
                              ],
                            ),
                            subtitle: Text("Teacher: "+teacher),
                          ),
                        );


                      });
                }
                else{
                  return const Text("No lectures..");
                }
              },
            ),
          ],
        )
    );
  }
}

