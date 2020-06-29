import 'package:aae/model/pnrs.dart';
import 'package:aae/model/recognition_register.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/travel/component/trips/trips_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [TripsComponent].
///
/// Exposes a [TripsViewModel] for that component to use.

class TripsBloc {
  static final _log = Logger('TripsBloc');
  final TravelRepository _travelRepository;

  Source<TripsViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.pnrs, _createViewModel));

  @provide
  TripsBloc(this._travelRepository);

  TripsViewModel _createViewModel(BuiltList<Pnrs> pnrs) {
    return TripsViewModel((b) => b..trips.addAll(pnrs));
  }
}

/// Constructs new instances of [TripsBloc]s via the DI framework.
abstract class TripsBlocFactory implements ProvidedService {
  @provide
  TripsBloc tripsBloc();
}
