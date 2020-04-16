import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:built_value/built_value.dart';

part 'd0_stats_bar_view_model.g.dart';

/// View model representing a [D0StatsView].
abstract class D0StatsViewModel
    implements Built<D0StatsViewModel, D0StatsViewModelBuilder> {

 StockStats get stockStats;     
 PerformanceStats get performanceStats;

  D0StatsViewModel._();
  
  factory D0StatsViewModel([updates(D0StatsViewModelBuilder b)]) =
      _$D0StatsViewModel;
}
