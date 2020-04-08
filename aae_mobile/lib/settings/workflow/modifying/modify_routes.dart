import 'package:aae/navigation/routes.dart' as routes;

class ModifyRoutes {
  ///[saveSettings] will only store the changed settings on local user
  ///device
  static final saveSettings = _buildModifyRoute(saveSettingsSegment);

  ///[savePreferences] will cache the changes until the AAE server verifies that
  /// these changes were made
  static final savePreferences = _buildModifyRoute(savePreferencesSegment);
  static final changeWorkgroup = _buildModifyRoute(changeWorkgroupSegment);
  static final changeContentPreference =
      _buildModifyRoute(changeContentPreferenceSegment);
  static final changeLocationService =
      _buildModifyRoute(changeLocationServiceSegment);
  static final changeNotificationService =
      _buildModifyRoute(changeNotificationServiceSegment);
  static final changeTopicService =
      _buildModifyRoute(changeTopicServiceSegment);

  static const savePreferencesSegment = 'save-preferences';
  static const saveSettingsSegment = 'save-settings';
  static const changeWorkgroupSegment = 'change-workgroup';
  static const changeContentPreferenceSegment = 'change-content';
  static const changeLocationServiceSegment = 'change-location';
  static const changeNotificationServiceSegment = 'change-notification';
  static const changeTopicServiceSegment = 'change-topic';

  static String _buildModifyRoute(String pageSegment) =>
      '${Uri(pathSegments: [routes.settings, pageSegment])}';
}
