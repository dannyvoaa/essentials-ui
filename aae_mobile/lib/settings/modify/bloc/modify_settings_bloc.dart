import 'package:aae/model/profile.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/settings/workflow/modifying/modify_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:inject/inject.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/settings/modify/repository/modify_shared_data_repository.dart';
import 'package:aae/profile/repository/profile_repository.dart';

class ModifySettingsBloc {
  static final _log = Logger('ModifySettingsBloc');

  final ProfileRepository _profileRepository;
  final ModifySharedDataRepository _modifySharedDataRepository;

  final _currentUser = createBehaviorSubject<Profile>();
  final _eventSubject = Subject<WorkflowEvent>();

  Observable<WorkflowEvent> get events => _eventSubject;

  @provide
  @singleton
  ModifySettingsBloc(
      this._profileRepository, this._modifySharedDataRepository) {
    _modifySharedDataRepository.workgroups.subscribe(
        onCompleted: () =>
            _eventSubject.sendNext(ModifySettingsEvents.onLoadSuccessful));
    _modifySharedDataRepository.topics.subscribe(
        onCompleted: () =>
            _eventSubject.sendNext(ModifySettingsEvents.onLoadSuccessful));
  }
}
