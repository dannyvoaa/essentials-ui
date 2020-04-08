import 'package:aae/workflow/common/workflow_event.dart';

/// Events that are common across multiple [Workflow]s.
class WorkflowEvents {
  static WorkflowEvent get routePopped => WorkflowEvent('RoutePopped');

  static WorkflowEvent get userPressedPrimaryButton =>
      WorkflowEvent('UserPressedPrimaryButton');

  static WorkflowEvent get userPressedSecondaryButton =>
      WorkflowEvent('UserPressedSecondaryButton');
}
