import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vidyaniketan_app/utils/date.dart' as date_util;

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  var ww = '1';
  var options = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  var _currentItemSelected = "1";
  var rool = "1";

  var rollNo = [];




  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where(
      'class',
      isEqualTo: ww,
    ).snapshots();

    DateTime fullDate = DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(fullDate);
    String formattedDate = '${"${fullDate.day} " + date_util.DateUtils.months[fullDate.month - 1]} ${fullDate.year}';

    return SafeArea(
        child: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          var rolls = <String, String>{};
          for(int i=0;i<rollNo.length;i++){
            rolls[rollNo[i].toString()] = "P";
          }
          if(ww=="1"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class1Att');
              class1.doc(formattedDate).set(rolls).then((value){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Attendance Saved"),
                ));
                Navigator.pop(context);
              }).onError((e, _){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error Occurred"),
                ));
              });
          }
          else if(ww=="2"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class2Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="3"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class3Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="4"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class4Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="5"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class5Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="6"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class6Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="7"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class7Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="8"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class8Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else if(ww=="9"){
            CollectionReference class1 = FirebaseFirestore.instance.collection('class9Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
          else{
            CollectionReference class1 = FirebaseFirestore.instance.collection('class10Att');
            class1.doc(formattedDate).set(rolls).then((value){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Attendance Saved"),
              ));
              Navigator.pop(context);
            }).onError((e, _){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error Occurred"),
              ));
            });
          }
        },
        child: Icon(
        Icons.send,
        ),
        ),

    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Attendance Page',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          DropdownButton<String>(
            dropdownColor: Colors.blue[900],
            isDense: true,
            isExpanded: false,
            iconEnabledColor: Colors.white,
            focusColor: Colors.white,
            items: options.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValueSelected) {
              setState(() {
                _currentItemSelected = newValueSelected!;
                rool = newValueSelected;

                ww = '';
                ww = _currentItemSelected;
              });
            },
            value: _currentItemSelected,
          ),
        ],
      ),
    ),

          body: StreamBuilder(
            stream: _usersStream,
            builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
            ),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                    // 1019
                      setState(() {
                        if (rollNo.contains(snapshot.data!.docChanges[index].doc['rollid'])) {
                          rollNo.remove(snapshot.data!.docChanges[index].doc['rollid']);
                        }
                        else {
                          rollNo.add(snapshot.data!.docChanges[index].doc['rollid']);
                        }
                      });
                      print(rollNo);
                      setState(() {});
                  },
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docChanges[index].doc['username']+" - "+snapshot.data!.docChanges[index].doc['rollid']),
                        trailing: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: rollNo.contains(snapshot
                                .data!.docChanges[index].doc['rollid'])
                            ? Color.fromARGB(255, 248, 20, 4)
                                : Color.fromARGB(255, 0, 228, 8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              rollNo.contains(snapshot
                                  .data!.docChanges[index].doc['rollid'])
                              ? 'Remove'
                                  : 'add',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                  ),
                  ),
                  );
    },
    ),
    );
    },
    ),
    ),



    );
  }
}
