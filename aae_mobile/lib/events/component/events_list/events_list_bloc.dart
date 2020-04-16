import 'package:aae/events/repository/events_repository.dart';
import 'package:aae/model/event.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'events_list_view_model.dart';

/// BloC for the [EventsListComponent].
///
/// Exposes a [EventsListViewModel] for that component to use.
class EventsListBloc {
  final EventsRepository _eventsRepository;

  Source<EventsListViewModel> get viewModel => toSource(combineLatest2(
      _eventsRepository.eventsList,
      _eventsRepository.dateTimeSelect,
      _createViewModel));

  final _currentEventList =
      createBehaviorSubject<DateTime>(initial: DateTime.now());

  @provide
  EventsListBloc(this._eventsRepository) {
    _currentEventList.subscribe(onNext: (data) {});
  }

  EventsListViewModel _createViewModel(
      List<Event> listOfEvents, DateTime _selectedDate) {
    print(DateTime.now());
    return EventsListViewModel((b) => b
      ..observingDate = _selectedDate
      ..events = listOfEvents);
  }
}

/// Constructs new instances of [EventsListBloc]s via the DI framework.
abstract class EventsListBlocFactory implements ProvidedService {
  @provide
  EventsListBloc eventsListBloc();
}
