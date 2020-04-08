import 'dart:async';

import 'package:aae/build_flavor.dart';
import 'package:aae/inject/mobile_module.dart';
import 'package:aae/lifecycle/lifecycle_listener.dart';
import 'package:aae/lifecycle_managed_service.dart';
import 'package:aae/logging/logging.dart';
import 'package:aae/programmatic_main.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

final _log = Logger('main');

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Entry point of the app.
void programmaticMain(BuildFlavorConfiguration configuration) async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging();

  final injector = await AppInjector.create(
    // Spin up dependencies here
    MobileModule(),
  );

  // Set up additional logging after the injector has been created, so we can
  // resolve the dependencies.
  setupAdditionalLogging(
    injector.provideLogBuffer(),
  );

  final services = (injector.services() as Iterable<ProvidedService>).toList()
    ..add(injector);
  final lifecycleServices = injector.lifecycleManagedServices();
  injector..createRepositoryManager();

  // Wrap runApp in a runZoned to catch errors Flutter normally wouldn't catch.
  runZoned<Null>(() {
    runApp(ServiceProvider(
        services: services,
        child: LifecycleListener(
            child: Aae(
              GlobalRouteHandler(),
            ),
            services: lifecycleServices as Iterable<LifecycleManagedService>)));
  }, onError: (error, stackTrace) async {
    // Pipe the error over to [FlutterError] which is set up in logging.dart.
    FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace));
  });
}

void main() async {
  programmaticMain(
      BuildFlavorConfiguration.configurationFor(BuildFlavor.debug));
}
