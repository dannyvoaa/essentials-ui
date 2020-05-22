///This was generated by a script command you can modify this file as needed 

import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'travel_view_model.dart';

/// Add leading documentation here
class TravelTravelBloc {
  static final _log = Logger('TravelTravelBloc');
  //TODO Remove if unessessary
  final TravelTravelRepository _travelTravelRepository;

  Source<TravelTravelViewModel> get viewModel => toSource(combineLatest(
      /* Add Obserable here */, _createViewModel));

  @provide
  TravelTravelBloc(/* Add package injection requirements */);

  TravelTravelViewModel _createViewModel(/* Replace me with observable */) {
    //TODO: Add your viewModel here
  }
}

/// Constructs new instances of [TopBarTitleBloc]s via the DI framework.
abstract class TravelTravelBlocFactory implements ProvidedService {
  @provide
  TravelTravelBloc travelTravelBloc();
}
