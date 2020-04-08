import 'package:aae/workflow/common/workflow_state.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'modify_routes.dart';

class ModifyStates {
  static final root = WorkflowState(
    name: 'root',
    children: {settings},
    initial: settings,
    routeSegment: routes.signIn,
    navigateOnTransition: false,
  );

  static final settings = WorkflowState(
    name: 'Settings',
    children: {
      changeLocation,
      changeNotification,
      workgroupsSelection,
      topicsSelection
    },
    navigateOnTransition: false,
  );

  static final changeLocation = WorkflowState(
    name: 'ChangeLocation',
    routeSegment: ModifyRoutes.changeLocationServiceSegment,
    navigateOnTransition: true,
  );

  static final changeNotification = WorkflowState(
    name: 'ChangeNotification',
    routeSegment: ModifyRoutes.changeNotificationServiceSegment,
    navigateOnTransition: true,
  );

  /// State while the login page is displayed to the user.
  static final saveSettings = WorkflowState(
    name: 'SaveSettings',
    routeSegment: ModifyRoutes.saveSettingsSegment,
    navigateOnTransition: true,
  );

  static final savePreferences = WorkflowState(
    name: 'SavePreferences',
    routeSegment: ModifyRoutes.savePreferencesSegment,
    navigateOnTransition: true,
  );

  static final topicsSelection = WorkflowState(
    name: 'TopicsSelection',
    routeSegment: ModifyRoutes.changeTopicServiceSegment,
    navigateOnTransition: true,
  );

  static final workgroupsSelection = WorkflowState(
    name: 'WorkgroupsSelection',
    routeSegment: ModifyRoutes.changeWorkgroupSegment,
    navigateOnTransition: true,
  );

  static final contentSelection = WorkflowState(
    name: 'ChangeContent',
    routeSegment: ModifyRoutes.changeContentPreferenceSegment,
    navigateOnTransition: true,
  );
}
