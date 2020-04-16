import 'package:american_essentials_web_admin/theme/colors.dart';
import 'package:flutter/widgets.dart';

enum ColorVariant {
  Dark,
  Light,
}

enum TitleStyle {
  Title1,
  Title2,
  Title3,
}

class TextStyles {
  static const String fontName = 'AmericanSans';

  /// Determines a TextStyle's color from a given ColorVariant
  static Color _colorForVariant({@required ColorVariant colorVariant}) {
    Color color;

    // Check to see which color variant was requested
    if (colorVariant == ColorVariant.Dark) {
      color = BrandColors.black;
    } else if (colorVariant == ColorVariant.Light) {
      color = BrandColors.white;
    }

    return color;
  }

  /// Used for regular-sized body content
  static TextStyle body({ColorVariant colorVariant = ColorVariant.Dark}) {
    return TextStyle(
      color: _colorForVariant(colorVariant: colorVariant),
      fontFamily: fontName,
      fontSize: 14.0,
      height: 1.30,
    );
  }

  /// Used for headline-sized body content
  static TextStyle bodyLarge({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      fontSize: 16.0,
      height: 1.33,
    );
  }

  /// Used for body-sized error content
  static TextStyle error({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      color: BrandColors.red,
    );
  }

  /// Used for headline-sized body content
  static TextStyle headline({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  /// Used for headline-sized body content
  static TextStyle headlineLarge(
      {ColorVariant colorVariant = ColorVariant.Dark}) {
    return bodyLarge(colorVariant: colorVariant).copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  /// Used for headline-sized body content
  static TextStyle processing({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      fontSize: 15.0,
      height: 1.315,
    );
  }

  /// Used for title content (largest size)
  static TextStyle title1({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      color: BrandColors.darkBlue,
      fontSize: 24.0,
      height: 1.33,
    );
  }

  /// Used for title content (larger size)
  static TextStyle title2({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      color: BrandColors.darkBlue,
      fontSize: 18.0,
      height: 1.33,
    );
  }

  /// Used for title content (body size)
  static TextStyle title3({ColorVariant colorVariant = ColorVariant.Dark}) {
    return body(colorVariant: colorVariant).copyWith(
      color: BrandColors.darkBlue,
    );
  }
}
