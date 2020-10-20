import 'package:aae/model/event.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/travel/component/flight_status/flight_status_view_model.dart';
import 'package:aae/travel/component/search/search_event.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [TripsComponent].
///
/// Exposes a [FlightStatusViewModel] for that component to use.

class FlightStatusBloc {
  static final _log = Logger('FlightStatusBloc');
  final TravelRepository _travelRepository;

  fetchFlightStatus(String searchField1, String searchField2){
    _travelRepository.fetchFlightStatus(searchField1, '2020-10-06');
  }

  Source<FlightStatusViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.flightStatus, _createViewModel));

  @provide
  FlightStatusBloc(this._travelRepository);

  FlightStatusViewModel _createViewModel(FlightStatus flightStatus) {
    return FlightStatusViewModel((b) => b..flightStatus = flightStatus.toBuilder());
  }
}

/// Constructs new instances of [FlightStatusBloc]s via the DI framework.
abstract class FlightStatusBlocFactory implements ProvidedService {
  @provide
  FlightStatusBloc flightStatusBloc();
}