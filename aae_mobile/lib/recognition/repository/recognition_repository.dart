import 'dart:convert';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/recognition_history.dart';
import 'package:aae/model/recognition_register.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a [RecognitionHistory] response.
///
/// Single source of truth for all Recognition data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class RecognitionRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('RecognitionRepository'));

  static const cacheKey = 'RecognitionRepository.Recognition';

  final _currentBalance = createBehaviorSubject<String>();

  final _recognitionRegister =
      createBehaviorSubject<BuiltList<RecognitionRegister>>();

  final CacheService _cache;

  /// Publishes the current balance
  Observable<String> get currentBalance => _currentBalance;

  /// Publishes the current recognition history
  Observable<BuiltList<RecognitionRegister>> get recognitionRegister =>
      _recognitionRegister;

  @provide
  @singleton
  RecognitionRepository(this._cache) {
    _loadFromCache();
    _fetchRecognitionHistory();
  }

  void _loadFromCache() {
    // Look up the current balance from cache, publish it if we have it:
    _cache
        .readString(cacheKey)
        .transform(_recognitionHistoryToModel)
        .ifPresent(_publishRecognitionHistory);
  }

  void _publishRecognitionHistory(RecognitionHistory recognitionHistory) {
    _currentBalance.sendNext(recognitionHistory.currentBalance);
    _recognitionRegister.sendNext(recognitionHistory.recognitionRegister);
  }

  static RecognitionHistory _recognitionHistoryToModel(
      String recognitionHistory) {
    RecognitionHistory history = serializers.deserializeWith(
        RecognitionHistory.serializer, jsonDecode(recognitionHistory));
    return history;
  }

  //TODO: (kiheke) - Update to use api.
  _fetchRecognitionHistory() async {
    Future<String> history =
        rootBundle.loadString('assets/static_records/RecognitionHistory.json');
    try {
      _saveToCache(await history);
      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetch recognition history: ', e, s);
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
