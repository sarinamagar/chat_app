import 'package:flutter/material.dart';
import 'package:forum/app/theme.dart';

import 'fonts.dart';

class CustomTextStyle {
  static const TextStyle outlineButton = TextStyle(
    color: CustomTheme.black,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: Fonts.quickSand,
  );
  static const TextStyle roundedButton = TextStyle(
    color: CustomTheme.primaryColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: Fonts.quickSand,
  );
  static const TextStyle labelText = TextStyle(
    color: CustomTheme.darkTextColor,
    fontSize: 16,
    fontFamily: Fonts.quickSand,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle hintText = TextStyle(
    color: CustomTheme.darkGray,
    fontFamily: Fonts.quickSand,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
  );
  static const TextStyle heading1 = TextStyle(
    color: CustomTheme.black,
    fontFamily: Fonts.quickSand,
    fontWeight: FontWeight.w500,
    fontSize: 26,
  );
  static const TextStyle subHeading = TextStyle(
    color: CustomTheme.black,
    fontFamily: Fonts.quickSand,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static const TextStyle heading4 = TextStyle(
    color: CustomTheme.black,
    fontFamily: Fonts.quickSand,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle boldHeading4 = TextStyle(
    color: CustomTheme.black,
    fontFamily: Fonts.quickSand,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
}
