import 'package:aae/events/page/events_page.dart';
import 'package:aae/home/page/home_page.dart';
import 'package:aae/home/page/news_page.dart';
import 'package:aae/recognition/page/recognition_page.dart';
import 'package:aae/settings/page/settings_page.dart';
import 'package:aae/article/page/article_page.dart';
import 'package:aae/programmatic_main.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'bottom_navigation.dart';
import 'page_provider.dart';
import 'routes.dart' as routes;
import 'transitionless_page_route.dart';

class MainPageNavigator extends StatelessWidget {
  static final _log = Logger('MainPageNavigator');

  final GlobalKey<NavigatorState> _navigatorKey;
  final MainPage _page;
  final GlobalRouteHandler _globalRouteHandler;

  MainPageNavigator({
    @required GlobalKey<NavigatorState> navigatorKey,
    @required MainPage page,
    GlobalRouteHandler globalRouteHandler,
  })  : _navigatorKey = navigatorKey,
        _page = page,
        _globalRouteHandler = globalRouteHandler;

  // Determines how to build the route specified by [routeName].
  WidgetBuilder _getRouteBuilder(BuildContext context, String routeName) {
    if (routeName == routes.root) {
      return _rootPages(context);
    }
    return _routeBuilder(context, routeName);
  }

  // Root page builders are special-cased because there are four options.
  WidgetBuilder _rootPages(BuildContext context) {
    PageProvider provider;

    switch (_page) {
      case MainPage.home:
        provider = NewsPageProvider();
        break;
      case MainPage.learning:
        provider = RecognitionPageProvider();
        break;
      case MainPage.travel:
        provider = EventsPageProvider();
        break;
      case MainPage.pay:
        provider = HomePageProvider();
        break;
      default:
        break;
    }

    if (provider == null) {
      // Route not found.
      _log.warning('Provided a nonexistent root page');
    }

    return provider?.providePageBuilder(context);
  }

  // Routes other than the root can be pushed by any navigator - home tab could
  // navigate user to a events-related page, for example.
  WidgetBuilder _routeBuilder(BuildContext context, String routeName) {
    Uri routeUri;

    try {
      routeUri = Uri.parse(routeName);
    } on FormatException catch (e, s) {
      _log.severe('Failed to parse navigation route:', e, s);
      return null;
    }

    // Route needs at least a tab segment and a widget segment.
    if (routeUri.pathSegments.length < 2) {
      _log.warning('Invalid navigation route: $routeName. routeUri: $routeUri');
      return null;
    }

    final widgetKey = routeUri.pathSegments[1];

    PageProvider provider;

    // Add widget builders to this switch when you add routes.
    switch (widgetKey) {
      case routes.settings:
        provider = SettingsPageProvider();
        break;
      case routes.calendar:
        provider = EventsPageProvider();
        break;
      default:
        provider = ArticlePageProvider();
    }

    if (provider == null) {
      // Route not found.
      _log.warning(
          'Invalid navigation route: $routeName. widgetKey: $widgetKey');
    }

    return provider?.providePageBuilder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: routes.root,
      onGenerateRoute: (RouteSettings routeSettings) =>
          routeSettings.isInitialRoute
              ? TransitionlessPageRoute(
                  builder: _getRouteBuilder(context, routeSettings.name),
                  settings: routeSettings,
                )
              : MaterialPageRoute(
                  builder: _getRouteBuilder(context, routeSettings.name),
                  settings: routeSettings,
                ),
    );
  }
}
