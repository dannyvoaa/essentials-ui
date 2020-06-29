import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/pnrs.dart';
import 'package:aae/model/recognition_history.dart';
import 'package:aae/model/recognition_register.dart';
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
/// Single source of truth for all Recognition data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class TravelRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('TravelRepository'));
  final NewsServiceApi _apiClient;

  static const cacheKey = 'TravelRepository.Travel';

  final _pnrs =
      createBehaviorSubject<BuiltList<Pnrs>>();

  final CacheService _cache;

  Observable<BuiltList<Pnrs>> get pnrs =>
      _pnrs;

  @provide
  @singleton
  TravelRepository(this._cache, this._apiClient) {
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
    _pnrs.sendNext(trips.pnrs);
  }

  static Trips _tripsToModel(
      String trips) {
    Trips history = serializers.deserializeWith(
        Trips.serializer, jsonDecode(trips));
    return history;
  }

  _fetchTrips() async {
//    Future<String> trips =
//        rootBundle.loadString('assets/static_records/Trips.json');
        String trips = await _apiClient.getReservations();
    try {
      _saveToCache(await trips);
      print(await trips);

      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetch trips history: ', e, s);
      return null;
    }
  }

  Future<void> _saveToCache(balance) => _cache.writeString(cacheKey, balance);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
