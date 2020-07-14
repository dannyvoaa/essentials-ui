import 'dart:collection';

import 'package:aae/model/hub_location.dart';
import 'package:aae/profile/repository/locations_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:quiver/core.dart';
import 'package:aae/sign_in/component/hub_locations_selection/hub_locations_selection_view_model.dart';

/// BloC for the [HubLocationsSelectionComponent].
///
/// Exposes a [HubLocationsSelectionViewModel] for that component to use.
class HubLocationsSelectionBloc {
  final SignInSharedDataRepository _sharedDataRepository;
  final HubLocationsRepository _hubLocationsRepository;

  final _selectedHubLocations = createBehaviorSubject<List<String>>(initial: []);

  final _events = Subject<WorkflowEvent>();

  /// Publishes events to be consumed by the [SignInStateMachine].
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [HubLocationsSelectionViewModel].
  Source<HubLocationsSelectionViewModel> get viewModel => toSource(combineLatest2(Observable.fromFuture(_hubLocationsRepository.hubLocationsList), _selectedHubLocations, _createViewModel));

  @provide
  HubLocationsSelectionBloc(
      this._sharedDataRepository, this._hubLocationsRepository);

  HubLocationsSelectionViewModel _createViewModel(
      UnmodifiableListView<HubLocation> hubLocations,
      List<String> selectedHubLocations,
      ) =>
      HubLocationsSelectionViewModel(
        nextButtonEnabled: true,
        hubLocations: BuiltList(
          hubLocations.map(
                (hubLocations) => HubLocationsViewModel(
              isSelected: selectedHubLocations.contains(hubLocations.hubLocations),
              hubLocation: hubLocations.hubLocations,
              onHubLocationPressed: () {
                if (selectedHubLocations.contains(hubLocations.hubLocations)) {
                  selectedHubLocations.remove(hubLocations.hubLocations);
                  _selectedHubLocations.sendNext(selectedHubLocations);
                  print(
                      '------------------------------------Removed: ${hubLocations.hubLocations}-------------------------------------');
                } else
                  selectedHubLocations.add(hubLocations.hubLocations);
                print(
                    '------------------------------------Added: ${hubLocations.hubLocations}-------------------------------------');
                _sharedDataRepository.hubLocations.sendNext(selectedHubLocations);
                _selectedHubLocations.sendNext(selectedHubLocations);
              },
            ),
          ),
        ),
      );
}

/// Constructs new instances of [HubLocationsSelectionBloc]s via the DI framework.
abstract class HubLocationsSelectionBlocFactory implements ProvidedService {
  @provide
  HubLocationsSelectionBloc hubLocationsSelectionBloc();
}
