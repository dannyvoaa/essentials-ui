import 'package:aae/model/recognition_register.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/recognition/component/points_history/points_history_view_model.dart';
import 'package:aae/recognition/repository/recognition_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [PointsHistoryComponent].
///
/// Exposes a [PointsHistoryViewModel] for that component to use.

class PointsHistoryBloc {
  static final _log = Logger('PointsHistoryBloc');
  final RecognitionRepository _recognitionRepository;

  Source<PointsHistoryViewModel> get viewModel => toSource(combineLatest(
      _recognitionRepository.recognitionRegister, _createViewModel));

  @provide
  PointsHistoryBloc(this._recognitionRepository);

  PointsHistoryViewModel _createViewModel(
      BuiltList<RecognitionRegister> register) {
    return PointsHistoryViewModel(
        (b) => b..recognitionHistory.addAll(register));
  }
}

/// Constructs new instances of [PointsBalanceBloc]s via the DI framework.
abstract class PointsHistoryBlocFactory implements ProvidedService {
  @provide
  PointsHistoryBloc pointsHistoryBloc();
}
