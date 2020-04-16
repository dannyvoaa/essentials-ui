import 'package:flutter/material.dart';

class ColorConverter {
  /// Converts a specified color from Color to MaterialColor
  // - Source: https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });

    return MaterialColor(color.value, swatch);
  }
}

/// The official American Airlines color palette
class BrandColors {
  // Brand colors (Primary)
  static const Color blue = Color.fromRGBO(0, 120, 210, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);

  // Brand colors (Secondary)
  static const Color lightBlue = Color.fromRGBO(77, 180, 250, 1.0);
  static const Color darkBlue = Color.fromRGBO(0, 70, 127, 1.0);
  static const Color green = Color.fromRGBO(0, 185, 137, 1.0);
  static const Color yellowGreen = Color.fromRGBO(209, 213, 50, 1.0);
  static const Color lightOrange = Color.fromRGBO(250, 175, 0, 1.0);
  static const Color orange = Color.fromRGBO(255, 115, 24, 1.0);
  static const Color red = Color.fromRGBO(195, 0, 25, 1.0);
  static const Color lightGray = Color.fromRGBO(208, 218, 224, 1.0);
  static const Color gray = Color.fromRGBO(157, 166, 171, 1.0);
  static const Color darkGray = Color.fromRGBO(54, 73, 90, 1.0);
  static const Color black = Color.fromRGBO(19, 19, 19, 1.0);
}

/// Common colors used across the application (seperate from American Airlines color palette)
class CustomColors {
  static const Color footer = Color.fromRGBO(0, 0, 0, 0.050);
  static const Color separator = BrandColors.gray;
  static const Color transparent = Color.fromRGBO(255, 255, 255, 0.0);
}