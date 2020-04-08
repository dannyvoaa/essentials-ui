import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_events.dart';

class ModifySettingsEvents {
  static WorkflowEvent get routePopped => WorkflowEvents.routePopped;
  static WorkflowEvent get userPressedPrimaryButton =>
      WorkflowEvents.userPressedPrimaryButton;
  static WorkflowEvent get userPressedSecondaryButton =>
      WorkflowEvents.userPressedSecondaryButton;

  static WorkflowEvent get cancel => WorkflowEvent('Cancel');
  static WorkflowEvent get save => WorkflowEvent('Save');

  static WorkflowEvent get onSaveSuccessful =>
      WorkflowEvent('OnSaveSuccessful');
  static WorkflowEvent get onSaveUnsuccessful =>
      WorkflowEvent('OnSaveUnsuccessful');

  static WorkflowEvent get onLoadSuccessful =>
      WorkflowEvent('OnLoadSuccessful');
  static WorkflowEvent get onLoadUnsuccessful =>
      WorkflowEvent('OnLoadUnsuccessful');
}
