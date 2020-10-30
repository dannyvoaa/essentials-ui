import 'dart:async';
import 'dart:convert';

import 'package:aae/api/travel_api_client.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
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
  final _flightStatus = createBehaviorSubject<FlightStatus>();

  final CacheService _cache;
  static String tripsKey = 'trips';

  Observable<BuiltList<Pnr>> get pnrs => _pnrs;

  Observable<FlightStatus> get flightStatus => _flightStatus;

  void set flightStatus(var value) {
    flightStatus = value;
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
    Trips trips = await _travelApiClient.getReservations('72000027');
    try {
      _saveToCache(tripsKey, trips.toJson());
      _loadFromTripsCache();
    } catch (e, s) {
      _log.severe('Failed to fetch trips: ', e, s);
      return null;
    }
  }

  loadFlightStatus(flightNumber, date) async {
    _flightStatus.sendNext(null);
    FlightStatus flightStatus =
        await _travelApiClient.getFlightStatus('72000027', flightNumber, date);
    try {
      _flightStatus.sendNext(flightStatus);
    } catch (e, s) {
      _log.severe('Failed to fetch flightStatus: ', e, s);
      return null;
    }
  }

  Future<FlightStatus> searchFlightStatus(String query) async {
    final searchResult = await _travelApiClient.getFlightStatus(
        '72000027', '0020', '2020-10-06');
    if (searchResult.flightNumber.isEmpty) {
      _log.severe('Failed to fetch flightStatus: ');
    } else {
      return searchResult;
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
