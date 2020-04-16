import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'sign_in_failed_view_model.dart';

/// BloC for the [SignInFailedComponent].
///
/// Exposes a [SignInFailedViewModel] for that component to use.
class SignInFailedBloc {
  static final _log = Logger('SignInFailedBloc');

  final SignInRepository _signInRepository;

  // This is a plain subject and not a behavior subject because if an event is
  // generated before the workflow is created (which shouldn't happen) it
  // should not trigger an event handler.
  final _events = Subject<WorkflowEvent>();

  /// Events to be consumed by any workflows this BLoC is part of.
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [SignInFailedViewModel].
  Source<SignInFailedViewModel> get viewModel => toSource(
        Observable.just(_createViewModel()),
      );

  @provide
  SignInFailedBloc(this._signInRepository);

  SignInFailedViewModel _createViewModel() => SignInFailedViewModel((b) => b
    ..primaryButtonText = 'Sign In as different user'
    ..onPrimaryButtonPressed = null);
}

/// Constructs new instances of [SignInFailedBloc]s via the DI framework.
abstract class SignInFailedBlocFactory implements ProvidedService {
  @provide
  SignInFailedBloc signInFailedBloc();
}
