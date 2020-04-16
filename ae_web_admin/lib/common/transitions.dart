import 'package:american_essentials_web_admin/common/routing.dart';
import 'package:flutter/widgets.dart';

class Transitions {
  /// Replaces the current view with the specified view using a fade animation
  static void pushReplacementWithFade({
    @required BuildContext buildContext,
    @required String stringRouteId,
    Map<String, Object> payload,
    bool boolFullscreen = true,
    Duration duration,
  }) {
    WidgetBuilder widgetBuilder =
        Routing.routes(stringRouteId: stringRouteId, payload: payload);

    // Push the replacement
    Navigator.pushReplacement(
      buildContext,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return widgetBuilder(buildContext);
        },
        transitionDuration: duration ?? Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        fullscreenDialog: boolFullscreen,
        settings: RouteSettings(
          name: stringRouteId,
        ),
      ),
    );
  }
}
