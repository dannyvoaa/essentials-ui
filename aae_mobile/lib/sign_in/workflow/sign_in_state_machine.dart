import 'dart:collection';

import 'package:aae/api/hsm_state_machine.dart';
import 'package:aae/inject/annotations.dart';
import 'package:aae/navigation/navigation_helper.dart';
import 'package:aae/navigation/routes.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_state.dart';
import 'package:aae/workflow/common/workflow_state_machine.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

import 'constants/sign_in_events.dart';
import 'constants/sign_in_states.dart';
import 'sign_in_workflow_bloc_provider.dart';

/// State machine for the [SignInWorkflow].
class SignInStateMachine extends WorkflowStateMachineBase {
  static final name = 'SignInWorkflow';

  final Machine<WorkflowState, WorkflowEvent> _hsm;
  final SignInWorkflowBlocProvider _blocProvider;
  final AaeNavigator _navigation;

  final _eventSubject = createBehaviorSubject<WorkflowEvent>();

  @override
  @protected
  UnmodifiableListView<Observable<WorkflowEvent>> get eventObservables =>
      UnmodifiableListView([
        _eventSubject,
        _blocProvider.signInBloc().events,
        _blocProvider.welcomeBloc().events,
        _blocProvider.loginBloc().events,
        _blocProvider.signInFailedBloc().events,
        _blocProvider.createProfileBloc().events,
        _blocProvider.workflowFooterButtonBloc().events,
      ]);

  @override
  ProvidedService get blocProvider => _blocProvider;

  @provide
  SignInStateMachine(@signInHsm this._hsm, this._navigation, this._blocProvider,) : super(_hsm, _navigation) {
    // HSM's initial state depends on whether this is the initial sign in on app startup or an attempt to switch users. It is the initial sign in if
    // the last value on the profile validity subject either is null or false.
    _setUpHsm(isInitialSignIn: lastEvent(_blocProvider.signInBloc().profileValidity) != true);
    _hsm.start();
  }

  @override
  void handle(WorkflowEvent event, BuildContext context) {
    _hsm.handle(event, context);
  }

  @override
  void stop() {
    _hsm.stop();
  }

  void _setUpHsm({@required bool isInitialSignIn}) {
    setUpStateMachine();
    // Logic for exiting the state machine/navigating back.
    _hsm.root.addHandler(SignInEvents.exit, action: (event, context) {_navigation.pushReplacementNamed(context, root, fromRoot: true);});
    _setUpSignIn(isInitialSignIn);
    _setUpAccountCreation();
  }

  // [isInitial] represents whether this is the initial sign in when the user opens the app.
  void _setUpSignIn(bool isInitial) {
    _hsm[SignInStates.signIn].initialState = isInitial ? _hsm[SignInStates.silentSignIn] : _hsm[SignInStates.silentSignIn];

    // Logic for automatic validity check when there is a new user.
    _hsm[SignInStates.signIn].addHandlers(SignInEvents.currentUserChanged, [forwardTransition(SignInStates.validityCheck,
        extraActions: (_, context) {
          _navigation.removeAllBelowCurrent(context, fromRoot: true);
          _blocProvider.signInBloc()..validate();
        },
      )
    ]);

    _setUpSilentSignIn();
    _setUpWelcomePage();
    _setUpValidityCheck();
    _setUpLoginPage();
  }

  void _setUpAccountCreation() {
    _setUpHubLocationsSelection();
    _setUpWorkgroupsSelection();
    _setUpTopicsSelection();
  }

  void _setUpSilentSignIn() {
    // Entering the silent sign in state should trigger an attempt to sign in silently.
    _hsm[SignInStates.silentSignIn].onEnter = _blocProvider.signInBloc().signInSilently;

    // Override handler for if sign in silently succeeds, in which case the cache should not be cleared.
    _hsm[SignInStates.silentSignIn].addHandlers(SignInEvents.currentUserChanged, [forwardTransition(SignInStates.validityCheck,
      extraActions: (_, __) => _blocProvider.signInBloc().validate())]);

    // If silent sign in fails, should transition to the login page.
    _hsm[SignInStates.silentSignIn].addHandlers(SignInEvents.silentSignInFailed, [forwardTransition(SignInStates.welcomePage)]);
  }

  void _setUpWelcomePage() {
    // Handle a plugin failure by navigating to the failure page.
    _hsm[SignInStates.welcomePage].addHandlers(SignInEvents.authFlowFailed, [forwardTransition(SignInStates.failure)]);
    _hsm[SignInStates.welcomePage].addHandler(SignInEvents.validationSucceeded, action: (event, context) {_eventSubject.sendNext(SignInEvents.exit);});
    _hsm[SignInStates.welcomePage].addHandlers(SignInEvents.userPressedPrimaryButton, [forwardTransition(SignInStates.loginPage, transition: WorkflowTransition.push)]);
  }

  void _setUpValidityCheck() {
    // If profile validation fails, transition to failure page.
    _hsm[SignInStates.validityCheck].addHandlers(SignInEvents.authFlowFailed, [forwardTransition(SignInStates.failure)]);
    // Take user to account creation flow if they don't have a profile.
    _hsm[SignInStates.validityCheck].addHandlers(SignInEvents.profileNotFound, [forwardTransition(SignInStates.accountCreation)]);
    // If profile validation succeeds, exit the state machine.
    _hsm[SignInStates.validityCheck].addHandler(SignInEvents.validationSucceeded, action: (event, context) {_eventSubject.sendNext(SignInEvents.exit);});
  }

  void _setUpLoginPage() {
    // Handle a plugin failure by navigating to the failure page.
    _hsm[SignInStates.loginPage].addHandlers(SignInEvents.profileNotFound, [forwardTransition(SignInStates.hubLocationsSelection, transition: WorkflowTransition.push)]);
  }

  void _setUpHubLocationsSelection() {
    // Pop when user presses back -- only in-app back button, this will happen automatically from system back button.
    _hsm[SignInStates.hubLocationsSelection].addHandler(SignInEvents.userPressedSecondaryButton, action: (event, context) {_navigation.pop(context);});

    // When the navigator pops, transition state to workgroups selection.
    // This is done here rather than in the handler for userPressedBack to cover both the in-app back button and the system back button.
    _hsm[SignInStates.hubLocationsSelection].addHandlers(SignInEvents.routePopped, [backwardTransition(SignInStates.loginPage)]);
    _hsm[SignInStates.hubLocationsSelection].addHandlers(SignInEvents.userPressedPrimaryButton, [forwardTransition(SignInStates.workgroupsSelection, transition: WorkflowTransition.push)]);
  }

  void _setUpWorkgroupsSelection() {
    // Pop when user presses back -- only in-app back button, this will happen automatically from system back button.
    _hsm[SignInStates.workgroupsSelection].addHandler(SignInEvents.userPressedSecondaryButton, action: (event, context) {_navigation.pop(context);});

    // When the navigator pops, transition state to workgroups selection.
    // This is done here rather than in the handler for userPressedBack to cover both the in-app back button and the system back button.
    _hsm[SignInStates.workgroupsSelection].addHandlers(SignInEvents.routePopped, [backwardTransition(SignInStates.hubLocationsSelection)]);
    _hsm[SignInStates.workgroupsSelection].addHandlers(SignInEvents.userPressedPrimaryButton, [forwardTransition(SignInStates.topicsSelection, transition: WorkflowTransition.push)]);
  }

  void _setUpTopicsSelection(){
    // Pop when user presses back -- only in-app back button, this will happen automatically from system back button.
    _hsm[SignInStates.topicsSelection].addHandler(SignInEvents.userPressedSecondaryButton, action: (event, context) {_navigation.pop(context);});

    // When the navigator pops, transition state to workgroups selection.
    // This is done here rather than in the handler for userPressedBack to cover both the in-app back button and the system back button.
    _hsm[SignInStates.topicsSelection].addHandlers(SignInEvents.routePopped, [backwardTransition(SignInStates.workgroupsSelection)]);
    _hsm[SignInStates.topicsSelection].addHandler(SignInEvents.userPressedPrimaryButton, action: (event, context) {
        _blocProvider.createProfileBloc().createProfile();
        _blocProvider.signInBloc().onAccountCreated();
        _navigation.pushReplacementNamed(context, root, fromRoot: true);
      },
    );
  }
}

/// Constructs new instances of [SignInStateMachine]s via the DI framework.
abstract class SignInStateMachineFactory implements ProvidedService {
  @provide
  SignInStateMachine signInStateMachine();
}
