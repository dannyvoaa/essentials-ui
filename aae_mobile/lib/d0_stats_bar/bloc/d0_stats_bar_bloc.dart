import 'package:aae/cache/cache_service.dart';
import 'package:aae/d0_stats_bar/d0_stats_bar_view_model.dart';
import 'package:aae/d0_stats_bar/repository/d0_stats_bar_repository.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// Add leading documentation here
class D0StatsBloc {
  static final _log = Logger('D0StatsBloc');
  //TODO Remove if unessessary
  final D0StatsRepository _d0StatsRepository;
  final CacheService _cacheService;

  Source<D0StatsViewModel> get viewModel => toSource(combineLatest2(
      _d0StatsRepository.stocksValiditySubject,
      _d0StatsRepository.performanceValiditySubject,
      _createViewModel));

  @provide
  D0StatsBloc(this._d0StatsRepository, this._cacheService) {
    _d0StatsRepository.stocksValiditySubject
        .subscribe(onNext: (StockStats data) => _log.shout('$data'));

    _d0StatsRepository.performanceValiditySubject
        .subscribe(onNext: (PerformanceStats perf) => _log.shout('$perf'));
  }

  D0StatsViewModel _createViewModel(
      StockStats stockData, PerformanceStats perfData) {
    return D0StatsViewModel((b) => b
      ..stockStats = stockData.toBuilder()
      ..performanceStats = perfData.toBuilder());
  }
}

/// Constructs new instances of [TopBarTitleBloc]s via the DI framework.
abstract class D0StatsBlocFactory implements ProvidedService {
  @provide
  D0StatsBloc d0StatsBloc();
}
