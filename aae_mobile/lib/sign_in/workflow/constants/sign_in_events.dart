import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_events.dart';

/// Events for the sign-in workflow.
///
/// Class exists for importing convenience.
class SignInEvents {
  // Referencing the common [WorkflowEvents] for a common import path.
  static WorkflowEvent get routePopped => WorkflowEvents.routePopped;
  static WorkflowEvent get userPressedPrimaryButton => WorkflowEvents.userPressedPrimaryButton;
  static WorkflowEvent get userPressedSecondaryButton => WorkflowEvents.userPressedSecondaryButton;

  // Sign in specific events.
  /// Normally this shouldn't be an event -- the machine should decide to exit
  /// based on other events -- but in order to get the context, this needs to
  /// be an event. It only gets sent from internally within the machine.
  static WorkflowEvent get exit => WorkflowEvent('Exit');
  static WorkflowEvent get currentUserChanged => WorkflowEvent('UserChanged');
  static WorkflowEvent get validationSucceeded => WorkflowEvent('ProfileValidationSucceeded');
  static WorkflowEvent get profileCreationSucceeded => WorkflowEvent('ProfileCreationSucceeded');
  static WorkflowEvent get silentSignInFailed => WorkflowEvent('SilentSignInFailed');
  static WorkflowEvent get authFlowFailed => WorkflowEvent('AuthFlowFailed');
  static WorkflowEvent get profileCreationFailed => WorkflowEvent('ProfileCreationFailed');
  static WorkflowEvent get profileNotFound => WorkflowEvent('ProfileNotFound');
}
