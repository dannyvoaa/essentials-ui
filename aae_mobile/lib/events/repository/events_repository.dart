import 'dart:convert';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/event.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'package:http/http.dart' as http;

/// A repository that stores a [Event] response.
///
/// Single source of truth for all Events data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class EventsRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('EventsRepository'));

  static const cacheKey = 'EventsRepository.Events';

  final _eventsList = createBehaviorSubject<BuiltList<Event>>();

  final CacheService _cache;

  String _eventResponse;

  final apiEndpoint =
      'https://uisheitzearionstoodueget:eccadc4ad470f4ed210410939dc5a2115b0d7b58@ebc9e7bc-8615-4d08-8451-4f7f5c7d85ee-bluemix.cloudant.com';

  /// Publishes the current events list
  Observable<BuiltList<Event>> get eventsList => _eventsList;

  @provide
  @singleton
  EventsRepository(this._cache) {
    // _loadFromCache();
    _fetchEvents();
  }

  void _loadFromCache() {
    // Look up the events list from cache, publish it if we have it:
    _cache
        .readString(cacheKey)
        .transform(_eventsToModels)
        .ifPresent(_publishEventsList);
  }

  void _publishEventsList(listOfEvents) {
    _eventsList.sendNext(listOfEvents);
  }

  final Map<String, Object> body = {
    'selector': {
      'end': {'\$gte': (DateTime.now().millisecondsSinceEpoch / 1000).round()}
    },
    'fields': [],
    'sort': [
      {'allDay:number': 'asc'},
      {'start:number': 'asc'},
      {'eventName:string': 'asc'}
    ]
  };

  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  Future<String> _reloadData() async {
    var client = http.Client();
    final json = jsonEncode(body);

    try {
      final response = await http.post('$apiEndpoint/events/_find',
          body: json, headers: header, encoding: Encoding.getByName('utf-8'));

      response.statusCode == 200
          ? _eventResponse = response.body
          : debugPrint('ERROR');
    } catch (e, s) {
      debugPrint('thrown error: $e\n\nStatus: $s');
    } finally {
      client.close();
    }

    return _eventResponse;
  }

  static BuiltList<Event> _eventsToModels(String eventString) {
    final BuiltList<Event> events =
        deserializeListOf<Event>(jsonDecode(eventString)["docs"]);
    _log.shout(events.length);
    return events;
  }

  //TODO: (kiheke) - Update to use api.
  _fetchEvents() async {
    Future<String> event = _reloadData();
    try {
      _saveToCache(event);
      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetchEvents: ', e, s);
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
