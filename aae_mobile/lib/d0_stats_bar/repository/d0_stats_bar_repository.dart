import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

class D0StatsRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('D0StatsRepository'));

  static const cacheKey = 'D0StatsRepository.Events';
  final NewsServiceApi _apiClient;
  final CacheService _cache;

  static String d0StatsKey = 'd0Stats';
  static String stocksKey = 'stocks';

  Observable<StockStats> get stocksValiditySubject => _stocksValiditySubject;
  Observable<PerformanceStats> get performanceValiditySubject => _performanceValiditySubject;

  @provide
  @singleton
  D0StatsRepository(this._apiClient, this._cache) {
    _fetchRecentData();
  }

  void _loadFromStockCache() {
    _cache
        .readString(stocksKey)
        .transform(_dataToStockModel)
        .ifPresent(_publishStockWidget);
  }

  void _loadFromPerformanceCache() {
    _cache
        .readString(d0StatsKey)
        .transform(_dataToPerformanceModel)
        .ifPresent(_publishPerformanceWidget);
  }

  final _stocksValiditySubject = createBehaviorSubject<StockStats>();
  final _performanceValiditySubject = createBehaviorSubject<PerformanceStats>();

  static StockStats _dataToStockModel(String data) {
    StockStats _stock =
        serializers.deserializeWith(StockStats.serializer, jsonDecode(data));

    return _stock;
  }

  static PerformanceStats _dataToPerformanceModel(String data) {
    PerformanceStats performanceStats = serializers.deserializeWith(
        PerformanceStats.serializer, jsonDecode(data));
    return performanceStats;
  }

  void _publishStockWidget(StockStats updatedStatsBar) {
    _stocksValiditySubject.distinctUntilChanged();
    _stocksValiditySubject.sendNext(updatedStatsBar);
  }

  void _publishPerformanceWidget(PerformanceStats statsBarObject) {
    _performanceValiditySubject.distinctUntilChanged();
    _performanceValiditySubject.sendNext(statsBarObject);
  }

  /// [_fetchRecentData] will query the backend services to get stats and stocks data on load
  _fetchRecentData() async {
    try {
      PerformanceStats d0Stats = await _apiClient.getD0StatsData();
      StockStats stocks = await _apiClient.getStockStatsData();
      _saveToCache(d0StatsKey, d0Stats.toJson());
      _saveToCache(stocksKey, stocks.toJson());
      _loadFromPerformanceCache();
      _loadFromStockCache();
    } catch (e, s) {
      _log.severe('Failed to fetch stats bar: ', e, s);
      return null;
    }
    return;
  }

  void _saveToCache(String key, String data) => _cache.writeString(key, data);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
