import 'package:flutter/material.dart';

import 'attendance_screen.dart';

class TeachScreen extends StatefulWidget {
  const TeachScreen({super.key});

  @override
  State<TeachScreen> createState() => _TeachScreenState();
}

class _TeachScreenState extends State<TeachScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Screen"),
      ),
      body: Center(child: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceScreen()));
      }, child: Text("Open Attendance"))),
    );
  }
}
