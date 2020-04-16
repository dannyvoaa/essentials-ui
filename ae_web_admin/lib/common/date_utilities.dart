import 'package:flutter/foundation.dart';

class DateUtilities {
  /// Returns the numbers of days in a given month/year combination
  static int daysInMonth({@required int intYear, @required int intMonth}) {
    // Add one month to the passed variables
    DateTime dateTime = DateTime(intYear, intMonth + 1, 1);

    // Subtract one day (this will give you the last day of the preceeding month)
    int intLastDayOfMonth = dateTime.subtract(Duration(days: 1)).day;

    return intLastDayOfMonth;
  } 


  /// Calculate a DateTime using the number of seconds since the UNIX epoch
  static DateTime dateTimeFromEpoch({@required int intSecondsSinceEpoch}) {
    return DateTime.fromMillisecondsSinceEpoch(
      intSecondsSinceEpoch * 1000,
      isUtc: true,
    );
  }

  /// Find what day of the week that the first day in the month falls on (0: Sunday, 6: Saturday)
  static int firstWeekdayInMonth({@required int intYear, @required int intMonth}) {
    // Get Dart's (incorrect) interpretation of what a weekday is
    int intWeekday = DateTime(intYear, intMonth, 1).weekday;

    // Check to see if intWeekday is 7 (Sunday)
    if (intWeekday == 7) {
      // Sunday is the first day of the week. It is known.
      intWeekday = 0;
    }

    return intWeekday;
  }

  /// Calculate the number of seconds since the UNIX epoch
  static int secondsSinceEpoch({@required DateTime dateTime}) {
    return (dateTime.millisecondsSinceEpoch / 1000).round();
  }
}
