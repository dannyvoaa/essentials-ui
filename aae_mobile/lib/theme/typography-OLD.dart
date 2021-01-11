import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// Common typography constants to be used across the whole application.
/// This class only exists for easy importing!

class AaeTextStyles {
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _bold = FontWeight.bold;
  static const _americanSans = 'AmericanSans';
  static const _americanSansMedium = 'AmericanSansMedium';

  static const font = 'AmericanSans';


  static const title40Med140 = TextStyle(
    fontSize: 40.0,
    height: 1.40,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const title32Med125 = TextStyle(
    fontSize: 32.0,
    height: 1.25,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const title28Med143 = TextStyle(
    fontSize: 28.0,
    height: 1.43,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const title24Med110 = TextStyle(
    fontSize: 24.0,
    height: 1.1,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const title20Med120 = TextStyle(
    fontSize: 20.0,
    height: 1.20,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const body16Med125 = TextStyle(
    fontSize: 16.0,
    height: 1.25,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const subtitle18Med = TextStyle(
    fontSize: 18.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const subtitle18Reg110 = TextStyle(
    color: AaeColors.darkGray,
    fontSize: 18,
    height: 1.1,
  );

  static const caption12Med = TextStyle(
    fontSize: 12.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
    color: AaeColors.darkGray,
  );

  static const btn16Med150 = TextStyle(
    fontSize: 16.0,
    height: 1.50,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn16Med = TextStyle(
    fontSize: 16.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn14Med142 = TextStyle(
    fontSize: 14.0,
    height: 1.42,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn14Med = TextStyle(
    fontSize: 14.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const title20Reg160 = TextStyle(
    fontSize: 20.0,
    height: 1.60,
    fontWeight: _regular,
  );

  // static const title20 = TextStyle(
  //   fontSize: 20.0,
  //   height: 1.0,
  //   fontWeight: _regular,
  // );

  static const body16Reg150 = TextStyle(
    fontSize: 16.0,
    height: 1.50,
    fontWeight: _regular,
  );

  // static const body16 = TextStyle(
  //   fontSize: 16.0,
  //   height: 1.0,
  //   fontWeight: _regular,
  // );

  static const body14Reg143 = TextStyle(
    fontSize: 14.0,
    height: 1.43,
    fontWeight: _regular,
  );

  // static const body14 = TextStyle(
  //   fontSize: 14.0,
  //   height: 1.0,
  //   fontWeight: _regular,q
  // );

  static const caption12Reg150 = TextStyle(
    fontSize: 12.0,
    height: 1.50,
    letterSpacing: 0.30,
    fontWeight: _regular,
  );

  static const caption11Reg150 = TextStyle(
    fontSize: 11.0,
    height: 1.50,
    letterSpacing: 0.30,
    fontWeight: _regular,
  );
  ///BOOLEAN ---------------------------------------------
  ///
  /// Used for regular-sized body content
  // static TextStyle body16({
  //   bool boolDefaultHeight = false,
  // }) {
  //   TextStyle textStyle = TextStyle(
  //     color: AaeColors.darkGray,
  //     fontFamily: _americanSans,
  //     fontSize: 16,
  //     height: boolDefaultHeight ? 1.00 : 1.33,
  //     // backgroundColor: AaColors.lightGray,
  //   );
  //
  //   // Default style
  //   return textStyle;
  // }
  ///BOOLEAN ---------------------------------------------
  static TextStyle calendarMain({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = TextStyle(
      color: AaeColors.darkGray,
      fontFamily: _americanSans,
      fontSize: 16,
      height: boolDefaultHeight ? 1.00 : 1.33,
      // backgroundColor: AaColors.lightGray,
    );

    // Default style
    return textStyle;
  }
///BOOLEAN ---------------------------------------------
  static TextStyle calendarOld({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = TextStyle(
      color: AaeColors.ultraLightGray,
      fontFamily: _americanSans,
      fontSize: 16,
      height: boolDefaultHeight ? 1.00 : 1.33,
      // backgroundColor: AaColors.lightGray,
    );

    // Default style
    return textStyle;
  }

  /// Travel module text styles
  static const caption12GrayMed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AaeColors.ultraLightGray,
  );

  static const subtitle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AaeColors.titleGray,
  );

  static const title22Bold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AaeColors.titleGray,
  );

  // static const body14 = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.normal,
  //   color: AaeColors.titleGray,
  // );

  static const caption12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AaeColors.titleGray,
  );

  static const caption12GreenMed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AaeColors.green,
  );

  static const caption12DarkOrangeMed = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AaeColors.red,
  );

  // static const body14 = TextStyle(
  //   fontSize: 14,
  //   fontWeight: FontWeight.normal,
  //   color: AaeColors.titleGray,
  // );

  static const caption12Gray = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AaeColors.ultraLightGray,
  );

  static const caption13GrayLS10 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AaeColors.ultraLightGray,
    letterSpacing: 10,
  );

  static const subtitle18Bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AaeColors.titleGray,
    fontFamily: _americanSansMedium,
  );

  // static const btn18 = TextStyle(
  //   fontSize: 22,
  //   fontWeight: FontWeight.normal,
  // );

  static final caption12MediumGrayMed = TextStyle(
    color: AaeColors.darkOrange,
    fontWeight: _medium,
    fontSize: 12,
  );


  /// Travel module text styles
  static const subtitle15BlueBold100 = TextStyle(
    fontSize: 15,
    color: AaeColors.blue,
    fontWeight: FontWeight.bold,
  );

  static const title24GrayMed = TextStyle(
    fontSize: 24,
    color: AaeColors.gray,
    fontFamily: _americanSansMedium,
  );

  static const subtitle15Gray = TextStyle(
    fontSize: 15,
    color: AaeColors.gray,
    fontFamily: _americanSans,
  );

  static const caption13LightGray = TextStyle(
    fontSize: 13,
    color: AaeColors.lightGrayText,
    fontFamily: _americanSans,
  );

  // static const btn18 = TextStyle(
  //   fontSize: 18,
  //   color: AaeColors.white,
  //   fontFamily: _americanSans,
  // );

  static const caption12DarkRedMed = TextStyle(
    fontSize: 12,
    color: AaeColors.red,
    fontFamily: _americanSansMedium,
  );

  static const caption12CadetGray = TextStyle(
    fontSize: 12,
    color: AaeColors.lightGrayText,
  );

  static const title32MediumGrayMed = TextStyle(
    fontSize: 32,
    color: AaeColors.mediumGray,
    fontFamily: _americanSansMedium,
  );

  static const subtitle18MediumGray = TextStyle(
    fontSize: 18,
    color: AaeColors.mediumGray,
    fontFamily: _americanSans,
  );

  /// Calendar page summary blocks
  /// BOOLEAN ---------------------------------------------------------
  static TextStyle caption13({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = TextStyle(
      color: AaeColors.darkGray,
      fontFamily: _americanSans,
      fontSize: 13,
      height: boolDefaultHeight ? 1.00 : 1.33,
      // backgroundColor: AaColors.lightGray,
    );

    // Default style
    return textStyle;
  }

  /// BOOLEAN ----------------------------------------------------------
  static TextStyle caption13Bold({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = TextStyle(
      color: AaeColors.darkGray,
      fontFamily: _americanSans,
      fontSize: 13,
      fontWeight: FontWeight.bold,
      height: boolDefaultHeight ? 1.00 : 1.33,
      // backgroundColor: AaColors.lightGray,
    );

    // Default style
    return textStyle;
  }

  static TextStyle subtitle18Bold1165({
    bool boolDefaultHeight = false,
    bool boolEnabled = true,
  }) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.darkGray,
      fontSize: 18,
      height: 1.165,
      fontWeight: FontWeight.bold,
    );
    // Default style
    return textStyle;
  }

  // static TextStyle subtitle18CadetGray({
  //   bool boolDefaultHeight = false,
  //   bool boolEnabled = true,
  // }) {
  //   TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
  //     color: AaeColors.lightGray,
  //     fontSize: 18,
  //   );
  //   // Default style
  //
  //   return textStyle;
  // }

  // static TextStyle subtitle18Gray({
  //   bool boolDefaultHeight = false,
  //   bool boolEnabled = true,
  // }) {
  //   TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
  //     color: AaeColors.lightGray.withOpacity(.60),
  //     fontSize: 18,
  //   );
  //   // Default style
  //
  //   return textStyle;
  // }

  /// Used for regular-sized headline content
  static TextStyle body16Bold({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontWeight: FontWeight.bold,
    );

    // Default style
    return textStyle;
  }

  /// Used for regular-sized titles
  static TextStyle title20({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 20,
    );

    // Default style
    return textStyle;
  }

  /// Used for large-sized titles; matches the 'subTitleLarge' text style
  static TextStyle title50CadetGrayBold({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    );

    // Default style
    return textStyle;
  }

  /// Used for large-sized sub-title; matches the 'titleLarge' text style
  static TextStyle subtitle18CadetGray({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
      fontSize: 18,
    );

    // Default style
    return textStyle;
  }

  /// Used for regular-sized description content
  static TextStyle body14({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 14,
      height: 1,
    );

    // Default style
    return textStyle;
  }

  // static TextStyle subtitle18Gray(
  //     {bool boolDefaultHeight = false, bool boolEnabled = true}) {
  //   TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
  //     color: AaeColors.ultraLightGray,
  //     fontSize: 18,
  //   );
  //
  //   // Default style
  //   return textStyle;
  // }

  static TextStyle title20GrayBold() {
    //TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(color: AaeColors.red, fontSize: 18);
    //TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold);
    TextStyle mytextStyle = TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold);
    // Default style
    return mytextStyle;
  }

  /// Used for Event detail layout
  static TextStyle title22Med({bool boolDefaultHeight = false}) {
    TextStyle textStyle = title24Med110.copyWith(
      color: AaeColors.darkGray,
      height: 1.0,
      fontSize: 22,
    );

    // Default style
    return textStyle;
  }

  static TextStyle body16({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.darkGray,
      height: 1.0,
    );

    // Default style
    return textStyle;
  }

  static TextStyle body14Reg150({bool boolDefaultHeight = false}) {
    TextStyle textStyle = caption11Reg150.copyWith(
      color: AaeColors.darkGray,
      fontSize: 14,
    );

    // Default style
    return textStyle;
  }

  /// Used for the title in [LargeButton]
  static TextStyle btn18({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.white,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      height: 1.0,
    );

    // Default style
    return textStyle;
  }

  // Used for placeholders / hints in a [TextField]
  static TextStyle title24MediumGray({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.modernHint,
      fontSize: 24,
    );

    // Default style
    return textStyle;
  }

  // Used for user-entered content in a [TextField]
  static TextStyle subtitle18DarkBlue({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 18,
      color: AaeColors.darkBlue,
    );

    // Default style
    return textStyle;
  }

  // Used for user-entered content in a [TextField]
  static TextStyle subtitle18Gray({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body16(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 18,
      color: AaeColors.gray,
    );

    // Default style
    return textStyle;
  }

  static const title24Bold110 = TextStyle(fontSize: 24, fontWeight: _bold, color: AaeColors.onboardTitle);
}
