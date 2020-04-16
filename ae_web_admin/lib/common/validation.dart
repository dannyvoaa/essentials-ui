import 'package:flutter/foundation.dart';

enum DateComparitor {
  EqualTo,
  GreaterThan,
  GreaterThanOrEqualTo,
  LessThan,
  LessThanOrEqualTo,
}

class Validation {
  static bool date({@required DateTime dateTime1, @required DateTime dateTime2, @required DateComparitor dateComparitor}) {
    // Check to see which date comparitor was requested
    if (dateComparitor == DateComparitor.EqualTo) {
      return dateTime1.compareTo(dateTime2) == 0;
    } else if (dateComparitor == DateComparitor.GreaterThan) {
      return dateTime1.compareTo(dateTime2) > 0;
    } else if (dateComparitor == DateComparitor.GreaterThanOrEqualTo) {
      return dateTime1.compareTo(dateTime2) >= 0;
    } else if (dateComparitor == DateComparitor.LessThan) {
      return dateTime1.compareTo(dateTime2) < 0;
    } else if (dateComparitor == DateComparitor.LessThanOrEqualTo) {
      return dateTime1.compareTo(dateTime2) <= 0;
    }

    return false;
  }

  /// A basic check to see if a string is not blank
  static String notBlank({@required String stringInput, String stringError = 'Please enter a value'}) {
    // Check to see if the string has a value
    if (stringInput.length > 0) {
      // Validation passed
      return null;
    }

    // Validation failed
    return stringError;
  }
}