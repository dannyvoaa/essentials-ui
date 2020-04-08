import 'package:aae/provided_service.dart';
import 'package:aae/recognition/component/points_balance/points_balance_view_model.dart';
import 'package:aae/recognition/repository/recognition_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [PointsBalanceComponent].
///
/// Exposes a [PointsBalanceViewModel] for that component to use.

class PointsBalanceBloc {
  static final _log = Logger('PointsBalanceBloc');
  final RecognitionRepository _recognitionRepository;

  Source<PointsBalanceViewModel> get viewModel => toSource(
      combineLatest(_recognitionRepository.currentBalance, _createViewModel));

  @provide
  PointsBalanceBloc(this._recognitionRepository);

  PointsBalanceViewModel _createViewModel(String balance) {
    return PointsBalanceViewModel((b) => b..currentBalance = balance);
  }
}

/// Constructs new instances of [PointsBalanceBloc]s via the DI framework.
abstract class PointsBalanceBlocFactory implements ProvidedService {
  @provide
  PointsBalanceBloc pointsBalanceBloc();
}
