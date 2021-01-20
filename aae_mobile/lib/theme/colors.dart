import 'package:flutter/material.dart';

/// Wrapper for all colors we use in AMERICAN ESSENTIALS.

class AaeColors {
  /// WHITE
  static const white100 = Color.fromRGBO(255, 255, 255, 1);
  static const white90 = Color.fromRGBO(255, 255, 255, 0.9);
  static const white80 = Color.fromRGBO(255, 255, 255, 0.8);
  static const white70 = Color.fromRGBO(255, 255, 255, 0.7);
  static const white60 = Color.fromRGBO(255, 255, 255, 0.6);
  static const white50 = Color.fromRGBO(255, 255, 255, 0.5);
  static const white40 = Color.fromRGBO(255, 255, 255, 0.4);
  static const white30 = Color.fromRGBO(255, 255, 255, 0.3);
  static const white20 = Color.fromRGBO(255, 255, 255, 0.2);
  static const white10 = Color.fromRGBO(255, 255, 255, 0.1);
  static const white03 = Color.fromRGBO(255, 255, 255, 0.03);

  /// BLACK and GRAYS
  static const black = Color.fromRGBO(19, 19, 19, 1.0); // #131313
  static const darkGray = Color.fromRGBO(54, 73, 90, 1.0); // #36495A
  static const darkCadetGray = Color.fromRGBO(70, 87, 98, 1.0); // #465762
  static const cadetGray = Color.fromRGBO(83, 103, 115, 1.0); // #536773
  static const mediumGray = Color.fromRGBO(98, 122, 136, 1.0); // #627A88
  static const gray = Color.fromRGBO(157, 166, 171, 1.0); // #9DA6AB
  static const lightGray = Color.fromRGBO(208, 218, 224, 1.0); //#D0DAE0
  static const halfwayLightGray = Color.fromRGBO(208, 218, 224, 1.0); //#E7ECEF
  static const ultraLightGray = Color.fromRGBO(235, 239, 240, 1.0); //#EBEFF0
  static const superUltralightGray = Color.fromRGBO(245, 245, 227, 1.0); //#F5F7F7
  static const extremeUltraLightGray = Color.fromRGBO(250, 251, 251, 1.0); //#FAFBFB

  /// COLORS - BRAND PALETTE
  static const darkBlue = Color.fromRGBO(0, 70, 127, 1); // #00467F
  static const detroitBlue = Color.fromRGBO(0, 97, 171, 1); // #0061AB
  static const blue = Color.fromRGBO(0, 120, 210, 1); // #0078D2
  static const lightBlue = Color.fromRGBO(77, 180, 250, 1); // #4DB4FA
  static const teal = Color.fromRGBO(177, 225, 235, 1.0); // #B1E1EB
  static const highlightBlue = Color.fromRGBO(225, 240, 250, 1.0); // #E1F0FA
  static const darkRed = Color.fromRGBO(195, 0, 25, 1.0); // #C30019
  static const red = Color.fromRGBO(245, 35, 5, 1.0); // #F52305
  static const darkOrange = Color.fromRGBO(209, 73, 4, 1.0); // #d14904
  static const orange = Color.fromRGBO(255, 115, 24, 1.0); // #ff7318
  static const lightOrange = Color.fromRGBO(250, 175, 0, 1.0); // #faaf00
  static const green = Color.fromRGBO(0, 135, 18, 1.0); // #008712
  static const yellowGreen = Color.fromRGBO(209, 213, 50, 1.0); // #d1d532

  /// COLORS - EXTRA
  static const recognitionGreen = Color.fromRGBO(0, 185, 137, 1.0); // #00B989
  static const brightTeal = Color.fromRGBO(0, 229, 255, 1.0); // #00e5ff
  static const tickerGray = Color.fromRGBO(186, 195, 200, 1.0); // #BAC3C8

  /// COLORS - GRADIENTS
  // header bar used without ticker bar
  static const appBarGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [AaeColors.blue, AaeColors.lightBlue]);

  // the ticker gradient is included in this header bar
  static const newsAppBarGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [0.4, 1.0,],
      colors: [AaeColors.blue, AaeColors.lightBlue]);

  // waiting to hear back from Natalie on this gray
  static const tickerGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.01, 0.4,],
      colors: [AaeColors.tickerGray, AaeColors.lightGray]);
}