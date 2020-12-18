import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// Common typography constants to be used across the whole application.
/// This class only exists for easy importing!
/// Naming order = name (title), size (50), color (Gray), weight (Med), line height (133)

class AaeTextStyles {
  static const _regular = FontWeight.w400;
  static const _americanSans = 'AmericanSans';
  static const _americanSansMedium = 'AmericanSansMedium';
  static const _americanSansBold = 'AmericanSansBold';

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
  static final title50CadetGrayBold = title50.copyWith(
    fontFamily: _americanSansBold,
    color: AaeColors.cadetGray,
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
  static final title40Med140 = title40.copyWith(
    fontFamily: _americanSansMedium,
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
  static final title32MediumGrayMed = title32.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.mediumGray,
  );

  /// Replaces: h2
  static final title32Med125 = title32.copyWith(
    fontFamily: _americanSansMedium,
    height: 1.25,
  );

  /// Add where this style is used
  static final title32Med = title32.copyWith(
    fontFamily: _americanSansMedium,
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
  static final title28Med143 = title28.copyWith(
      fontFamily: _americanSansMedium,
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
  static final title24Med110 = title24.copyWith(
      fontFamily: _americanSansMedium,
      height: 1.10
  );

  /// Replaces: h4
  /// Used: unselected date in PL and FS date pickers,
  static final title24MediumGrayMed110 = title24.copyWith(
      fontFamily: _americanSansMedium,
      color: AaeColors.gray,
      height: 1.10
  );

  /// Replaces: pageHeadLine
  static final title24Bold110 = title24.copyWith(
      fontFamily: _americanSansBold,
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
  static final title22Med110 = title22.copyWith(
      fontFamily: _americanSansMedium,
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
  static final title20Reg160 = title20.copyWith(
      height: 1.10
  );

  /// Replaces: h5
  static final title20Med120 = title20.copyWith(
      fontFamily: _americanSansMedium,
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
  static final subtitle18Med = subtitle18.copyWith(
    fontFamily: _americanSansMedium,
  );

  /// Replaces: newsCardHeadline
  static final subtitle18Reg110 = subtitle18.copyWith(
    height: 1.10,
  );

  /// Replaces: tableHeaderFooter
  static final subtitle18Bold1165 = subtitle18.copyWith(
    fontFamily: _americanSansBold,
    height: 1.165,
  );

  /// Replaces: smallTextStyle - Used: flight inventory card priority list, flight number, gate, departure time
  static final subtitle18MediumGray = subtitle18.copyWith(
    color: AaeColors.mediumGray,
  );

  /// Replaces: subTitleLarge, tabelCellTitle
  static final subtitle18CadetGray = subtitle18.copyWith(
    color: AaeColors.cadetGray,
  );

  /// Replaces: tableCellValue
  static final subtitle18Gray = subtitle18.copyWith(
    color: AaeColors.gray,
  );

  /// Replaces: textFieldModern
  static final subtitle18DarkBlue = subtitle18.copyWith(
    color: AaeColors.darkBlue,
  );

  /// Replaces: largeTextStyleSeatAssigned - Used: priority list
  static final subtitle18Green = subtitle18.copyWith(
    color: AaeColors.green,
  );

  /// Replaces: largeTextStyleSeatAssigned - Used: priority list
  static final subtitle18White = subtitle18.copyWith(
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
  static final body16Reg150 = body16.copyWith(
    height: 1.50,
  );

  /// Replaces: h6
  static final body16Med125 = body16.copyWith(
    fontFamily: _americanSansMedium,
    height: 1.25,
  );

  /// Replaces: headline
  static final body16Bold = body16.copyWith(
    fontFamily: _americanSansBold,
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
  static final subtitle15Med = subtitle15.copyWith(
    fontFamily: _americanSansMedium,
  );

  /// Add where this style is used
  static final subtitle15BlueBold = subtitle15.copyWith(
    fontFamily: _americanSansBold,
    color: AaeColors.blue,
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
  static final body14Reg143 = body14.copyWith(
    height: 1.43,
  );

  /// Replaces: secondRowTextStyle
  static final body14Gray = body14.copyWith(
    color: AaeColors.gray,
  );

  /// Used: when 4 cabin in Priority list
  static final body14MediumGray = body14.copyWith(
    color: AaeColors.mediumGray,
  );

  /// 13px BASE title text -----------------------------------------------------------------------13px--
  static const TextStyle caption13 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 13,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Used: priority list
  static final caption13Bold = caption13.copyWith(
    fontFamily: _americanSansBold,
    height: 1.00,
  );

  /// Used: priority list
  static final caption13Bold133 = caption13.copyWith(
    fontFamily: _americanSansBold,
    height: 1.33,
  );

  /// Replaces: ? - Used month and date PL and FS date pickers,
  static final caption13MediumGray = caption13.copyWith(
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
  static final caption12Reg150 = caption12.copyWith(
    height: 1.50,
  );

  /// Add where this style is used
  static final caption12Med = caption12.copyWith(
    fontFamily: _americanSansMedium,
  );

  /// Used: Stops indicator between multiple flights on a card, flight status,
  static final caption12DarkOrangeMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.darkOrange,
  );

  /// Used: flight status,
  static final caption12GreenMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.green,
  );

  /// Used: flight status,
  static final caption12DarkRedMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.darkRed,
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
  static final caption11Reg150 = caption11.copyWith(
    height: 1.50,
  );

  /// Add where this style is used
  static final caption11GrayMed = caption11.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.gray,
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
  static final btn16Med = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontSize: 16,
  );

  /// Add where this style is used
  static final btn16Med150 = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontSize: 16,
    height: 1.50,
  );

  /// Add where this style is used
  static final btn14Med = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontSize: 14,
  );

  /// Add where this style is used
  static final btn14Med150 = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontSize: 14,
    height: 1.50,
  );
}