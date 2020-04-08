import 'dart:collection';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/static_values/static_keys.dart';
import 'package:aae/model/workgroup.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
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
  final CacheService _cacheService;

  final _currentWorkgroups =
      createBehaviorSubject<Optional<Workgroup>>(initial: Optional.absent());

  final _events = Subject<WorkflowEvent>();

  /// Publishes events to be consumed by the [SignInStateMachine].
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [WorkgroupsSelectionViewModel].
  Source<WorkgroupsSelectionViewModel> get viewModel => toSource(combineLatest2(
      Observable.fromFuture(_workgroupsRepository.workgroupsList).startWith(
        UnmodifiableListView([]),
      ),
      _currentWorkgroups,
      _createViewModel));

  void clear() {
    _currentWorkgroups.sendNext(null);
    _sharedDataRepository.workgroups.sendNext(Optional.absent());
  }

  @provide
  WorkgroupsSelectionBloc(this._sharedDataRepository,
      this._workgroupsRepository, this._cacheService);

  WorkgroupsSelectionViewModel _createViewModel(
    UnmodifiableListView<Workgroup> workgroups,
    Optional<Workgroup> selectedWorkgroups,
  ) =>
      WorkgroupsSelectionViewModel(
        onWorkgroupsSubmitted: _onNextPressed,
        nextButtonEnabled: true,
        workgroups: BuiltList(
          workgroups.map(
            (workgroups) => WorkgroupsViewModel(
              workgroup: workgroups.workgroups,
              borderColor: selectedWorkgroups.isPresent &&
                      workgroups == selectedWorkgroups.value
                  ? Optional.of(AaeColors.black)
                  : Optional.absent(),
              onWorkgroupPressed: () => _onWorkgroupPressed(workgroups),
            ),
          ),
        ),
      );

  void _onWorkgroupPressed(Workgroup workgroup) {
    _currentWorkgroups.sendNext(Optional.of(workgroup));
    //TODO (rpaglinawan): check cache mechanism
    _cacheService.writeString(workgroupCacheKey, workgroup.workgroups);
    _sharedDataRepository.workgroups.sendNext(Optional.of(workgroup));
  }

  void _onNextPressed(Workgroup workgroup) async {
    _sharedDataRepository.workgroups.sendNext(Optional.of(workgroup));
    _events.sendNext(SignInEvents.exit);
  }
}

/// Constructs new instances of [WorkgroupsSelectionBloc]s via the DI framework.
abstract class WorkgroupsSelectionBlocFactory implements ProvidedService {
  @provide
  WorkgroupsSelectionBloc workgroupsSelectionBloc();
}
