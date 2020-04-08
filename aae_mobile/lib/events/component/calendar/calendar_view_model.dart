//import 'dart:ui';
//
//import 'package:aae/common/commands/aae_command.dart';
//import 'package:aae/model/event.dart';
//import 'package:built_collection/built_collection.dart';
//import 'package:built_value/built_value.dart';
//
//part 'calendar_view_model.g.dart';
//
///// The month to show the Event items in.
////enum MonthWidget { january, february, march, april, may, june, july, august, september, october, november, december, }
//
///// View model representing a [CalendarView].
//abstract class CalendarViewModel
//    implements Built<CalendarViewModel, CalendarViewModelBuilder> {
//  /// Which type of collection widget to show .
//  //CollectionWidget get collectionWidget;
//
//  /// The Events of each individual item to show in the collection widget.
//  BuiltList<Event> get events;
//
//  AaeValueCommand<LibrarySortOrder> get onSortOrderChanged;
//
//  Color get listIconColor;
//
//  AaeCommand get onDateSelected;
//
//  Color get categoryColor;
//
//  AaeCommand get onNextMonthPressed;
//
//  AaeCommand get onPreviousMonthPressed;
//
//  CalendarViewModel._();
//
//  factory CalendarViewModel([updates(CalendarViewModelBuilder b)]) =
//      _$CalendarViewModel;
//}
