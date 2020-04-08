import 'package:aae/common/commands/aae_command.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_events.dart';
import 'package:inject/inject.dart';

/// BLoC for the [WorkflowFooterButtonComponent].
///
/// This BLoC defines commands to use as defaults for when the user presses the
/// primary or secondary button in a flow.
class WorkflowFooterButtonBloc {
  final _events = Subject<WorkflowEvent>();

  /// Sends userPressedPrimaryButton and userPressedSecondaryButton events to
  /// the workflow.
  Observable<WorkflowEvent> get events => _events;

  /// Commands to execute on button press.
  AaeCommand get onPrimaryButtonPressed => _onPrimary;

  AaeCommand get onSecondaryButtonPressed => _onSecondary;

  @provide
  WorkflowFooterButtonBloc();

  void _onPrimary() {
    _events.sendNext(WorkflowEvents.userPressedPrimaryButton);
  }

  void _onSecondary() {
    _events.sendNext(WorkflowEvents.userPressedSecondaryButton);
  }
}

/// Constructs new instances of [WorkflowFooterButtonBloc]s via the DI framework.
abstract class WorkflowFooterButtonBlocFactory implements ProvidedService {
  @provide
  WorkflowFooterButtonBloc workflowFooterButtonBloc();
}
