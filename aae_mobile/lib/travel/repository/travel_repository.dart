import 'dart:convert';

import 'package:aae/api/travel_api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
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

  static const cacheKey = 'TravelRepository.Travel';

  final _pnr = createBehaviorSubject<BuiltList<Pnr>>();

  final CacheService _cache;

  Observable<BuiltList<Pnr>> get pnr => _pnr;

  @provide
  @singleton
  TravelRepository(this._cache, this._travelApiClient) {
    _loadFromCache();
    _fetchTrips();
  }

  void _loadFromCache() {
    _cache
        .readString(cacheKey)
        .transform(_tripsToModel)
        .ifPresent(_publishTrips);
  }

  void _publishTrips(Trips trips) {
    _pnr.sendNext(trips.pnrs);
  }

  static Trips _tripsToModel(String tripsJson) {
    print(tripsJson);
    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    print('trips to model');
    print(trips);
    return trips;
  }

  _fetchTrips() async {
//    Future<String> trips =
//        rootBundle.loadString('assets/static_records/Trips.json');
    String trips = await _travelApiClient.getReservations();
    try {
      _saveToCache(await trips);
      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetch trips: ', e, s);
      return null;
    }
  }

  Future<void> _saveToCache(trips) => _cache.writeString(cacheKey, trips);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
