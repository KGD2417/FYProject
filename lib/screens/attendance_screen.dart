import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  var temp = [];


  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where(
      'class',
      isEqualTo: ww,
    ).snapshots();

    return SafeArea(
        child: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {

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
    if (temp.contains(
    snapshot.data!.docChanges[index].doc['username'])) {
    temp.remove(
    snapshot.data!.docChanges[index].doc['username']);
    } else {
    temp.add(
    snapshot.data!.docChanges[index].doc['username']);
    }
    });
    print(temp);
    setState(() {});
    },
    child: Card(
    child: ListTile(
    title:
    Text(snapshot.data!.docChanges[index].doc['username']),
    trailing: Container(
    height: 40,
    width: 100,
    decoration: BoxDecoration(
    color: temp.contains(snapshot
        .data!.docChanges[index].doc['username'])
    ? Color.fromARGB(255, 248, 20, 4)
        : Color.fromARGB(255, 0, 228, 8),
    borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
    child: Text(
    temp.contains(snapshot
        .data!.docChanges[index].doc['username'])
    ? 'Remove'
        : 'add',
    style: TextStyle(
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
