import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'calendar_view_model.g.dart';

/// View model representing a [CalendarView].
abstract class CalendarViewModel
    implements Built<CalendarViewModel, CalendarViewModelBuilder> {
  /// The command to executed when the next month is tapped.
  AaeCommand get onNextMonthPressed;

  /// The command to executed when the previous month is tapped.
  AaeCommand get onPreviousMonthPressed;

  /// List of days with events
  @nullable
  List<int> get daysWithEvents;

  @nullable
  AaeValueCommand<int> get onDaySelected;

  /// The current month displayed
  DateTime get month;

  DateTime get datePage;

  int get firstWeekdayInMonth;

  /// The number of days in this month.
  int get numOfDaysInCurrentMonth;

  /// The currently selected day, set to current day initially.
  int get selectedDate;

  CalendarViewModel._();

  factory CalendarViewModel({
    @required AaeCommand onNextMonthPressed,
    @required AaeCommand onPreviousMonthPressed,
    @required List<int> daysWithEvents,
    @required AaeValueCommand<int> onDaySelected,
    @required DateTime month,
    @required int numOfDaysInCurrentMonth,
    @required DateTime datePage,
    @required int firstWeekdayInMonth,
    @required int selectedDate,
  }) = _$CalendarViewModel._;
}

/// View model representing a [CalendarDay].
abstract class CalendarDayViewModel
    implements Built<CalendarDayViewModel, CalendarDayViewModelBuilder> {
  /// Whether or not this day is currently selected.
  bool get isSelected;

  /// Whether or not this day has an event.
  bool get hasEvent;

  /// The command to executed when the date is selected.
  AaeValueCommand<DateTime> get onDateSelected;

  /// The day of this date
  int get day;

  CalendarDayViewModel._();

  factory CalendarDayViewModel({
    @required bool isSelected,
    @required bool hasEvent,
    @required AaeValueCommand onDateSelected,
    @required int day,
  }) = _$CalendarDayViewModel._;
}
