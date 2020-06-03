import 'package:aae/theme/colors.dart';
import 'package:flutter/painting.dart';

/// Common typography constants to be used across the whole application.
/// This class only exists for easy importing!

class AaeTextStyles {
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _bold = FontWeight.bold;
  static const _americanSans = 'AmericanSans';

  static const h1 = TextStyle(
    fontSize: 40.0,
    height: 1.40,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const h2 = TextStyle(
    fontSize: 32.0,
    height: 1.25,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const h3 = TextStyle(
    fontSize: 28.0,
    height: 1.43,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const h4 = TextStyle(
    fontSize: 24.0,
    height: 1.33,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const h5 = TextStyle(
    fontSize: 20.0,
    height: 1.20,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const h6 = TextStyle(
    fontSize: 16.0,
    height: 1.25,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn1 = TextStyle(
    fontSize: 16.0,
    height: 1.50,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn1SingleLine = TextStyle(
    fontSize: 16.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn2 = TextStyle(
    fontSize: 14.0,
    height: 1.42,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const btn2SingleLine = TextStyle(
    fontSize: 14.0,
    height: 1.0,
    fontWeight: _medium,
    fontFamily: _americanSans,
  );

  static const b1 = TextStyle(
    fontSize: 20.0,
    height: 1.60,
    fontWeight: _regular,
  );

  static const b1SingleLine = TextStyle(
    fontSize: 20.0,
    height: 1.0,
    fontWeight: _regular,
  );

  static const b2 = TextStyle(
    fontSize: 16.0,
    height: 1.50,
    fontWeight: _regular,
  );

  static const b2SingleLine = TextStyle(
    fontSize: 16.0,
    height: 1.0,
    fontWeight: _regular,
  );

  static const b3 = TextStyle(
    fontSize: 14.0,
    height: 1.43,
    fontWeight: _regular,
  );

  static const b3SingleLine = TextStyle(
    fontSize: 14.0,
    height: 1.0,
    fontWeight: _regular,
  );

  static const c1 = TextStyle(
    fontSize: 12.0,
    height: 1.50,
    letterSpacing: 0.30,
    fontWeight: _regular,
  );

  static const t2 = TextStyle(
    fontSize: 11.0,
    height: 1.50,
    letterSpacing: 0.30,
    fontWeight: _regular,
  );

  /// Used for regular-sized body content
  static TextStyle body({
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

  static TextStyle tableHeaderFooter({
    bool boolDefaultHeight = false,
    bool boolEnabled = true,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.darkGray,
      fontSize: 16,
      height: 1.165,
    );
    // Default style
    return textStyle;
  }

  static TextStyle tableCellTitle({
    bool boolDefaultHeight = false,
    bool boolEnabled = true,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
    );
    // Default style

    return textStyle;

  }

  /// Used for regular-sized headline content
  static TextStyle headline({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontWeight: FontWeight.bold,
    );

    // Default style
    return textStyle;
  }

  /// Used for regular-sized titles
  static TextStyle title({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 20,
    );

    // Default style
    return textStyle;
  }

  /// Used for large-sized titles; matches the 'subTitleLarge' text style
  static TextStyle titleLarge({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    );

    // Default style
    return textStyle;
  }

  /// Used for large-sized sub-title; matches the 'titleLarge' text style
  static TextStyle subTitleLarge({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
      fontSize: 18,
    );

    // Default style
    return textStyle;
  }

  /// Used for regular-sized description content
  static TextStyle description({
    bool boolDefaultHeight = false,
  }) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 14,
      height: 1.165,
    );

    // Default style
    return textStyle;
  }

  static TextStyle tableCellValue(
      {bool boolDefaultHeight = false, bool boolEnabled = true}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.lightGray,
    );

    // Default style
    return textStyle;
  }

  /// Used for the title in [LargeButton]
  static TextStyle largeButtonTitle({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.0,
    );

    // Default style
    return textStyle;
  }

  // Used for placeholders / hints in a [TextField]
  static TextStyle textFieldModernHint({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.modernHint,
      fontSize: 24,
    );

    // Default style
    return textStyle;
  }

  // Used for user-entered content in a [TextField]
  static TextStyle textFieldModern({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 24,
    );

    // Default style
    return textStyle;
  }

  static const pageHeadline = TextStyle(fontSize: 24, fontWeight: _bold);
}
