import 'package:flutter/material.dart';
import 'constaints.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xffFAFAFA),
    fontFamily: "Montserrat-Regular",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    iconTheme: iconTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    // enabledBorder: outlineInputBorder,
    // focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
    headline6: TextStyle(color: Colors.white60, fontSize: 18),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Color(0xFF5F4F84),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}

IconThemeData iconTheme() {
  return IconThemeData(color: Colors.white);
}
