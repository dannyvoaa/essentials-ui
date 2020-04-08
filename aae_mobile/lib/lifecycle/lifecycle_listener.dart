import 'package:aae/lifecycle_managed_service.dart';
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';

final _log = Logger('LifecycleListener');

/// A top level widget that listens for lifecycle event changes.
class LifecycleListener extends StatefulWidget {
  final Widget child;
  final WidgetsBindingSupplier widgetsBindingSupplier;
  final Iterable<LifecycleManagedService> services;

  LifecycleListener(
      {@required Iterable<LifecycleManagedService> services,
      @required Widget child})
      : this._(child, () => WidgetsBinding.instance, services);

  @visibleForTesting
  LifecycleListener.forTest(
      {@required WidgetsBindingSupplier widgetsBindingSupplier,
      @required Iterable<LifecycleManagedService> services})
      : this._(Container(), widgetsBindingSupplier, services);

  LifecycleListener._(this.child, this.widgetsBindingSupplier, this.services);

  @override
  _LifecycleListenerState createState() => _LifecycleListenerState(
      child: child,
      widgetsBindingSupplier: widgetsBindingSupplier,
      services: services);
}

class _LifecycleListenerState extends State<LifecycleListener>
    with WidgetsBindingObserver {
  final Widget child;
  final WidgetsBindingSupplier widgetsBindingSupplier;
  final Iterable<LifecycleManagedService> services;
  AppLifecycleState _state = AppLifecycleState.resumed;

  _LifecycleListenerState(
      {@required this.child,
      @required this.widgetsBindingSupplier,
      @required this.services});

  @override
  void initState() {
    super.initState();
    widgetsBindingSupplier().addObserver(this);
  }

  @override
  void dispose() {
    widgetsBindingSupplier().removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    services.forEach(_notifyLifecycleState);
    return child;
  }

  void _notifyLifecycleState(LifecycleManagedService service) {
    switch (_state) {
      case AppLifecycleState.resumed:
        service.onResume();
        break;
      case AppLifecycleState.inactive:
        // Use this carefully since we don't want to pause most of things when
        // inactive, because inactive handles the following:
        //
        // "Apps transition to this state when another activity is focused, such
        // as a split-screen app, a phone call, a picture-in-picture app, a
        // system dialog, or another window."
        service.onInactive();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        service.onPause();
        break;
      default:
        _log.shout('Unknown app lifecycle state: $_state');
        break;
    }
  }
}

/// A typedef for supplying a custom [WidgetsBindingSupplier] for tests.
@visibleForTesting
typedef WidgetsBinding WidgetsBindingSupplier();
