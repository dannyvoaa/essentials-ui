import 'package:aae/model/priority_list.dart';

import 'package:aae/provided_service.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/priority_list/details/priority_list_view_model.dart';
import 'package:aae/travel/repository/travel_repository.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
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

  @provide
  PriorityListBloc(this._travelRepository);

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
