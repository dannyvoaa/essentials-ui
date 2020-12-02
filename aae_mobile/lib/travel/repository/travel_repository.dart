import 'dart:async';
import 'dart:convert';

import 'package:aae/api/travel_api_client.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a [Trips] response.
///
/// Single source of truth for all Trips data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class TravelRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('TravelRepository'));
  final TravelServiceApi _travelApiClient;
  final SSOAuth _ssoAuth;

  static const cacheKey = 'TravelRepository.Travel';

  final _pnrs = createBehaviorSubject<BuiltList<Pnr>>();
  final _currentPriorityList = createBehaviorSubject<PriorityList>();
  final _flightStatus = createBehaviorSubject<FlightStatus>();
  final _flightSearch = createBehaviorSubject<FlightSearch>();

  final CacheService _cache;
  static String tripsKey = 'trips';

  Observable<BuiltList<Pnr>> get pnrs => _pnrs;

  Observable<PriorityList> get currentPriorityList => _currentPriorityList;

  Observable<FlightStatus> get flightStatus => _flightStatus;

  Observable<FlightSearch> get flightSearch => _flightSearch;

  void set flightStatus(var value) {
    flightStatus = value;
  }

  void set flightSearch(var value) {
    flightSearch = value;
  }

  @provide
  @singleton
  TravelRepository(this._cache, this._travelApiClient, this._ssoAuth) {
    _loadFromTripsCache();
    _fetchTrips();
//    fetchFlightStatus(1,2);
  }

  void _loadFromTripsCache() {
    _cache
        .readString(tripsKey)
        .transform(_tripsToModel)
        .ifPresent(_publishTrips);
  }

  void _publishTrips(Trips trips) {
    _pnrs.sendNext(trips.pnrs);
  }

  static Trips _tripsToModel(String tripsJson) {
    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  _fetchTrips() async {
    try {
      Trips trips = await _travelApiClient.getReservations('72000027');
      _saveToCache(tripsKey, trips.toJson());
      _loadFromTripsCache();
    } catch (e, s) {
      _log.severe('Failed to fetch trips: ', e, s);
      return null;
    }
  }

  loadPriorityList(String origin, int flightNum, DateTime date) async {
    _currentPriorityList.sendNext(null);
    PriorityList priorityList =
        await _travelApiClient.getPriorityList(origin, flightNum, date);
    _currentPriorityList.sendNext(priorityList);
  }

  loadFlightStatus(flightNumber, origin, date) async {
    FlightStatus flightStatus;
    try {
      _flightStatus.sendNext(null);
      flightStatus = await _travelApiClient.getFlightStatus(
          '72000027', flightNumber, origin, date);
      _flightStatus.sendNext(flightStatus);
      return true;
    } catch (e, s) {
      _log.severe('Failed to fetch flightStatus', e, s);
      flightStatus = new FlightStatus();
      _flightStatus.sendNext(flightStatus);
    }
  }

  loadFlightSearch(origin, destination, date) async {
    FlightSearch flightSearch;
    try {
      _flightSearch.sendNext(null);
      flightSearch = await _travelApiClient.getFlightSearch(
          '72000027', origin, destination, date);
      _flightSearch.sendNext(flightSearch);
      return true;
    } catch (e, s) {
      _log.severe('Failed to fetch flightSearch', e, s);
      flightSearch = new FlightSearch();
      _flightSearch.sendNext(flightSearch);
    }
  }

  Future<void> _saveToCache(String key, String data) =>
      _cache.writeString(key, data);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
