import 'dart:collection';

import 'package:aae/api/hsm_state_machine.dart';
import 'package:aae/inject/annotations.dart';
import 'package:aae/navigation/navigation_helper.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/settings/workflow/modifying/modify_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_events.dart';
import 'package:aae/workflow/common/workflow_state.dart';
import 'package:aae/workflow/common/workflow_state_machine.dart';
import 'package:flutter/material.dart';
import 'package:aae/navigation/routes.dart';
import 'modify_states.dart';
import 'package:inject/inject.dart';
import 'package:aae/settings/workflow/modifying/modify_workflow_bloc_provider.dart';

class ModifyStateMachine extends WorkflowStateMachineBase {
  static final name = 'ModifyStateMachine';
  final Machine<WorkflowState, WorkflowEvent> _hsm;
  final ModifyWorkflowBlocProvider _blocProvider;
  final NavigationHelper _navigation;

  final _eventSubject = createBehaviorSubject<WorkflowEvent>();

  @provide
  ModifyStateMachine(
    @modifySettings this._hsm,
    this._navigation,
    this._blocProvider,
  ) : super(_hsm, _navigation) {
    _setUpHsm();
    _hsm.start();
  }

  @override
  ProvidedService get blocProvider => _blocProvider;

  void _setUpHsm() {
    setUpStateMachine();

    _hsm.root.addHandler(
      WorkflowEvents.userPressedPrimaryButton,
    );
  }

  void _setUpTopicsSelection() {
    // Pop when user presses back -- only in-app back button, this will happen
    // automatically from system back button.
    _hsm[ModifyStates.topicsSelection].addHandler(
      ModifySettingsEvents.userPressedSecondaryButton,
      action: (event, context) {
        _navigation.pop(context);
      },
    );

    // When the navigator pops, transition state to workgroups selection.
    // This is done here rather than in the handler for userPressedBack to cover
    // both the in-app back button and the system back button.
    _hsm[ModifyStates.topicsSelection].addHandlers(
      ModifySettingsEvents.routePopped,
      [backwardTransition(ModifyStates.root)],
    );

    _hsm[ModifyStates.topicsSelection]
        .addHandlers(ModifySettingsEvents.userPressedPrimaryButton, [
      forwardTransition(
        ModifyStates.savePreferences,
        transition: WorkflowTransition.push,
      ),
    ]);
  }

  void _setUpWorkgroupsSelection() {
    // Pop when user presses back -- only in-app back button, this will happen
    // automatically from system back button.
    _hsm[ModifyStates.workgroupsSelection].addHandler(
      ModifySettingsEvents.userPressedSecondaryButton,
      action: (event, context) {
        _navigation.pop(context);
      },
    );

    // When the navigator pops, transition state to workgroups selection.
    // This is done here rather than in the handler for userPressedBack to cover
    // both the in-app back button and the system back button.
    _hsm[ModifyStates.workgroupsSelection].addHandlers(
      ModifySettingsEvents.routePopped,
      [backwardTransition(ModifyStates.topicsSelection)],
    );

    _hsm[ModifyStates.workgroupsSelection].addHandler(
      ModifySettingsEvents.userPressedPrimaryButton,
      action: (event, context) {
        _navigation.pushReplacementNamed(context, root, fromRoot: true);
      },
    );
  }

  @override
  @protected
  UnmodifiableListView<Observable<WorkflowEvent>> get eventObservables =>
      UnmodifiableListView([
        _eventSubject,
        _blocProvider.topicsSelectionBloc().events,
        _blocProvider.workgroupsSelectionBloc().events,
      ]);

  @override

  /// [handle] for [ModifyStateMachine] handles future events in the state
  /// machine and the path for the user to update their settings and preferences
  void handle(WorkflowEvent event, BuildContext context) =>
      _hsm.handle(event, context);

  @override
  void stop() => _hsm.stop();
}

abstract class ModifyStateMachineFactory implements ProvidedService {
  @provide
  ModifyStateMachine modifyStateMachine();
}
