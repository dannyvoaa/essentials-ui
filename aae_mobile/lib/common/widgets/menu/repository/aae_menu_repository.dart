import 'package:aae/common/widgets/placeholder/placeholder_screens.dart';
import 'package:aae/sign_in/component/workgroups_selection/workgroups_selection_component.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AaeSettingsMenuRepository {
  static final _log = Logger('AaeMenuRepository');

  static final routeTable = <String, WidgetBuilder>{
    SettingsRoutes.workgroup: (context) => AaePlaceholderScreens(
          screenAnnote: 'work group with BLOC',
        ),
    SettingsRoutes.contentServices: (context) => AaePlaceholderScreens(
          screenAnnote: 'content services',
        ),
    SettingsRoutes.locationServices: (context) => AaePlaceholderScreens(
          screenAnnote: 'location services',
        ),
    SettingsRoutes.notificationServices: (context) => AaePlaceholderScreens(
          screenAnnote: 'notification services',
        ),
    SettingsRoutes.contentServices: (context) => AaePlaceholderScreens(
          screenAnnote: 'content services',
        ),
    SettingsRoutes.topicServices: (context) => AaePlaceholderScreens(
          screenAnnote: 'topic services',
        ),
  };
}

class SettingsRoutes {
  static final workgroup = 'Change Workgroup';
  static final locationServices = 'Location Services';
  static final notificationServices = 'Notification Services';
  static final contentServices = 'Change Content Preferences';
  static final topicServices = 'Change Topic Services';
}
