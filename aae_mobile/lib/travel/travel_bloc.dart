//import 'package:aae/provided_service.dart';
//import 'package:aae/travel/component/trips/trips_view_model.dart';
//import 'package:aae/travel/repository/travel_repository.dart';
//import 'package:aae/rx/bloc_with_rx.dart';
//import 'package:aae/rx/rx_util.dart';
//import 'package:aae/travel/travel_view_model.dart';
//import 'package:inject/inject.dart';
//import 'package:logging/logging.dart';
//
///// BloC for the [TravelComponent].
/////
///// Exposes a [TravelViewModel] for that component to use.
//
//class TravelBloc {
//  static final _log = Logger('TravelBloc');
//  final TravelRepository _travelRepository;
//
//  Source<TravelViewModel> get viewModel => toSource(
//      combineLatest(_travelRepository.currentBalance, _createViewModel));
//
//  @provide
//  TravelBloc(this._travelRepository);
//
//  TravelViewModel _createViewModel(String balance) {
//    return TravelViewModel((b) => b..currentBalance = balance);
//  }
//}
//
///// Constructs new instances of [TravelBloc]s via the DI framework.
//abstract class TravelBlocFactory implements ProvidedService {
//  @provide
//  TravelBloc travelBloc();
//}
