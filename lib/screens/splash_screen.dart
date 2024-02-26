import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vidyaniketan_app/screens/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
      nextScreen: LoginScreen(),
      splashIconSize: 400,
    );
  }
}
