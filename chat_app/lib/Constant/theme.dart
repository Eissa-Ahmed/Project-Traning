import 'package:chat_app/Constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData? lightTheme = ThemeData(
  appBarTheme: customAppBar(
    backgroundColor: Colors.white,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    colorTitle: primaryColor,
  ),
  scaffoldBackgroundColor: Colors.white,
);

AppBarTheme customAppBar({
  required Color? backgroundColor,
  required Color? statusBarColor,
  required Color? colorTitle,
  required Brightness? statusBarIconBrightness,
}) {
  return AppBarTheme(
    titleTextStyle: TextStyle(
      color: colorTitle,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: backgroundColor!,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
    ),
  );
}

//Dark Theme
ThemeData? darkTheme = ThemeData(
  appBarTheme: customAppBar(
    backgroundColor: Colors.black,
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    colorTitle: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
);
