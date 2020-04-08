import 'dart:async';

import 'package:aae/build_flavor.dart';
import 'package:aae/inject/mobile_module.dart';
import 'package:aae/lifecycle/lifecycle_listener.dart';
import 'package:aae/lifecycle_managed_service.dart';
import 'package:aae/logging/logging.dart';
import 'package:aae/navigation/app_scaffold.dart';
import 'package:aae/navigation/bottom_navigation.dart';
import 'package:aae/navigation/main_page_navigator.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/provided_service.dart';
import 'package:aae/service_provider.dart';
import 'package:aae/sign_in/workflow/sign_in_workflow.dart';
import 'package:aae/settings/workflow/modifying/modify_workflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// Main widget of the AAE app.
class Aae extends StatelessWidget {
  final GlobalRouteHandler _globalRouteHandler;

  Aae(
    this._globalRouteHandler,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AmericanSans'),
      title: 'American Essentials',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: true,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child,
        );
      },
      onGenerateRoute: _globalRouteHandler.onGenerateRoute,
      initialRoute: routes.buildSignInRoute(),
      home: AppScaffold(), //MARK: why this?
    );
  }
}

/// A custom [ScrollBehavior] that specifies how a viewport should behave when
/// scrolling.
class CustomScrollBehavior extends ScrollBehavior {
  /// Overridden to disable [MaterialApp]s default glow overscroll indicator on
  /// Android.
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class GlobalRouteHandler {
  GlobalRouteHandler();

  Route onGenerateRoute(RouteSettings settings) {
    Uri uri;
    try {
      uri = Uri.parse(settings.name);
    } on FormatException catch (e, s) {
      _log.severe('Failed to parse navigation route: ${settings.name}', e, s);
      return null;
    }
    _log.info('Generating global route for $uri');

    if (uri.pathSegments.isEmpty || uri.pathSegments.first != routes.global) {
      _log.severe('Root navigation route missing "${routes.global}": $uri');
      return null;
    }
    if (uri.pathSegments.length < 2) {
      _log.severe('Root navigation missing path information: $uri');
      return null;
    }
    switch (uri.pathSegments[1]) {
      case routes.signIn:
        return MaterialPageRoute<void>(
          builder: (context) => SignInWorkflow(),
          settings: settings,
        );
      case routes.settings:
        return MaterialPageRoute<void>(
          builder: (context) => ModifyWorkflow(),
          settings: settings,
        );
      case routes.travel:
        final key = GlobalKey<NavigatorState>();

        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => WillPopScope(
            onWillPop: AppScaffoldState.willPopCallback(key: key),
            child: MainPageNavigator(
              navigatorKey: key,
              page: MainPage.home,
            ),
          ),
          fullscreenDialog: true,
        );
      default:
        return null;
    }
  }
}
