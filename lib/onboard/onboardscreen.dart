import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
