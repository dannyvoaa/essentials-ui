import 'dart:collection';
import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/docs.dart';
import 'package:aae/model/event.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a [Event] response.
///
/// Single source of truth for all Events data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class EventsRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('EventsRepository'));

  static const cacheKey = 'EventsRepository.Events';

  final _eventsList = createBehaviorSubject<UnmodifiableListView<Event>>();

  final _listOfDaysWithEvents =
      createBehaviorSubject<UnmodifiableListView<Event>>();

  final selectedDate = createBehaviorSubject<DateTime>(initial: DateTime.now());

  final NewsServiceApi _apiClient;
  final CacheService _cache;

  /// Publishes the current events list
  Observable<UnmodifiableListView<Event>> get eventsList => _eventsList;

  /// Publishes the current days with events for the current month
  Observable<UnmodifiableListView<Event>> get listOfDaysWithEvents =>
      _listOfDaysWithEvents.shareReplay(shouldReplayAll: true);

  Observable<DateTime> get dateTimeSelect => selectedDate;

  changeDate(DateTime deltaTime) => _changeDateCall(deltaTime);

  @provide
  @singleton
  EventsRepository(this._cache, this._apiClient) {
    _loadFromCache();
    selectedDate.subscribe(
      onNext: (data) {
        _fetchEvents(data);

        fetchDaysWithEvents(data);
      },
    );
  }

  void _loadFromCache() {
    // Look up the events list from cache, publish it if we have it:
    _cache
        .readString(cacheKey)
        .transform(_eventsToModels)
        .ifPresent(_publishEventsList);
  }

  void _publishListOfDaysWithEvents(listOfDaysWithEvents) {
    _listOfDaysWithEvents.sendNext(listOfDaysWithEvents);
  }

  void _publishEventsList(listOfEvents) {
    _eventsList.sendNext(listOfEvents);
  }

  void _changeDateCall(DateTime date) {
    selectedDate.sendNext(date);
  }

  static UnmodifiableListView<Event> _eventsToModels(String eventsString) {
    Docs docs =
        serializers.deserializeWith(Docs.serializer, jsonDecode(eventsString));
    return UnmodifiableListView(
        docs.events.map((Event event) => event).toList());
  }

  _fetchEvents(DateTime query) async {
    Docs listOfEvents = (await _apiClient.getEvents(query));
    try {
      _saveToCache(listOfEvents.toJson());
      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetch Events: ', e, s);
      return null;
    }
  }

  fetchDaysWithEvents(DateTime date) async {
    List<Event> listOfDaysWithEvents =
        (await _apiClient.getDaysWithEvents(date));
    try {
      /// TODO (kiheke) - Change this function
      _publishListOfDaysWithEvents(UnmodifiableListView(listOfDaysWithEvents));
    } catch (e, s) {
      _log.severe('Failed to fetch Events: ', e, s);
      return null;
    }
  }

  Future<void> _saveToCache(event) => _cache.writeString(cacheKey, event);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
