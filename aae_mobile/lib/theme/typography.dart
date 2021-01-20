import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// BASE for TEXT styles --------------------------------------------------------------TEXT-----------
/// Base classes = class name and size, dark gray color, regular weight, 1.0 height
/// Final classes = class name and size + color if different + weight if different + height if different
/// Naming order = name (title), size (50), color (Gray), weight (Med), line height (133)

class AaeTextStyles {
  static const _regular = FontWeight.w400;
  static const _americanSans = 'AmericanSans';
  static const _americanSansLight = 'AmericanSansLight';
  static const _americanSansMedium = 'AmericanSansMedium';
  static const _americanSansBold = 'AmericanSansBold';

  static const font = 'AmericanSans';

  // 50px BASE title text -----------------------------------------------------------------------50px--
  /// 50px base font
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

  // 40px BASE title text -----------------------------------------------------------------------40px--
  /// 40px base font
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

  // 32px BASE title text -----------------------------------------------------------------------32px--
  /// 32px base font
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

  // 28px BASE title text -----------------------------------------------------------------------28px--
  /// 28px base font
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

  // 24px BASE title text -----------------------------------------------------------------------24px--
  /// 24px base font
  static const TextStyle title24 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 24,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces: h4
  ///
  /// Used: Selected date in PL and FS date pickers,
  static final title24Med110 = title24.copyWith(
      fontFamily: _americanSansMedium,
      height: 1.10
  );

  /// Replaces: pageHeadLine,
  static final title24Bold110 = title24.copyWith(
      fontFamily: _americanSansBold,
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
      color: AaeColors.mediumGray,
  );


  // 22px BASE title text -----------------------------------------------------------------------22px--
  /// 22px base font
  static const TextStyle title22 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 22,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces: eventTitle
  static final title22Med = title22.copyWith(
      fontFamily: _americanSansMedium,
  );

  /// Replaces: reservationHeading
  static final title22Bold = title22.copyWith(
    fontFamily: _americanSansBold,
  );

  // 20px BASE title text -----------------------------------------------------------------------20px--
  /// 20px base font
  ///
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

  /// Replaces: tableCellValueHub
  static final title20GrayBold = title20.copyWith(
      fontFamily: _americanSansBold,
    color: AaeColors.gray,

  );

  // 18px BASE title text -----------------------------------------------------------------------18px--
  /// 18px base font
  ///
  /// Replaces: largeTextStyle - Used: passenger list
  static const TextStyle subtitle18 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces: smallHeadline, timeSummary
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

  /// Replaces: tableCellValue, tableCellTitleHub
  static final subtitle18Gray = subtitle18.copyWith(
    color: AaeColors.gray,
  static const reservationNoTripsHeading = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AaeColors.mediumGray,
      fontFamily: _americanSansMedium);

  static const smallTextStyle = TextStyle(
    fontFamily: _americanSans,
    fontSize: 18,
    color: const Color(0xff627a88),
  );

  static const reservationSubHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AaeColors.titleGray,
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
    color: AaeColors.white,
  );

  // 16px BASE title text -----------------------------------------------------------------------16px--
  /// 16px base font
  ///
  /// Replaces: b2SingleLine, body, calendarMain, eventText
  static const TextStyle body16 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 16,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces: b2SingleLine, body, calendarMain as second height setting
  static const TextStyle body16Reg133 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 16,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.33,
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

  // 15px BASE title text -----------------------------------------------------------------------15px--
  /// 15px base font
  static const TextStyle subtitle15 = TextStyle(
    fontFamily: _americanSans,
  static final stopDivider = TextStyle(
    color: AaeColors.darkOrange,
    fontWeight: _medium,
    fontSize: 12,
  );

  /// Travel module text styles
  static const travelHeader = TextStyle(
    fontSize: 15,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces:locatorInfo
  static final subtitle15Med = subtitle15.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.darkGray,
  );

  /// Replaces: travelHeader, cardTitle,
  ///
  /// Used: Titles (Tools, Travelers, etc) above cards
  static final subtitle15BlueBold = subtitle15.copyWith(
    fontFamily: _americanSansBold,
    color: AaeColors.blue,
  );

  // 14px BASE title text -----------------------------------------------------------------------14px--
  /// 14px base font
  ///
  /// Replaces: priorityCodeTextStyle, hubDetailHeading, reservationSubHeading
  ///
  /// Used: 3-letter codes under flight times, priority list
  static const TextStyle body14 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 14,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
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
  static const flightStatusTimeText = TextStyle(
      fontSize: 18,
      color: AaeColors.titleGray,
      fontFamily: _americanSansMedium
  );

  static const flightSearchText = TextStyle(
    fontSize: 15,
    color: AaeColors.titleGray,
    fontFamily: _americanSansMedium
  );

  static const flightSearchHeader = TextStyle(
    fontSize: 32,
    color: AaeColors.mediumGray,
  );

  // 13px BASE title text -----------------------------------------------------------------------13px--
  /// 13px base font
  ///
  /// Replaces: calendarSummary height 1.0,
  static const TextStyle caption13 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 13,
    color: AaeColors.darkGray,
    fontWeight: _regular,
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
    height: 1.00,
  );

  /// Replaces: calendarSummaryBold height1.33
  ///
  /// Used: priority list
  static final caption13Bold133 = caption13.copyWith(
    fontFamily: _americanSansBold,
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


  // 12px BASE title text -----------------------------------------------------------------------12px--
  /// 12px base font
  ///
  /// Replaces: departureHeading,
  static const TextStyle caption12 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 12,
    color: AaeColors.darkGray,
    fontWeight: _regular,
    height: 1.00,
  );

  /// Replaces: c1
  static final caption12Reg150 = caption12.copyWith(
    height: 1.50,
  );

  /// Add where this style is used
  static final caption12Med = caption12.copyWith(
    fontFamily: _americanSansMedium,
  );

  /// Replaces: this is a new style
  ///
  /// Used: stop indicator card divider,
  static final caption12MediumGrayMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.mediumGray,
  );

  /// Replaces: departureDelayed
  ///
  /// Used: flight status on cards - delayed,
  static final caption12DarkOrangeMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.darkOrange,
  );

  /// Replaces: departureOnTime,
  ///
  /// Used: flight status on cards - ontime,
  static final caption12GreenMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.green,
  );

  /// Replaces: departureCancelled
  ///
  /// Used: flight status on cards - cancelled,
  static final caption12DarkRedMed = caption12.copyWith(
    fontFamily: _americanSansMedium,
    color: AaeColors.darkRed,
  );

  // 11px BASE title text -----------------------------------------------------------------------11px--
  /// 11px base font
  static const TextStyle caption11 = TextStyle(
    fontFamily: _americanSans,
    fontSize: 11,
    color: AaeColors.darkGray,
    fontWeight: _regular,
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
    color: AaeColors.gray,
  );

  // BASE for BUTTON text --------------------------------------------------------------BUTTONS-----------
  /// Button text styles
  ///
  /// Naming new classes = class name and size + color if different + weight if different + height if different
  ///
  /// Replaces: checkInButton
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
    // Default style
    return textStyle;
  }

  static TextStyle tableCellValueHub() {
    //TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(color: AaeColors.red, fontSize: 18);
    //TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold);
    TextStyle mytextStyle = TextStyle(
        fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold);
    // Default style
    return mytextStyle;
  }

  /// Used for Event detail layout
  static TextStyle eventTitle({bool boolDefaultHeight = false}) {
    TextStyle textStyle = h4.copyWith(
      color: AaeColors.darkGray,
      height: 1.0,
      fontSize: 22,
    );

    // Default style
    return textStyle;
  }

  static TextStyle eventText({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.darkGray,
      height: 1.0,
    );

    // Default style
    return textStyle;
  }

  static TextStyle eventDate({bool boolDefaultHeight = false}) {
    TextStyle textStyle = t2.copyWith(
      color: AaeColors.darkGray,
      fontSize: 14,
    );

    // Default style
    return textStyle;
  }

  /// Used for the title in [LargeButton]
  static TextStyle largeButtonTitle({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      color: AaeColors.white,
      fontSize: 18,
      fontWeight: FontWeight.normal,
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
      fontSize: 18,
      color: AaeColors.darkBlue,
    );

    // Default style
    return textStyle;
  }

  // Used for user-entered content in a [TextField]
  static TextStyle textFieldTitle({bool boolDefaultHeight = false}) {
    TextStyle textStyle = body(boolDefaultHeight: boolDefaultHeight).copyWith(
      fontSize: 18,
      color: AaeColors.gray,
    );

    // Default style
    return textStyle;
  }

  static const pageHeadline =
      TextStyle(fontSize: 24, fontWeight: _bold, color: AaeColors.onboardTitle);
}