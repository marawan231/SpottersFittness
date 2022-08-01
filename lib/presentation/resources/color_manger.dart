import 'package:flutter/material.dart';

class ColorManager {
  static const Color myPink = Color(0xFFF814B4);
  static const Color myPurble = const Color(0xFFA758E5);
  static Color myLightBlue = const Color(0xFFC4DAFF);
  static Color myDarkBlue = const Color(0xFF40C6B6);
  static Color myWhite = const Color(0xFFFFFFFF);
  static Color myGrey = const Color(0xFF9A9A9A);
  static Color myIconGrey = const Color(0xFF4A4A4A);
  static Color myLightGrey = const Color(0xFFF9EFFF);

  static const gradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF814B4),
      Color(0xFFA020F0),
    ],
  );
  static const appBarGradientColor = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFFF814B4),
      Color(0xFFA020F0),
    ],
  );
}
