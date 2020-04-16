import 'dart:collection';

import 'package:aae/model/workgroup.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
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

import 'workgroups_selection_view_model.dart';

/// BloC for the [WorkgroupsSelectionComponent].
///
/// Exposes a [WorkgroupsSelectionViewModel] for that component to use.
class WorkgroupsSelectionBloc {
  final SignInSharedDataRepository _sharedDataRepository;
  final WorkgroupsRepository _workgroupsRepository;

  final _currentWorkgroups = createBehaviorSubject<List<String>>(initial: []);

  final _events = Subject<WorkflowEvent>();

  /// Publishes events to be consumed by the [SignInStateMachine].
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [WorkgroupsSelectionViewModel].
  Source<WorkgroupsSelectionViewModel> get viewModel => toSource(combineLatest2(
      Observable.fromFuture(_workgroupsRepository.workgroupsList),
      _currentWorkgroups,
      _createViewModel));

  @provide
  WorkgroupsSelectionBloc(
      this._sharedDataRepository, this._workgroupsRepository);

  WorkgroupsSelectionViewModel _createViewModel(
    UnmodifiableListView<Workgroup> workgroups,
    List<String> selectedWorkgroups,
  ) =>
      WorkgroupsSelectionViewModel(
        nextButtonEnabled: true,
        workgroups: BuiltList(
          workgroups.map(
            (workgroups) => WorkgroupsViewModel(
              isSelected: selectedWorkgroups.contains(workgroups.workgroups),
              workgroup: workgroups.workgroups,
              borderColor: selectedWorkgroups.contains(workgroups.workgroups) &&
                      selectedWorkgroups.contains(workgroups.workgroups)
                  ? Optional.of(AaeColors.black)
                  : Optional.absent(),
              onWorkgroupPressed: () {
                if (selectedWorkgroups.contains(workgroups.workgroups)) {
                  selectedWorkgroups.remove(workgroups.workgroups);
                  _currentWorkgroups.sendNext(selectedWorkgroups);
                  print(
                      '------------------------------------Removed: ${workgroups.workgroups}-------------------------------------');
                } else
                  selectedWorkgroups.add(workgroups.workgroups);
                print(
                    '------------------------------------Added: ${workgroups.workgroups}-------------------------------------');
                _sharedDataRepository.workgroups.sendNext(selectedWorkgroups);
                _currentWorkgroups.sendNext(selectedWorkgroups);
              },
            ),
          ),
        ),
      );
}

/// Constructs new instances of [WorkgroupsSelectionBloc]s via the DI framework.
abstract class WorkgroupsSelectionBlocFactory implements ProvidedService {
  @provide
  WorkgroupsSelectionBloc workgroupsSelectionBloc();
}
