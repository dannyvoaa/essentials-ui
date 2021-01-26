import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// BASE for TEXT styles --------------------------------------------------------------TEXT-----------
/// Base classes = class name and size, dark gray color, regular weight, 1.0 height
/// Final classes = class name and size + color if different + weight if different + height if different
/// Naming order = name (title), size (50), color (Gray), weight (Med), line height (133)

// static const _regular = FontWeight.w400;
// static const _medium = FontWeight.w500;
// static const _bold = FontWeight.bold;
// static const _americanSans = 'AmericanSans';
// static const font = 'AmericanSans';

class AaeTextStyles {
  static const _americanSans = 'AmericanSans'; //400
  static const font = 'AmericanSans';
  static const _americanSansItalic = 'AmericanSans-Italic'; //400
  static const _americanSansLight = 'AmericanSans-Light'; //300
  static const _americanSansMedium = 'AmericanSans-Medium'; //600
  static const _americanSansBold = 'AmericanSans-Bold'; //700


  // 50px BASE title text --------------------------------v---------------------------------------50px--
  /// 50px base font
  static const TextStyle title50 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 50,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: titleLarge
  static final title50CadetGrayBold = title50.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    color: AaeColors.cadetGray,
  );

  // 40px BASE title text ----------------------------------v-------------------------------------40px--
  /// 40px base font
  static const TextStyle title40 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 40,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: h1
  static final title40Med140 = title40.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    height: 1.40,
  );


  // 32px BASE title text ----------------------------------v-------------------------------------32px--
  /// 32px base font
  static const TextStyle title32 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 32,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: largeTextStyle
  static final title32MediumGrayMed = title32.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.mediumGray,
  );

  /// Replaces: h2
  static final title32Med125 = title32.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// Add where this style is used
  static final title32Med = title32.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
  );

  /// Replaces: flightSearchHeader
  static final title32MediumGray = title32.copyWith(
    color: AaeColors.mediumGray,
  );


  // 28px BASE title text ------------------------------------v-----------------------------------28px--
  /// 28px base font
  static const TextStyle title28 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 28,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: h3
  static final title28Med143 = title28.copyWith(
      fontFamily: _americanSansMedium,
      fontWeight: FontWeight.w600,
      height: 1.43
  );

  // 26px BASE title text ------------------------------------v-----------------------------------28px--
  /// 26px base font
  static const TextStyle title26 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 26,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Used: number dates in travel date pickers (unselected date)
  static final title26GrayMed = title26.copyWith(
      fontFamily: _americanSansMedium,
      fontWeight: FontWeight.w600,
      color: AaeColors.gray,
  );

  /// Used: number dates in travel date pickers (selected date)
  static final title26Med = title26.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.darkGray,
  );


  // 24px BASE title text ------------------------------------v-----------------------------------24px--
  /// 24px base font
  static const TextStyle title24 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 24,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: h4
  ///
  /// Used: Selected date in PL and FS date pickers,
  static final title24Med110 = title24.copyWith(
      fontFamily: _americanSansMedium,
      fontWeight: FontWeight.w600,
      height: 1.10
  );

  /// Replaces: pageHeadLine,
  static final title24Bold110 = title24.copyWith(
      fontFamily: _americanSansBold,
      fontWeight: FontWeight.w700,
      height: 1.10
  );

  /// Replaces: textFieldModernHint height1.0,
  static final title24MediumGray = title24.copyWith(
    color: AaeColors.mediumGray,
  );

  /// Replaces: textFieldModernHint height 1.33,
  static final title24MediumGray133 = title24.copyWith(
    color: AaeColors.mediumGray,
    height: 1.33,
  );

  /// Used: 'No trips yet' on home page,
  static final title24MediumGrayBold = title24.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    color: AaeColors.mediumGray,
  );

  /// Used: H1 in articles
  static final title24DarkBlue140 = title24.copyWith(
    color: AaeColors.darkBlue,
    height: 1.40,
  );

  // 22px BASE title text ---------------------------------v--------------------------------------22px--
  /// 22px base font
  static const TextStyle title22 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 22,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Used: H2 in articles
  static final title22DarkBlue140 = title22.copyWith(
    color: AaeColors.darkBlue,
    height: 1.40,
  );

  /// Replaces: eventTitle
  static final title22Med = title22.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
  );

  /// Replaces: reservationHeading
  static final title22Bold = title22.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
  );

  // 21px BASE title text --------------------------------v---------------------------------------21px--
  /// 21px base font
  ///
  /// Replaces: b1SingleLine, title
  static const TextStyle title21 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 21,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: inline style in airport_picker_header.dart
  static final title21MediumGrayMed = title21.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.mediumGray,
  );


  // 20px BASE title text ----------------------------------v-------------------------------------20px--
  /// 20px base font
  ///
  /// Replaces: b1SingleLine, title
  static const TextStyle title20 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 20,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: b1
  static final title20Reg160 = title20.copyWith(
      height: 1.10,
  );

  /// Replaces: h5
  static final title20Med120 = title20.copyWith(
      fontFamily: _americanSansMedium,
      fontWeight: FontWeight.w600,
      height: 1.20,
  );

  /// Replaces: tableCellValueHub
  static final title20GrayBold = title20.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    color: AaeColors.gray,
  );

  /// Used: H3 titles in article
  static final title20MediumGray140 = title20.copyWith(
    color: AaeColors.mediumGray,
    height: 1.40,
  );


  // 18px BASE title text ----------------------------------v-------------------------------------18px--
  /// 18px base font
  ///
  /// Replaces: largeTextStyle - Used: passenger list
  static const TextStyle subtitle18 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: smallHeadline
  static final subtitle18Med = subtitle18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
  );

  /// Replaces: timeSummary
  static final subtitle18Bold = subtitle18.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
  );

  /// Replaces: newsCardHeadline
  static final subtitle18Reg110 = subtitle18.copyWith(
    height: 1.10,
  );

  /// Replaces: tableHeaderFooter
  static final subtitle18Bold1165 = subtitle18.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    height: 1.165,
  );

  /// Replaces: smallTextStyle, inlinePriorityList
  ///
  /// Used: flight inventory card priority list, flight number, gate, departure time,
  static final subtitle18MediumGray = subtitle18.copyWith(
    color: AaeColors.mediumGray,
  );

  /// Used: no current trips subtext,
  static final subtitle18MediumGray140 = subtitle18.copyWith(
    color: AaeColors.mediumGray,
    height: 1.40,
  );

  /// Replaces: subTitleLarge, tableCellTitle
  static final subtitle18CadetGray = subtitle18.copyWith(
    color: AaeColors.cadetGray,
  );

  /// Replaces: tableCellValue, tableCellTitleHub, textFieldTitle
  static final subtitle18Gray = subtitle18.copyWith(
    color: AaeColors.gray,
  );

  /// Replaces: textFieldModern
  static final subtitle18DarkBlue = subtitle18.copyWith(
    color: AaeColors.darkBlue,
  );

  /// Replaces: largeTextStyleSeatAssigned
  ///
  /// Used: priority list
  static final subtitle18Green = subtitle18.copyWith(
    color: AaeColors.green,
  );

  /// Used: priority list
  static final subtitle18White = subtitle18.copyWith(
    color: AaeColors.white100,
  );

  /// Replaces: tableCellValue
  static final subtitle18LightGray = subtitle18.copyWith(
    color: AaeColors.lightGray,
  );



  // 16px BASE title text --------------------------------v---------------------------------------16px--
  /// 16px base font
  ///
  /// Replaces: b2SingleLine, body, calendarMain, eventText
  static const TextStyle body16 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 16,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: b2SingleLine, body, calendarMain as second height setting
  static final TextStyle body16Reg133 = body16.copyWith(
    height: 1.33,
  );

  /// Replaces: calendarOld
  static final TextStyle body16Gray = body16.copyWith(
    color: AaeColors.gray,
  );

  /// Used: Article body text
  static final body16Reg138 = body16.copyWith(
    height: 1.38,
  );

  /// Replaces: b2
  static final body16Reg150 = body16.copyWith(
    height: 1.50,
  );

  /// Replaces: h6
  static final body16Med125 = body16.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// Replaces: h6
  static final body16WhiteMed125 = body16.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.white100,
    height: 1.25,
  );

  /// Replaces: headline
  static final body16Bold = body16.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
  );


  // 15px BASE title text ----------------------------------v-------------------------------------15px--
  /// 15px base font
  static const TextStyle subtitle15 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces:locatorInfo
  static final subtitle15Med = subtitle15.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
  );

  /// Replaces:formHintText
  static final subtitle15Gray = subtitle15.copyWith(
    color: AaeColors.gray,
  );

  /// Replaces: travelHeader, cardTitle,
  ///
  /// Used: Titles (Tools, Travelers, etc) above cards
  static final subtitle15BlueBold = subtitle15.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    color: AaeColors.blue,
  );

  // 14px BASE title text ---------------------------------v--------------------------------------14px--
  /// 14px base font
  ///
  /// Replaces: priorityCodeTextStyle, hubDetailHeading, reservationSubHeading
  ///
  /// Used: 3-letter codes under flight times, priority list
  static const TextStyle body14 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 14,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Used: Welcome page footer text
  static final body14Reg130 = body14.copyWith(
    height: 1.30,
  );

  /// Replaces: b3
  ///
  /// Used: this was used for text above QR codes but that's been changed to body16. Maybe this can be removed.
  static final body14Reg143 = body14.copyWith(
    height: 1.43,
  );

  /// Replaces: eventDate
  static final body14Reg150 = body14.copyWith(
    height: 1.50,
    letterSpacing: 0.30,
  );

  /// Replaces: secondRowTextStyle
  static final body14Gray = body14.copyWith(
    color: AaeColors.gray,
  );

  /// Used: when 4 cabin in Priority list
  static final body14MediumGray = body14.copyWith(
    color: AaeColors.mediumGray,
  );


  // 13px BASE title text ------------------------------------v-----------------------------------13px--
  /// 13px base font
  ///
  /// Replaces: calendarSummary height 1.0,
  static const TextStyle caption13 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 13,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: calendarSummary height1.33
  static final caption13Reg133 = caption13.copyWith(
    height: 1.33,
  );

  /// Replaces: calendarSummaryBold height1.0
  ///
  /// Used: priority list
  static final caption13Bold = caption13.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    height: 1.00,
  );

  /// Replaces: calendarSummaryBold height1.33
  ///
  /// Used: priority list
  static final caption13Bold133 = caption13.copyWith(
    fontFamily: _americanSansBold,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );

  /// Replaces: routeDetailHeading
  ///
  /// Used: month and date PL and FS date pickers,
  static final caption13MediumGray = caption13.copyWith(
    color: AaeColors.mediumGray,
  );

  /// Replaces: dividerDot
  ///
  /// Used: dot divider between horizontal data
  static final caption13MediumGrayLS10 = caption13.copyWith(
    color: AaeColors.mediumGray,
    letterSpacing: 10,
  );


  // 12px BASE title text -----------------------------------v------------------------------------12px--
  /// 12px base font
  ///
  /// Replaces: departureHeading,
  static const TextStyle caption12 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 12,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: c1
  static final caption12Reg150 = caption12.copyWith(
    height: 1.50,
  );

  /// Add where this style is used
  static final caption12Med = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
  );

  /// Replaces: this is a new style
  ///
  /// Used: stop indicator card divider,
  static final caption12MediumGrayMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.mediumGray,
  );

  /// Replaces: departureDelayed
  ///
  /// Used: flight status on cards - delayed,
  static final caption12DarkOrangeMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.darkOrange,
  );

  /// Replaces: departureOnTime,
  ///
  /// Used: flight status on cards - ontime,
  static final caption12GreenMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.green,
  );

  /// Replaces: departureCancelled
  ///
  /// Used: flight status on cards - cancelled,
  static final caption12DarkRedMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.darkRed,
  );

  /// Replaces: flightStatusText
  ///
  /// Used: flight status on cards
  static final caption12CadetGray = caption12.copyWith(
    color: AaeColors.cadetGray,
  );

  /// Replaces: locatorInfoHeading
  ///
  /// Used: flight status on cards
  static final caption12GrayMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.gray,
  );


  // 11px BASE title text -------------------------------------v----------------------------------11px--
  /// 11px base font
  static const TextStyle caption11 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 11,
    color: AaeColors.darkGray,
    height: 1.00,
  );

  /// Replaces: t2
  ///
  /// Used: D0 stats bar,
  static final caption11Reg150 = caption11.copyWith(
    height: 1.50,
  );

  /// Used: flight card footer titles (boards, gate, terminal, baggage)
  static final caption11GrayMed = caption11.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    color: AaeColors.gray,
  );

  // BASE for BUTTON text -------------------------------------v-----------------------------------BUTTONS--
  /// Button text styles
  ///
  /// Naming new classes = class name and size + color if different + weight if different + height if different
  ///
  /// Replaces: checkInButton, largeButtonTitle
  static const TextStyle btn18 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: AaeColors.white100,
    height: 1.00,
  );

  /// Used: Articles pages
  static final btn14 = btn18.copyWith(
    fontSize: 14,
  );

  /// Add where this style is used
  static final btn16Med = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  /// Add where this style is used
  static final btn16Med150 = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.50,
  );

  /// Add where this style is used
  static final btn14Med = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  /// Add where this style is used
  static final btn14Med150 = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.50,
  );

  /// Replaces: btn2
  static final btn14Med142 = btn18.copyWith(
    fontFamily: _americanSansMedium,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.42,
  );

}
