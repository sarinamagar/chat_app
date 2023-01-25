import 'package:flutter/material.dart';

import '../common/constant/fonts.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xffFFFFFF);
  static const double symmetricHozPadding = 25.0;
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFFEAEEF4);
  static const Color darkGray = Color(0xFFAEAFB2);
  static const Color lightGray = Color(0xFFd9d9d9);
  static const Color lightTextColor = Color(0xfff5f5f5);
  static const Color darkTextColor = Color(0xff847F7F);
  static const Color blue1 = Color(0xFF9FCCFB);
  static const Color blue2 = Color(0xFFAECEF5);
  static const Color blue3 = Color(0xFFD4EDFC);
  static Color shadowColor = const Color(0xFF000000).withOpacity(0.5);

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: black,
    shadowColor: shadowColor,
    scaffoldBackgroundColor: black,
    fontFamily: Fonts.quickSand,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 24),
      headline2: TextStyle(
          color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 22),
      headline3: TextStyle(
          color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 20),
      headline4: TextStyle(fontSize: 18, color: darkTextColor),
      headline5: TextStyle(color: darkTextColor, fontSize: 16),
      headline6: TextStyle(
          color: darkTextColor, fontSize: 14, fontWeight: FontWeight.w300),
      caption: TextStyle(color: darkTextColor, fontSize: 8),
      subtitle2: TextStyle(color: darkTextColor, fontSize: 12),
      subtitle1: TextStyle(color: darkTextColor, fontSize: 10),
      button: TextStyle(color: darkTextColor, fontSize: 12),
      bodyText1: TextStyle(fontSize: 12, color: darkTextColor),
      bodyText2: TextStyle(fontSize: 10, color: darkTextColor),
    ),
  );
}
