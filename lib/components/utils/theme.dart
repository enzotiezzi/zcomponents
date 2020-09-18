import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData appTheme = new ThemeData(
    primarySwatch:  MaterialColor(
      0xFF2BBAB4,
      <int, Color>{
        50: Color(0xFFE6F7F6),
        100: Color(0xFFBFEAE9),
        200: Color(0xFF95DDDA),
        300: Color(0xFF6BCFCB),
        400: Color(0xFF4BC4BF),
        500: Color(0xFF2BBAB4),
        600: Color(0xFF26B3AD),
        700: Color(0xFF20ABA4),
        800: Color(0xFF1AA39C),
        900: Color(0xFF10948C),
      },
    ),
    primaryColor:  Color(0xFF2BBAB4),
    accentColor:  Color(0xFF801F92),
    primaryColorLight:  Color(0xFF31D4CC),
    primaryColorDark:  Color(0xFF1F8782),
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    backgroundColor: Color(0xFFF0F0F0) ,
    scaffoldBackgroundColor:  Color(0xFFF0F0F0),
    textTheme:  TextTheme(
      display4: new TextStyle(
          fontSize: 96.0, fontWeight: FontWeight.w100, letterSpacing: -1.5),
      display3: new TextStyle(
          fontSize: 60.0, fontWeight: FontWeight.w200, letterSpacing: -0.5),
      display2: new TextStyle(
          fontSize: 48.0, fontWeight: FontWeight.normal, letterSpacing: 0.0),
      display1: new TextStyle(
          fontSize: 34.0, fontWeight: FontWeight.normal, letterSpacing: 0.25),
      headline: new TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.normal, letterSpacing: 0.0),
      title: new TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subhead: new TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      body2: new TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.normal, letterSpacing: 0.1),
      body1: new TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.normal, letterSpacing: 0.5),
      caption: new TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.normal, letterSpacing: 0.25),
      button: new TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.75),
      subtitle: new TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.4),
      overline: new TextStyle(
          fontSize: 10.0, fontWeight: FontWeight.normal, letterSpacing: 1.5),
    ),
    buttonTheme:  ButtonThemeData(
      buttonColor: Color(0xFF801F92),
      disabledColor: Color(0xFFCCCCCC),
      splashColor: Color(0xFF6D177F),
      textTheme: ButtonTextTheme.primary,
    ),
    dividerTheme:  DividerThemeData(
      color: Color(0xFFF0F0F0),
      thickness: 1.0,
    ),
    iconTheme:  IconThemeData(
      color: Color(0xFF801F92),
    ),
    appBarTheme:  AppBarTheme(
      color: Color(0xFF2BBAB4),
      iconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
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
      splashColor:  Color(0xFF6D177F),
      foregroundColor: Color(0xFFFFFFFF),
    ),
  );
}
