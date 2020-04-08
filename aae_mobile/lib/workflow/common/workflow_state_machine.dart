import 'dart:collection';

import 'package:aae/api/hsm_state_machine.dart';
import 'package:aae/navigation/navigation_helper.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_events.dart';
import 'package:aae/workflow/common/workflow_state.dart';
import 'package:flutter/material.dart';

/// The possible types of navigation between workflow pages.
enum WorkflowTransition {
  /// Uses [Navigator.pushNamed] to transition to the new page.
  ///
  /// Use this when you want to be able to go back to the current page. Don't
  /// forget to add a routePopped handler to the second state with a
  /// backwardTransition back to the first state.
  push,

  /// Uses [Navigator.pushReplacementNamed] to transition to the new page.
  ///
  /// This is the default for forward transitions. Use this when you don't want
  /// to be able to go back to the current page, but you don't want to mess with
  /// the stack otherwise.
  replace,

  /// Uses [Navigator.pushNamedAndRemoveUntil] to transition to the new page and
  /// remove everything else from the nav stack.
  ///
  /// Use this when transitioning the user past a point of no return. They will
  /// not be able to go back to any previous page. Example: Over several screens
  /// you gather data from the user that will be used to make a single RPC. The
  /// user can go back and forth endlessly between the screens where they enter
  /// data. Once they press next on the last screen, the RPC will be made and
  /// the user's selections will be final. You use [replaceAll] when
  /// transitioning away from the last data entry screen, to not allow them to
  /// go back once the RPC is made.
  replaceAll,
}

/// Superclass for a state machine that can be used in a [Workflow].
///
/// Processes events of type [E]. Typically, implementing classes will contain
/// a [Machine]<WorkflowState, E> to handle the events. This class should define
/// states that the user can move through in the workflow and event handlers
/// that transition between the states and transition the UI as well, through
/// navigation. It is also responsible for delegating tasks to the various BLoCs
/// in the flow and handling events that they generate.
///
/// This class is a [NavigatorObserver] for the [Workflow]'s inner [Navigator].
/// Override [NavigatorObserver] methods in order to generate events in response
/// to navigation actions -- see didPush in [WorkflowStateMachineBase].
abstract class WorkflowStateMachine<E extends WorkflowEvent>
    extends NavigatorObserver {
  /// Publishes events that should be sent back to the machine with context.
  Observable<E> get events;

  /// Handles [event] given the current [context].
  ///
  /// Typically this will simply delegate to a [Machine].
  void handle(E event, BuildContext context);

  /// Stops the state machine.
  ///
  /// Called when the backing widget is disposed.
  void stop();

  /// Getter for a service that knows how to provide specific BLoCs needed in
  /// the [Workflow].
  ///
  /// This will be passed to the [Workflow]'s [ServiceProvider].
  ProvidedService get blocProvider;
}

/// Base class that provides the following functionality:
///   * Merges events from all event sources defined by the subclass (i.e. some
///     number of BLoCs) and exposes them as one [Observable].
///   * Observes pop events, and sends a routePopped event every time the
///     Workflow Navigator is popped. Subclasses can handle this event in order
///     to transition state backwards when the user presses the back button.
abstract class WorkflowStateMachineBase
    extends WorkflowStateMachine<WorkflowEvent> {
  final _popEventSubject = Subject<WorkflowEvent>();

  final Machine<WorkflowState, WorkflowEvent> _hsm;
  final NavigationHelper _navigation;

  WorkflowStateMachineBase(this._hsm, this._navigation);

  /// Defines a list of [Observable]s that fire relevant events for the state
  /// machine.
  @protected
  UnmodifiableListView<Observable<WorkflowEvent>> get eventObservables;

  /// Merges all of the observables defined by the subclass with a subject
  /// that fires when a route is popped off the stack.
  @override
  Observable<WorkflowEvent> get events =>
      Observable.merge(eventObservables).mergeWith(_popEventSubject);

  /// Creates the default event handler to transition forward to the state
  /// defined by [target], with guard function [guard] if provided, calling
  /// [extraActions] if provided.
  ///
  /// [replaceCurrentRoute] controls the navigation behavior if [target] is
  /// a navigable state. If true, [pushReplacementNamed] will be called,
  /// otherwise [pushNamed] will be used. See Flutter [Navigator] docs.
  ///
  /// Should not be used for back-transitions (i.e. handling routePopped
  /// events). Use backwardTransition instead.
  @protected
  EventHandler<WorkflowState, WorkflowEvent> forwardTransition(
    WorkflowState target, {
    GuardFunction<WorkflowEvent> guard,
    ActionFunction<WorkflowEvent> extraActions,
    WorkflowTransition transition = WorkflowTransition.replace,
  }) {
    return EventHandler(
      target: _hsm[target],
      guard: guard,
      action: (event, context) {
        if (extraActions != null) extraActions(event, context);
        _stateNavigationAction(
          target,
          transition: transition,
        )(event, context);
      },
    );
  }

  /// Creates the default event handler to transition backward to the state
  /// defined by [target], with guard function [guard] if provided, calling
  /// [extraActions] if provided.
  ///
  /// Should be used when transitioning 'back' to a state, i.e. in response to
  /// a routePopped event. Does not do any navigation actions.
  @protected
  EventHandler<WorkflowState, WorkflowEvent> backwardTransition(
    WorkflowState target, {
    GuardFunction<WorkflowEvent> guard,
    ActionFunction<WorkflowEvent> extraActions,
  }) {
    return EventHandler(
      target: _hsm[target],
      guard: guard,
      action: extraActions,
    );
  }

  /// Creates the default action function when transitioning to [target].
  ///
  /// [replaceCurrentRoute] controls the navigation behavior if [target] is
  /// a navigable state. If true, [pushReplacementNamed] will be called,
  /// otherwise [pushNamed] will be used. See Flutter [Navigator] docs.
  ActionFunction<WorkflowEvent> _stateNavigationAction(WorkflowState target,
      {WorkflowTransition transition = WorkflowTransition.replace}) {
    return (event, context) {
      target.navigationRoute(_hsm).ifPresent((route) {
        switch (transition) {
          case WorkflowTransition.push:
            _navigation.pushNamed(context, route);
            break;
          case WorkflowTransition.replace:
            _navigation.pushReplacementNamed(context, route);
            break;
          case WorkflowTransition.replaceAll:
            _navigation.replaceAllWithNamed(context, route);
        }
      });
    };
  }

  /// Sets up the state machine.
  ///
  /// Specifically, recursively adds and sets up all children of the root, and
  /// also sets the initial states.
  @protected
  void setUpStateMachine() {
    _setUpStateMachine(_hsm.root.id);
  }

  // Recursive helper function for setUpStateMachine().
  void _setUpStateMachine(WorkflowState root) {
    // Add children.
    root.children.forEach(_hsm[root].newChild);

    // Set initial state.
    root.initial.ifPresent((state) {
      _hsm[root].initialState = _hsm[state];
    });

    // Set up each child.
    root.children.forEach(_setUpStateMachine);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings?.name?.isNotEmpty == true) {
      _popEventSubject.sendNext(
        WorkflowEvents.routePopped..data = previousRoute.settings.name,
      );
    }
  }
}
