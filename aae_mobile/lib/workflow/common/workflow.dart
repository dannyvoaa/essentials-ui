import 'dart:collection';

import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/navigation/transitionless_page_route.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/service_provider.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_state_machine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// Creates a [WorkflowStateMachine] with events of type [E] given a
/// [BuildContext].
typedef WorkflowStateMachine<E> WorkflowStateMachineFactory<
    E extends WorkflowEvent>(BuildContext context);

/// Creates a [WidgetBuilder] describing how to build the page for the route
/// described by [settings].
///
/// This is similar to the onGenerateRoute function used in [Navigator]s, and
/// will be used by the workflow navigator.
typedef WidgetBuilder PageGenerator(RouteSettings settings);

/// An arbitrary UI flow pushed onto the root-level [Navigator], intended to
/// guide the user through a process.
///
/// This widget is intended to be wrapped in a more specific widget.
/// Navigate to your workflow widget on the root navigator to
/// bring it up, and pop off the root navigator to close it.
///
/// [E] is the type of [WorkflowEvent] your flow will handle. You can subclass
/// [WorkflowEvent] if you will need additional data along with the event.
///

class Workflow<E extends WorkflowEvent> extends StatefulWidget {
  /// A function that will create the state machine for this workflow.
  ///
  /// Called once, when the state is first created.
  final WorkflowStateMachineFactory<E> factory;

  /// A function defining how to respond to named routes pushed on the
  /// [Workflow]'s [Navigator].
  ///
  /// Called every time a named route is pushed.
  final PageGenerator onGenerateRoute;

  /// An optional key to use for the Navigator.
  ///
  /// This parameter should be passed if the enclosing widget needs a reference
  /// to this [Workflow]'s [Navigator], e.g. for a [WillPopScope] callback.
  final GlobalKey<NavigatorState> navigatorKey;

  Workflow({
    this.navigatorKey,
    @required this.factory,
    @required this.onGenerateRoute,
  });

  @override
  State<Workflow> createState() => _WorkflowState<E>();
}

class _WorkflowState<E extends WorkflowEvent> extends State<Workflow<E>> {
  static final _log = Logger('Workflow');

  WorkflowStateMachine<E> _stateMachine;
  Disposable _subscription;

  /// Keeps track of the current context in the tree below the [Navigator].
  ///
  /// This allows an up-to-date context to be passed to the state machine with
  /// each event, so that the context can be used for navigating to a new page.
  _ContextHolder _contextHolder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initializations -- these only execute once.
    _contextHolder ??= _ContextHolder(context);
    _stateMachine ??= widget.factory(context);
    // Subscribe to events coming from the state machine and pass them back
    // along with the context of the current page. This triggers any handlers
    // for the event.
    _subscription ??= _stateMachine.events.subscribe(onNext: (event) {
      _stateMachine.handle(event, _contextHolder.currentContext);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ServiceProvider(
      services: [_stateMachine.blocProvider],
      parent: ServiceProvider.of(context),
      child: Navigator(
        key: widget.navigatorKey,
        observers: [_stateMachine, _contextHolder],
        // CupertinoPageRoute gives us iOS-style sliding animations between
        // pages, which is what is desired.
        onGenerateRoute: (settings) {
          Widget routeBuilder(BuildContext context) {
            // When building a page: first steal the context, then delegate
            // to the page-building logic defined by the developer.;
            _contextHolder.currentContext = context;
            final widgetBuilder = widget.onGenerateRoute(settings);
            if (widgetBuilder == null) {
              _log.severe(
                  'Failed to generate widget for route ${settings.name} '
                  'in Workflow navigator.');
              throw WorkflowRouteError(
                  '${settings.name} is not a valid route.');
            }

            return widgetBuilder(context);
          }

          // Use a transitionless route for the first page to improve
          // performance of starting a workflow.
          return (settings.name == routes.root)
              ? TransitionlessPageRoute(
                  settings: settings,
                  builder: routeBuilder,
                )
              : CupertinoPageRoute<void>(
                  settings: settings,
                  builder: routeBuilder,
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stateMachine?.stop();
    _subscription?.dispose();
  }
}

// Maintains a stack of build contexts so that the context passed to event
// handlers is always up to date.
class _ContextHolder extends NavigatorObserver {
  final _contextStack = ListQueue<BuildContext>();

  /// Gets the current context below the [Navigator].
  BuildContext get currentContext => _contextStack.last;

  /// Sets the current context.
  set currentContext(BuildContext context) {
    _contextStack.addLast(context);
  }

  _ContextHolder(BuildContext initial) {
    currentContext = initial;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings?.name?.isNotEmpty == true) {
      _contextStack.removeLast();
    }
  }
}

/// An error indicating that navigation routes were misused in a workflow.
///
/// Thrown when a route is pushed that onGenerateRoute does not handle.
class WorkflowRouteError extends Error {
  final String message;

  WorkflowRouteError(this.message);

  @override
  String toString() => 'WorkflowRouteError: $message';
}
