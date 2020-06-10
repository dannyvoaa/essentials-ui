import 'package:aae/provided_service.dart';
import 'package:aae/travel/component/current_trips/current_trips_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [CurrentTripsComponent].
///
/// Exposes a [CurrentTripsViewModel] for that component to use.

class CurrentTripsBloc {
  static final _log = Logger('CurrentTripsBloc');
  final TravelRepository _travelRepository;

  Source<CurrentTripsViewModel> get viewModel => toSource(
      combineLatest(_travelRepository.currentBalance, _createViewModel));

  @provide
  CurrentTripsBloc(this._travelRepository);

  CurrentTripsViewModel _createViewModel(String balance) {
    return CurrentTripsViewModel((b) => b..currentBalance = balance);
  }
}

/// Constructs new instances of [CurrentTripsBloc]s via the DI framework.
abstract class CurrentTripsBlocFactory implements ProvidedService {
  @provide
  CurrentTripsBloc currentTripsBloc();
}
