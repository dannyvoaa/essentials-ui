import 'package:american_essentials_web_admin/views/authentication/sign_in_view.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_add_view.dart';
import 'package:american_essentials_web_admin/views/calendar/calendar_view.dart';
import 'package:american_essentials_web_admin/views/home_view.dart';
import 'package:american_essentials_web_admin/views/locations/locations_add_view.dart';
import 'package:american_essentials_web_admin/views/locations/locations_view.dart';
import 'package:american_essentials_web_admin/views/notifications/notifications_view.dart';
import 'package:american_essentials_web_admin/views/startup.dart';
import 'package:american_essentials_web_admin/views/topics/topics_add_view.dart';
import 'package:american_essentials_web_admin/views/topics/topics_view.dart';
import 'package:american_essentials_web_admin/views/users/users_add_view.dart';
import 'package:american_essentials_web_admin/views/users/users_view.dart';
import 'package:american_essentials_web_admin/views/workgroups/workgroups_add_view.dart';
import 'package:american_essentials_web_admin/views/workgroups/workgroups_view.dart';
import 'package:flutter/material.dart';

class Routing {
  /// Defines all available routes
  static WidgetBuilder routes({
    @required String stringRouteId,
    Object payload,
  }) {
    // Define the routes
    var arrayRoutes = <String, WidgetBuilder>{
      CalendarView.routeId: (context) {
        return CalendarView(payload: payload);
      },
      CalendarAddView.routeId: (context) {
        return CalendarAddView(payload: payload);
      },
      HomeView.routeId: (context) {
        return HomeView(payload: payload);
      },
      LocationsAddView.routeId: (context) {
        return LocationsAddView(payload: payload);
      },
      LocationsView.routeId: (context) {
        return LocationsView(payload: payload);
      },
      NotificationsView.routeId: (context) {
        return NotificationsView(payload: payload);
      },
      SignInView.routeId: (context) {
        return SignInView(payload: payload);
      },
      Startup.routeId: (context) {
        return Startup();
      },
      TopicsAddView.routeId: (context) {
        return TopicsAddView(payload: payload);
      },
      TopicsView.routeId: (context) {
        return TopicsView(payload: payload);
      },
      UsersAddView.routeId: (context) {
        return UsersAddView(payload: payload);
      },
      UsersView.routeId: (context) {
        return UsersView(payload: payload);
      },
      WorkgroupsAddView.routeId: (context) {
        return WorkgroupsAddView(payload: payload);
      },
      WorkgroupsView.routeId: (context) {
        return WorkgroupsView(payload: payload);
      },
    };

    return arrayRoutes[stringRouteId];
  }
}
