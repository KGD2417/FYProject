import 'package:vidyaniketan/features/authentication/screens/login/login.dart';
import 'package:vidyaniketan/features/authentication/screens/login/otp_login.dart';
import 'package:vidyaniketan/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Vidyaniketan",
        debugShowCheckedModeBanner: false,

        //Themes
        themeMode: ThemeMode.light,
        theme: EAppTheme.lightTheme,
        darkTheme: EAppTheme.darkTheme,
        home: const LoginScreen());
  }
}
