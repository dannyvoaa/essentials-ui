import 'package:aae/auth/auth.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'welcome_view_model.dart';

/// BloC for the [WelcomeComponent].
///
/// Exposes a [WelcomeViewModel] for that component to use.
class WelcomeBloc {
  static final _log = Logger('WelcomeBloc');

  final SignInRepository _signInRepository;

  final _events = Subject<WorkflowEvent>();

  /// Events to be consumed by any workflows this BLoC is part of.
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [WelcomeViewModel].
  Source<WelcomeViewModel> get viewModel => toSource(
        Observable.just(_createViewModel()),
      );

  @provide
  WelcomeBloc(this._signInRepository);

  void _login() async {
    try {
      _events.sendNext(SignInEvents.userPressedPrimaryButton);
    } on TokenException catch (e, s) {
      _log.severe('Sign in plugin failed: ', e, s);
      _events.sendNext(SignInEvents.authFlowFailed);
    }
  }

  WelcomeViewModel _createViewModel() => WelcomeViewModel((b) => b
    ..primaryButtonText = 'Sign in'
    ..onPrimaryButtonPressed = _login);
}

/// Constructs new instances of [WelcomeBloc]s via the DI framework.
abstract class WelcomeBlocFactory implements ProvidedService {
  @provide
  WelcomeBloc welcomeBloc();
}
