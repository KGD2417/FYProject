import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/widgets/drawer.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Screen",style: TextStyle(fontSize: 20),),
      ),
      drawer: MyDrawer(),
    );
  }
}
