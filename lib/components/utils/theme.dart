import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = Color(0xFF2BBAB4);
  static Color accentColor  = Color(0xFF801F92);

  static ThemeData appTheme = new ThemeData(
    primaryColor: Color(0xFF2BBAB4),
    accentColor:  Color(0xFF801F92),
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    backgroundColor: Color(0xFFF0F0F0) ,
    scaffoldBackgroundColor:  Color(0xFFF0F0F0),
    textTheme:  TextTheme(
      headline1: new TextStyle(
          fontSize: 96.0, fontWeight: FontWeight.w100, letterSpacing: -1.5),
      headline2: new TextStyle(
          fontSize: 60.0, fontWeight: FontWeight.w200, letterSpacing: -0.5),
      headline3: new TextStyle(
          fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0.0),
      headline4: new TextStyle(
          fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5: new TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0),
      headline6: new TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1: new TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2: new TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1: new TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2: new TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button: new TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25,),
      caption: new TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: new TextStyle(
          fontSize: 10.0, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ),
    buttonTheme:  ButtonThemeData(
      buttonColor: Color(0xFF801F92),
      disabledColor: Color(0xFFCCCCCC),
      textTheme: ButtonTextTheme.primary,
    ),
    dividerTheme:  DividerThemeData(
      color: Color(0xFFF0F0F0),
      thickness: 1.0,
    ),
    iconTheme:  IconThemeData(
      color: Color(0xFF801F92),
      size: 24,
    ),
    appBarTheme:  AppBarTheme(
      color: Color(0xFF2BBAB4),
      iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
          size: 24
      ),
      textTheme: new TextTheme(
        title: new TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
            color: Color(0xFFFFFFFF)),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
    ),
    disabledColor:  Color(0xFFCCCCCC),
    bottomAppBarTheme:  BottomAppBarTheme(
      color:  Color(0xFF2BBAB4),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF801F92),
      foregroundColor: Color(0xFFFFFFFF),
    ),

  );
}
