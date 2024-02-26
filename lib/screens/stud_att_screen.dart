import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/utils/date.dart' as date_util;
import 'package:percent_indicator/circular_percent_indicator.dart';


class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {

  DateTime fullDate = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  // final QuerySnapshot attendanceStream;
  // final QuerySnapshot totalStream;
  String presPerc="";
  String absePerc="";
  double percentage=0;
  double abPerc=0;
  String classNo="";
  String rollID="";
  String present1 = "";

  Future<void> getUser() async{
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');


    usersRef.doc(user!.phoneNumber.toString()).get().then((DocumentSnapshot documentsnapshot){
      setState(() {
        classNo = documentsnapshot.get('class');
        rollID = documentsnapshot.get('rollid');

      });
      print(classNo);
      print(rollID);

      getDate(classNo, rollID);
    });
  }

  Future<void> getDate(String classs,String roll) async{
    print(classs);
    print(roll);
    CollectionReference divRef = FirebaseFirestore.instance.collection('class${classs}Att');
    divRef.doc('${"${fullDate.day} " + date_util.DateUtils.months[fullDate.month - 1]} ${fullDate.year}').get().then((DocumentSnapshot documentsnapshot){
      setState(() {
        present1 = documentsnapshot.get(roll);
      });

      print(present1);
      getCount(classs,roll,present1);
    }).onError((e,_){
      getCount(classs,roll,"Absent");
    });


  }
  Future<void> getCount(String classs,String roll,String present) async {


    final QuerySnapshot attendanceStream = await FirebaseFirestore.instance
        .collection('class${classs}Att')
        .where(
      roll,
      isEqualTo: "P",
    ).get();


    final QuerySnapshot totalStream = await FirebaseFirestore.instance.collection('class${classs}Att').get();

    int attLen = attendanceStream.docs.length;
    int fullLen = totalStream.docs.length;




    setState(() {
      percentage = (attLen/fullLen) * 100;
      abPerc = 100 - percentage;
      presPerc = percentage.toStringAsFixed(2);
      absePerc= abPerc.toStringAsFixed(2);

      // presPerc = "$percentage%";
      // absePerc = "$abPerc%";
      if(present!="P"){
        present1 = "Absent";
      }
      else{
        present1 = "Present";
      }
    });


    print(presPerc);
    print(absePerc);
    print(present1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getUser();
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Attendance",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 165,
              width: double.infinity,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFe4f1ff),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Color(0xFF0f6cbd)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your Overall Attendance",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 35,
                              lineWidth: 8,
                              percent: percentage!/100,
                              progressColor: Colors.deepPurpleAccent,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(presPerc,style: Theme.of(context).textTheme.titleLarge,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Presents",style: Theme.of(context).textTheme.titleLarge,),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 35,
                              lineWidth: 8,
                              percent: abPerc/100,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(absePerc,style: Theme.of(context).textTheme.titleLarge,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Absents",style: Theme.of(context).textTheme.titleLarge,),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text("Today's Attendance",style: TextStyle(
                      color: Colors.blueAccent.shade700,
                      fontSize: 15
                    )),
                  ),
                  Expanded(child: Divider(
                    color: Colors.blueAccent.shade700,
                  ))
                ],
              ),
            ),

            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFe4f1ff),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Color(0xFF0f6cbd)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${"${fullDate.day} " + date_util.DateUtils.months[fullDate.month - 1]} ${fullDate.year}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      present1,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text("Last 7 Days",style: TextStyle(
                        color: Colors.blueAccent.shade700,
                        fontSize: 15
                    )),
                  ),
                  Expanded(child: Divider(
                    color: Colors.blueAccent.shade700,
                  ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
