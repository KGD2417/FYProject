import 'package:flutter/material.dart';
import 'package:vidyaniketan_app/screens/bus_screen.dart';
import 'package:vidyaniketan_app/screens/login.dart';
import 'package:vidyaniketan_app/themes/theme.dart';
import 'package:vidyaniketan_app/utils/checkuser.dart';

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
        home: LoginScreen());
  }
}