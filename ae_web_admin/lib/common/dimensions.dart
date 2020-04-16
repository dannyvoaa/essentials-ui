import 'package:flutter/widgets.dart';

class Dimensions {

  /// Returns the Safe Area insets
  static EdgeInsets safeArea ({@required BuildContext buildContext}) {
    return MediaQuery.of(buildContext).padding;
  }

  // Common sizes
  static const double sizeDivider = 0.33;
  static const double size1px = 1.0;
  static const double size2px = 2.0;
  static const double size4px = 4.0;
  static const double size8px = 8.0;
  static const double size16px = 16.0;
  static const double size24px = 24.0;
  static const double size32px = 32.0;
  static const double size48px = 48.0;
  static const double size64px = 64.0;
  static const double size128px = 128.0;
  static const double size256px = 256.0;
  static const double size512px = 512.0;
  static const double size1024px = 1024.0;

  // Input form sizes
  static const double buttonHeight = 36.0;
  static const double rowTitle = 128.0;
  static const double textFieldCommon = 256.0;
}