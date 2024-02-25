import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/utils/checkuser.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {

  @override
  void initState() {
    CheckUser().isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}
