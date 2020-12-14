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

  /// 50px BASE title text -----------------------------------------------------------------------50px--
  static const TextStyle title50 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 50,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: titleLarge
  static final title50_cadetGray_bold = title50.copyWith(
    color: AaeColors.cadetGray,
    fontWeight: _bold,
  );

  /// 40px BASE title text -----------------------------------------------------------------------40px--
  static const TextStyle title40 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 40,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: h1
  static final title40_medium_140 = title40.copyWith(
    fontWeight: _medium,
    height: 1.40,
  );

  /// 32px BASE title text -----------------------------------------------------------------------32px--
  static const TextStyle title32 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 32,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: largeTextStyle
  static final title32_mediumGray_medium = title32.copyWith(
    color: AaeColors.mediumGray,
    fontWeight: _medium,
  );
  /// Replaces: h2
  static final title32_medium_125 = title32.copyWith(
    fontWeight: _medium,
    height: 1.25,
  );
  /// Add where this style is used
  static final title32_medium = title32.copyWith(
    fontWeight: _medium,
  );
  /// 28px BASE title text -----------------------------------------------------------------------28px--
  static const TextStyle title28 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 28,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: h3
  static final title28_medium_143 = title28.copyWith(
      fontWeight: _medium,
      height: 1.43
  );

  /// 24px BASE title text -----------------------------------------------------------------------24px--
  static const TextStyle title24 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 24,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: h4 -
  /// Used: Selected date in PL and FS date pickers,
  static final title24_medium_110 = title24.copyWith(
      fontWeight: _medium,
      height: 1.10
  );
  /// Replaces: h4
  /// Used: unselected date in PL and FS date pickers,
  static final title24_mediumGray_medium_110 = title24.copyWith(
      fontWeight: _medium,
      color: AaeColors.gray,
      height: 1.10
  );
  /// Replaces: pageHeadLine
  static final title24_bold_110 = title24.copyWith(
      fontWeight: bold,
      height: 1.10
  );

  /// 22px BASE title text -----------------------------------------------------------------------22px--
  static const TextStyle title22 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 22,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: eventTitle
  static final title22_medium_110 = title22.copyWith(
      fontWeight: _medium,
      height: 1.10
  );
  /// 20px BASE title text -----------------------------------------------------------------------20px--
  /// Replaces: b1SingleLine, title
  static const TextStyle title20 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 20,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: b1
  static final title20_160 = title20.copyWith(
      height: 1.10
  );
  /// Replaces: h5
  static final title20_medium_120 = title20.copyWith(
      fontWeight: _medium,
      height: 1.20
  );

  /// 18px BASE title text -----------------------------------------------------------------------18px--
  /// Replaces: largeTextStyle - Used: passenger list
  static const TextStyle subtitle18 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Replaces: smallHeadline
  static final subtitle18_medium = subtitle18.copyWith(
    fontWeight: _medium,
  );
  /// Replaces: newsCardHeadline
  static final subtitle18_110 = subtitle18.copyWith(
    height: 1.10,
  );
  /// Replaces: tableHeaderFooter
  static final subtitle18_bold_1165 = subtitle18.copyWith(
    fontWeight: _bold,
    height: 1.165,
  );
  /// Replaces: smallTextStyle - Used: flight inventory card, flight number, gate, departure time
  static final subtitle18_mediumGray = subtitle18.copyWith(
    color: AaeColors.mediumGray,
  );
  /// Replaces: smallTextStyle - Used: flight inventory card cabin names
  static final subtitle18_mediumGray_scale14 = subtitle18.copyWith(
    color: AaeColors.mediumGray,
    fontSize: viewModel.priorityList.cabins.length >= 4 ? 14 : 18,
  );
  /// Replaces: subTitleLarge, tabelCellTitle
  static final subtitle18_cadetGray = subtitle18.copyWith(
    color: AaeColors.cadetGray,
  );
  /// Replaces: tableCellValue
  static final subtitle18_gray = subtitle18.copyWith(
    color: AaeColors.gray,
  );
  /// Replaces: textFieldModern
  static final subtitle18_darkBlue = subtitle18.copyWith(
    color: AaeColors.darkBlue,
  );
  /// Replaces: largeTextStyleSeatAssigned - Used: priority list
  static final subtitle18_green = subtitle18.copyWith(
    color: AaeColors.green,
  );
  /// Replaces: largeTextStyleSeatAssigned - Used: priority list
  static final subtitle18_white = subtitle18.copyWith(
    color: AaeColors.white,
  );
  /// 16px BASE title text -----------------------------------------------------------------------16px--
  /// Replaces: b2SingleLine, body, calendarMain
  static const TextStyle body16 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 16,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: boolDefaultHeight ? 1.00 : 1.33,
  );
  /// Replaces: b2
  static final body16_150 = body16.copyWith(
    height: 1.50,
  );
  /// Replaces: h6
  static final body16_medium_125 = body16.copyWith(
    fontWeight: _medium,
    height: 1.25,
  );
  /// Replaces: headline
  static final body16_bold = body16.copyWith(
    fontWeight: _bold,
  );

  /// 15px BASE title text -----------------------------------------------------------------------15px--
  static const TextStyle subtitle15 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 15,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final subtitle15_medium = subtitle15.copyWith(
    fontWeight: _medium,
  );
  /// Add where this style is used
  static final subtitle15_blue_bold = subtitle15.copyWith(
    color: AaeColors.blue,
    fontWeight: _bold,
  );

  /// 14px BASE title text -----------------------------------------------------------------------14px--
  /// Replaces: priorityCodeTextStyle - Used: priority list
  static const TextStyle body14 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 14,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final body14_143 = body14.copyWith(
    height: 1.43,
  );
  /// Replaces: secondRowTextStyle
  static final body14_gray = body14.copyWith(
    color: AaeColors.gray,
  );


  /// 13px BASE title text -----------------------------------------------------------------------13px--
  static const TextStyle caption13 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 13,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final caption13_bold_133 = caption13.copyWith(
    fontWeight: _bold,
    height: boolDefaultHeight ? 1.00 : 1.33,
  );
  /// Replaces: ? - Used month and date PL and FS date pickers,
  static final caption13_mediumGray = caption13.copyWith(
    color: AaeColors.mediumGray,
  );

  /// 12px BASE title text -----------------------------------------------------------------------12px--
  static const TextStyle caption12 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 12,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final caption12_150 = caption12.copyWith(
    height: 1.50,
  );
  /// Add where this style is used
  static final caption12_medium = caption12.copyWith(
    fontWeight: _medium,
  );
  /// Used: Stops indicator between multiple flights on a card, flight status,
  static final caption12_darkOrange_medium = caption12.copyWith(
    color: AaeColors.darkOrange,
    fontWeight: _medium,
  );
  /// Used: flight status,
  static final caption12_green_medium = caption12.copyWith(
    color: AaeColors.green,
    fontWeight: _medium,
  );
  /// Used: flight status,
  static final caption12_darkRed_medium = caption12.copyWith(
    color: AaeColors.darkRed,
    fontWeight: _medium,
  );
  /// 11px BASE title text -----------------------------------------------------------------------11px--
  static const TextStyle caption11 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 11,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final caption11_150 = caption11.copyWith(
    height: 1.50,
  );
  /// Add where this style is used
  static final caption11_gray_medium = caption11.copyWith(
    color: AaeColors.gray,
    fontWeight: _medium,
  );

  /// BASE for BUTTON text --------------------------------------------------------------BUTTONS-----------
  /// Base classes = class name and size, white color, regular weight, 1.0 height
  /// Final classes = class name and size + color if different + weight if different + height if different
  static const TextStyle btn18 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: AaeColors.white,
    fontWeight: _regular,
    height: 1.00,
  );
  /// Add where this style is used
  static final btn16_medium = btn18.copyWith(
    fontSize: 16,
    fontWeight: _medium,
  );
  /// Add where this style is used
  static final btn16_medium_150 = btn18.copyWith(
    fontSize: 16,
    fontWeight: _medium,
    height: 1.50,
  );
  /// Add where this style is used
  static final btn14_medium = btn18.copyWith(
    fontSize: 14,
    fontWeight: _medium,
  );
  /// Add where this style is used
  static final btn14_medium_150 = btn18.copyWith(
    fontSize: 14,
    fontWeight: _medium,
    height: 1.50,
  );