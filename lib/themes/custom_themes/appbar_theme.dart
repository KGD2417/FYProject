import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EAppBarTheme{
  EAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    foregroundColor: Colors.white,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Color(0xFF0f6cbd),
    surfaceTintColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  );

  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black,size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)
  );


}