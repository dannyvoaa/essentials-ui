import 'package:aae/navigation/routes.dart' as routes;

/// Routes for the sign-in workflow.
///
/// Class exists for importing convenience.
class SignInRoutes {
  // -- Any new or updated routes should also be updated in the
  // RouteParser.

  //
  // Full routes:
  //
  static final welcome = _buildSignInRoute(welcomeSegment);
  static final login = _buildSignInRoute(loginSegment);
  static final loading = _buildSignInRoute(loadingSegment);
  static final failed = _buildSignInRoute(failedSegment);
  static final workgroupsSelection = _buildSignInRoute(workgroupsSelectionSegment);
  static final hubLocationsSelection = _buildSignInRoute(hubLocationsSelectionSegment);
  static final topicsSelection = _buildSignInRoute(topicsSelectionSegment);
  //
  // Segments:
  //
  static const welcomeSegment = 'welcome';
  static const loginSegment = 'login';
  static const loadingSegment = 'loading';
  static const failedSegment = 'failed';
  static const topicsSelectionSegment = 'topics-selection';
  static const hubLocationsSelectionSegment = 'hubLocations-selection';
  static const workgroupsSelectionSegment = 'workgroups-selection';
  //
  // Utilities:
  //
  static String _buildSignInRoute(String pageSegment) {
    return '${Uri(pathSegments: [routes.signIn, pageSegment])}';
  }
}
