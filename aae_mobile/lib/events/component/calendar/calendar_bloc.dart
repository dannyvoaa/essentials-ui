import 'dart:collection';

import 'package:aae/common/date_utilities.dart';
import 'package:aae/events/repository/events_repository.dart';
import 'package:aae/model/event.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'calendar_view_model.dart';

/// BloC for the [CalendarComponent].
///
/// Exposes a [CalendarViewModel] for that component to use.
class CalendarBloc {
  final EventsRepository _eventsRepository;

  var previousTime;
  final _currentMonth =
      createBehaviorSubject<DateTime>(initial: DateTime.now());

  final _currentYear =
      createBehaviorSubject<DateTime>(initial: DateTime.now());

  final _currentlySelectedDate =
      createBehaviorSubject<int>(initial: DateTime.now().day);

  /// Publishes the [CalendarViewModel] for the UI to use.
  Source<CalendarViewModel> get viewModel => toSource(combineLatest3(
      _eventsRepository.listOfDaysWithEvents,
      _eventsRepository.dateTimeSelect,
      _currentlySelectedDate,
      _createViewModel));

  @provide
  CalendarBloc(this._eventsRepository) {
    _currentMonth.subscribe(onNext: (change) {
      return previousTime = change;
    });
  }

  CalendarViewModel _createViewModel(
      UnmodifiableListView<Event> listOfDaysWithEvents,
      DateTime timeToChange,
      int currentDate) {
    return CalendarViewModel(
      selectedDate: currentDate,
      datePage: timeToChange,
      daysWithEvents: _listOfDaysWithEvents(listOfDaysWithEvents),
      firstWeekdayInMonth: DateUtilities.firstWeekdayInMonth(
        intYear: timeToChange.year,
        intMonth: timeToChange.month,
      ),
      month: timeToChange,
      // TODO: Switch out the boilerplate code below to take into account the paged month (which you also have hard-coded)
      numOfDaysInCurrentMonth: DateUtilities.daysInMonth(
        intYear: timeToChange.year,
        intMonth: timeToChange.month,
      ),
      onNextMonthPressed: _moveToNextMonth,
      onPreviousMonthPressed: _moveToPrevMonth, onDaySelected: _onDateSelected,
    );
  }

  List<int> _listOfDaysWithEvents(UnmodifiableListView<Event> event) {
    List<int> listOfDaysWithEvents = [];
    for (int i = 0; i < event.length; i++) {
      listOfDaysWithEvents.add(event[i].startDay);
    }
    print(listOfDaysWithEvents.toSet());
    return listOfDaysWithEvents.toSet().toList(growable: false);
  }

  _onDateSelected(int date) {
    previousTime = DateTime(previousTime.year, previousTime.month, date);
    _eventsRepository.selectedDate.sendNext(previousTime);
    _currentlySelectedDate.sendNext(date);

    print('$previousTime');
    print('hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  }

  _moveToNextMonth() {
    switch (previousTime.month) {
      case 12:
        previousTime = DateTime(previousTime.year + 1, 1);
        _eventsRepository.fetchDaysWithEvents(previousTime);
        break;
      default:
        previousTime = DateTime(previousTime.year, previousTime.month + 1);
        _eventsRepository.fetchDaysWithEvents(previousTime);
        break;
    }

    _eventsRepository.selectedDate.sendNext(previousTime);
  }

  _moveToPrevMonth() {
    switch (previousTime.month) {
      case 1:
        previousTime = DateTime(previousTime.year - 1, 12);
        _eventsRepository.fetchDaysWithEvents(previousTime);
        break;
      default:
        previousTime = DateTime(previousTime.year, previousTime.month - 1);
        _eventsRepository.fetchDaysWithEvents(previousTime);
        break;
    }

    _eventsRepository.selectedDate.sendNext(previousTime);
  }
}

/// Constructs new instances of [CalendarBloc]s via the DI framework.
abstract class CalendarBlocFactory implements ProvidedService {
  @provide
  CalendarBloc calendarBloc();
}
