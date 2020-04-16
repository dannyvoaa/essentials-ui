import 'package:meta/meta.dart';

/// Place to define constants and functions for route names

const root = '/';

const global = 'root';

// Tab routes - metadata appended to start of route.
const home = 'home';
const recognition = 'recognition';
const email = 'email';

// Page-level widget route keys. These should uniquely identify a widget that
// is a page that can be navigated to. Name the widget in a comment.

const signIn = 'sign-in';

/// Route key for the [SettingsPage] widget.
const settingsPage = 'settings';

/// Route key for the [PaycheckPage] widget.
const paycheck = 'paycheck';

/// Route key for the [NotificationsListView] widget.
const notifications = 'notifications';

/// Route key for the [ToDoList].
const toDoList = 'toDo-list';

/// Route key for the [TravelPage].
const travel = 'travel';

/// Route key for the [ArticlePage].
const article = 'article';

/// Route key for the [EventsPage].
const events = 'events';

String buildRouteName(
        {@required String tab,
        @required String pageWidgetRoute,
        Map<String, dynamic> queryParameters}) =>
    Uri(pathSegments: [tab, pageWidgetRoute], queryParameters: queryParameters)
        .toString();

/// Builds a route to the sign in flow.
String buildSignInRoute() =>
    buildRouteName(tab: global, pageWidgetRoute: signIn);

String buildArticlePageRoute({
  @required String article,
  Map<String, dynamic> parameters,
}) =>
    buildRouteName(
      tab: home,
      pageWidgetRoute: article,
      queryParameters: parameters,
    );

/// Builds a route to the settings page.
String buildSettingsPageRoute() =>
    Uri(pathSegments: [home, settingsPage]).toString();
