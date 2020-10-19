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

  @provide
  @singleton
  TravelRepository(this._cache, this._travelApiClient, this._ssoAuth) {
    _loadFromTripsCache();
    _fetchTrips();
    _fetchFlightStatus();
  }

  void _loadFromTripsCache() {
    _cache
        .readString(tripsKey)
        .transform(_tripsToModel)
        .ifPresent(_publishTrips);
  }

  void _loadFromFlightStatusCache() {
    _cache
        .readString('2020-10-06')
        .transform(_flightStatusToModel)
        .ifPresent(_publishFlightStatus);
  }

  void _publishTrips(Trips trips) {
    _pnrs.sendNext(trips.pnrs);
  }

  void _publishFlightStatus(FlightStatus flightStatus) {
    _flightStatus.sendNext(flightStatus);
  }

  static Trips _tripsToModel(String tripsJson) {
    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  static FlightStatus _flightStatusToModel(String flightStatusJson) {
    FlightStatus flightStatus =
    serializers.deserializeWith(FlightStatus.serializer, jsonDecode(flightStatusJson));
    return flightStatus;
  }

  _fetchTrips() async {
    Trips trips = await _travelApiClient.getReservations('72000027');
    try {

    } catch (e, s) {
      _log.severe('Failed to fetch trips: ', e, s);
      return null;
    }
  }

  _fetchFlightStatus() async {
    FlightStatus flightStatus = await _travelApiClient.getFlightStatus(
        '72000027', '1085', '2020-10-06');
    try {
      _saveToCache('2020-10-06', flightStatus.toJson());
      _loadFromFlightStatusCache();
    } catch (e, s) {
      _log.severe('Failed to fetch flightStatus: ', e, s);
      return null;
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
