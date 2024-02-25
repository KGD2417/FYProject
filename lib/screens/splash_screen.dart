import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vidyaniketan_app/screens/base_screen.dart';
import 'package:vidyaniketan_app/screens/driver_screen.dart';
import 'package:vidyaniketan_app/screens/dummy_screen.dart';
import 'package:vidyaniketan_app/screens/login.dart';
import 'package:vidyaniketan_app/utils/checkuser.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
        Column(
          children: [
            Center(
              child: LottieBuilder.asset("assets/images/Animation - 1708892026324.json"),
            )
          ],
        ),
      nextScreen: DummyScreen(),
      splashIconSize: 400,
    );
  }
}
