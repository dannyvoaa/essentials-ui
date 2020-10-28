import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/priority_list_cabin.dart';
import 'package:aae/model/priority_list_passenger.dart';

import 'package:aae/provided_service.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/priority_list/priority_list_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// BloC for the [PriorityListComponent].
///
/// Exposes a [PriorityListViewModel] for that component to use.

class PriorityListBloc {
  static final _log = Logger('PriorityListBloc');
  final TravelRepository _travelRepository;

  Observable<PriorityList> _dummyPriorityListObservable;

  Source<PriorityListViewModel> get viewModel =>
      toSource(combineLatest(_travelRepository.currentPriorityList, _createViewModel));

  //Source<PriorityListViewModel> get viewModel =>
  //    toSource(combineLatest(_dummyPriorityListObservable, _createViewModel));


  @provide
  PriorityListBloc(this._travelRepository) {

    var dummyFirstCabin = PriorityListCabin((b) => b
      ..cabinType = "FIRST"
      ..confirmedSeats = 16
      ..assignedSeats = 14
      ..unassignedSeats = 2
    );

    var dummyBusinessCabin = PriorityListCabin((b) => b
      ..cabinType = "BUSINESS"
      ..confirmedSeats = 14
      ..assignedSeats = 52
      ..unassignedSeats = 2
    );

    var dummyPremiumEconomyCabin = PriorityListCabin((b) => b
      ..cabinType = "PREMIUMECONOMY"
      ..confirmedSeats = 28
      ..assignedSeats = 1
      ..unassignedSeats = 27
    );

    var dummyMainCabin = PriorityListCabin((b) => b
        ..cabinType = "COACH"
        ..confirmedSeats = 151
        ..assignedSeats = 147
        ..unassignedSeats = 18
    );

    var revenueStandbys = BuiltList<PriorityListPassenger>([
      PriorityListPassenger((b) => b
        ..firstName = "T"
        ..lastName = "ASF"
        ..groupNumber = null
        ..priorityNumber = 1
        ..seatNumber = "4B"
      ),
    ]).toBuilder();

    var nonRevStandbys = BuiltList<PriorityListPassenger>([
      PriorityListPassenger((b) => b
          ..firstName = "J"
          ..lastName = "CON"
          ..groupNumber = "AC2"
          ..remarks = "HERE"
          ..priorityNumber = 2
          ..priorityCode = "D1"
          ..cabin = "FIRST"
          ..seatNumber = "4D"
      ),
      PriorityListPassenger((b) => b
        ..firstName = "N"
        ..lastName = "FAN"
        ..groupNumber = "AC2"
        ..remarks = null
        ..priorityCode = "D3"
        ..priorityNumber = 3
        ..cabin = "COACH"
      )
    ]).toBuilder();

    var dummyPriorityList = PriorityList((b) => b
      ..originAirportCode = "DFW"
      ..destinationAirportCode = "SAN"
      ..departureGate = "C16"
      ..flightNumber = 1243
      ..departureTime = "2020-10-20T08:51:00"
      ..cabins = BuiltList<PriorityListCabin>([
        dummyFirstCabin,
        //dummyBusinessCabin,
        //dummyPremiumEconomyCabin,
        dummyMainCabin,
      ]).toBuilder()
      ..nonrevStandbys = nonRevStandbys
      ..revenueStandbys = revenueStandbys
    );

    _dummyPriorityListObservable = createBehaviorSubject<PriorityList>(
        initial: dummyPriorityList
    );
  }

  void loadPriorityList(String origin, int flightNum, DateTime date) {
    _travelRepository.loadPriorityList(origin, flightNum, date);
  }


  PriorityListViewModel _createViewModel(PriorityList priorityList) {
    return PriorityListViewModel(
        priorityList: priorityList,
        loadPriorityList: loadPriorityList
    );
  }
}



/// Constructs new instances of [PriorityListBloc]s via the DI framework.
abstract class PriorityListBlocFactory implements ProvidedService {
  @provide
  PriorityListBloc priorityListBloc();
}
