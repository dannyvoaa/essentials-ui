import 'package:flutter/material.dart';

/// Wrapper for all colors we use in Aae.
/// This class only exists for easy importing!
class AaeColors {
  static const white = Colors.white;
  static const Color tableViewCellBackgroundSelected = Color.fromRGBO(0, 120,
      210, 0.05); // not sure what this brand blue opacity is suppoed to be???
  static const Color tableViewCellBackground =
      Color.fromRGBO(255, 255, 255, 1.0); // white

  // General Text
  static const defaultText = Color.fromRGBO(
      255, 255, 255, 0.9); // #E6E6E6 - replace with 'ultraLightGray'
  static const secondaryText =
      Color.fromRGBO(255, 255, 255, 0.6); // #999999 - replace with 'gray'
  static const disabledText =
      Color.fromRGBO(255, 255, 255, 0.4); // #666666 - replace with 'mediumGray'
  static const linkText =
      Color.fromRGBO(0, 229, 255, 1.0); // #00E5FF - replace with 'teal'
  static const premiumText = Color.fromRGBO(
      141, 91, 255, 1.0); // replace with 'premium'. Do we need both?
  static const modernHint = Color.fromRGBO(
      255, 255, 255, 0.4); // this is a duplicate of disabledText above

  // Button Text
  static const buttonPrimaryText = Color.fromRGBO(32, 33, 36, 1.0);
  static const buttonPrimaryDisabledText = Color.fromRGBO(32, 33, 36, 0.6);
  static const buttonSecondaryText = Color.fromRGBO(255, 255, 255, 0.9);
  static const buttonSecondaryDisabledText = Color.fromRGBO(255, 255, 255, 0.3);
  static const buttonHairlineText = Color.fromRGBO(255, 255, 255, 0.9);
  static const buttonHairlineDisabledText = Color.fromRGBO(255, 255, 255, 0.2);

  // Container (used to combine information into groups, like list rows & cards)
  static const primaryContainer = Color.fromRGBO(255, 255, 255, 0.06);
  static const secondaryContainer = Color.fromRGBO(255, 255, 255, 0.03);
  static const transparentContainer = Colors.transparent;

  // Surface (elements that sit on top of backgrounds & containers, like icons)
  static const primarySurface = Color.fromRGBO(255, 255, 255, 0.9);
  static const secondarySurface = Color.fromRGBO(255, 255, 255, 0.3);

  // Button
  static const buttonPrimaryBackground = Color.fromRGBO(255, 255, 255, 0.9);
  static const buttonPrimaryDisabledBackground =
      Color.fromRGBO(255, 255, 255, 0.6);
  static const buttonSecondaryBackground = Color.fromRGBO(255, 255, 255, 0.2);
  static const buttonSecondaryDisabledBackground =
      Color.fromRGBO(255, 255, 255, 0.03);
  static const buttonHairlineBackground = Color.fromRGBO(255, 255, 255, 0.6);
  static const buttonHairlineDisabledBackground =
      Color.fromRGBO(255, 255, 255, 0.2);

  // Informative (indicates states or branding)
  static const success = Color.fromRGBO(76, 175, 80, 1.0); // #4CAF50 - green
  static const error = Color.fromRGBO(211, 47, 47, 1.0); // #D32F2F - red
  static const update =
      Color.fromRGBO(211, 47, 47, 1.0); // this is a duplicate of the one above
  static const primary =
      Color.fromRGBO(0, 229, 255, 1.0); // #00E5FF - bright teal
  static const premium = Color.fromRGBO(141, 91, 255, 1.0); // #8D5BFF - purple

  // Brand palette - blues
  static const blue = Color.fromRGBO(0, 120, 210, 1); //#0078D2
  static const detriotBlue = Color.fromRGBO(0, 97, 171, 1); //#0061AB
  static const darkBlue = Color.fromRGBO(0, 70, 127, 1); //#00467F
  static const lightBlue = Color.fromRGBO(77, 180, 250, 1); //#4DB4FA
  static const teal = Color.fromRGBO(177, 225, 235, 1.0); //#B1E1EB
  static const highlightBlue = Color.fromRGBO(225, 240, 250, 1.0); //#E1F0FA
  // Brand palette - grays
  static const black = Color.fromRGBO(19, 19, 19, 1.0); //#131313
  static const darkGray = Color.fromRGBO(54, 73, 90, 1.0); //#36495A
  static const darkCadetGray = Color.fromRGBO(70, 87, 98, 1.0); //#465762 - new
  static const cadetGray = Color.fromRGBO(83, 103, 115, 1.0); //#536773 - new
  static const mediumGray = Color.fromRGBO(98, 122, 136, 1.0); //#627A88
  static const gray = Color.fromRGBO(157, 166, 171, 1.0); //#9DA6AB
  static const lightGray = Color.fromRGBO(208, 218, 224, 1.0); //#D0DAE0
  static const halfwayLightGray =
      Color.fromRGBO(231, 236, 239, 1.0); //#E7ECEF - new
  static const ultraLightGray = Color.fromRGBO(235, 239, 240, 1.0); //#EBEFF0
  static const superUltraLightGray =
      Color.fromRGBO(245, 245, 247, 1.0); //#F5F7F7
  static const extremeUltraLightGray =
      Color.fromRGBO(250, 251, 251, 1.0); //#FAFBFB

  //to replace
  static const lightGray = Color.fromRGBO(
      112, 112, 112, 1.0); //replace with cadetGray then delete from here
  static const titleGray = Color.fromRGBO(
      54, 73, 90, 1.0); //replace with "darkGrey" then delete from here
  static const ultraLightGray = Color.fromRGBO(185, 188, 190,
      1.0); //replace with "gray" then delete and keep the ultraLigntGray above

  // Brand palette - not blue or gray
  static const darkRed = Color.fromRGBO(195, 0, 25, 1.0); //#C30019
  static const red = Color.fromRGBO(245, 35, 5, 1.0); //#F52305
  static const orange = Color.fromRGBO(255, 115, 24, 1.0); //#FF7318
  static const darkOrange = Color.fromRGBO(209, 73, 4, 1.0); //#D14904
  static const lightOrange = Color.fromRGBO(250, 175, 0, 1.0); //#FAAF00
  static const yellowGreen = Color.fromRGBO(209, 213, 50, 1.0); //#D1D532
  static const green = Color.fromRGBO(0, 135, 18,
      1.0); //#008712 - new values for brand green. This was already declared as recognitionGreen in Misc Colors below.
  static const backgroundBlue = Color.fromRGBO(50, 120, 203, 1.0); //#3278CB

  // Misc Colors
  static const highlightText =
      Color.fromRGBO(247, 94, 70, 1); //#F75E46 - moved to Misc Colors
  static const cardGradient =
      Color.fromRGBO(29, 54, 68, 1); // #1D3644 - dark bluegreen
  static const headerBackgroupd =
      Color.fromRGBO(2, 147, 255, 1); // #0293FF - medium blue
  static const recognitionGreen =
      Color.fromRGBO(0, 185, 137, 1.0); //#00B989 - green
  static const gradientTop = Color.fromRGBO(77, 180, 250,
      1.0); //this can be replaced with 'lightBlue' and then removed from this section

  // Text
  static const screenSelectorText =
      Color.fromRGBO(255, 255, 255, 0.9); // white with 90% opacity
  static const screenSelectorSubtext =
      Color.fromRGBO(255, 255, 255, 0.6); // white with 60% opacity
  static const screenSelectorIcon = Color.fromRGBO(196, 196, 196,
      1.0); // #C4C4C4 - not a brand gray - if it exists, should be replaced with 'gray' then removed
  static const screenSelectorDisabledIcon = Color.fromRGBO(196, 196, 196,
      0.6); // #C4C4C4 with 60% opacity - not a brand gray - if it exists, should be replaced with 'lightGray' then removed

  // Material Theme Colors
  static const materialPrimary =
      Color.fromRGBO(247, 94, 70, 1.0); // #F75E46 - coral - can probably remove
  static const materialPrimaryVariant = Color.fromRGBO(
      214, 59, 56, 1.0); // #D63B38 - reddish - can probably remove

  // Text field
  static const textFieldFillColor = Color.fromRGBO(0, 0, 0,
      0.3); // black with 30% opacity is a gray. Replace with 'gray' if this exists
  static const primaryBackground =
      Color.fromRGBO(32, 33, 36, 1.0); // #202124 can be replaced with 'black'

  //Gradient Colors
  static const appBarGradient =
      LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,
//      stops: [0.1, 0.4, 0.6, 0.9],
          colors: [AaeColors.blue, AaeColors.gradientTop]);

  static const newsAppBarGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [
        0.4,
        1.0,
      ],
      colors: [
        AaeColors.blue,
        AaeColors.gradientTop
      ]);

  static const tickerGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.01,
        0.4,
      ],
      colors: [
        Color(0xFFbac3c8),
        Color.fromRGBO(208, 218, 224, 1.0)
      ]);
}
