import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'login_view_model.dart';

/// BloC for the [LoginComponent].
///
/// Exposes a [LoginViewModel] for that component to use.
class LoginBloc {
  static final _log = Logger('LoginBloc');

  final _events = Subject<WorkflowEvent>();

  /// Events to be consumed by any workflows this BLoC is part of.
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [LoginViewModel].
  Source<LoginViewModel> get viewModel => toSource(
        Observable.just(_createViewModel()),
      );

  @provide
  LoginBloc();

  void _signIn() async {
    try {
      _events.sendNext(SignInEvents.profileNotFound);
    } on Exception catch (e, s) {
      _log.severe('Sign in plugin failed: ', e, s);
    }
  }

  LoginViewModel _createViewModel() => LoginViewModel((b) => b
    ..primaryButtonText = 'Sign in'
    ..onPrimaryButtonPressed = _signIn);
}

/// Constructs new instances of [LoginBloc]s via the DI framework.
abstract class LoginBlocFactory implements ProvidedService {
  @provide
  LoginBloc loginBloc();
}
