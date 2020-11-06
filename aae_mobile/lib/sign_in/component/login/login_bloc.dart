import 'package:aae/auth/auth_biometrics.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
import 'package:aae/sign_in/workflow/sign_in_workflow.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:inject/inject.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:quiver/strings.dart' show isNotEmpty;
import 'login_view_model.dart';

/// BloC for the [LoginComponent].
///
/// Exposes a [LoginViewModel] for that component to use.
class LoginBloc {
  static final _log = Logger('LoginBloc');
  final SignInRepository _signInRepository;
  final loginInProgress = createBehaviorSubject(initial: false);
  final _validitySubject = createBehaviorSubject<bool>();
  final _events = Subject<WorkflowEvent>();

  final CacheService _cache;

  /// On sign in status changes, publishes whether we have a signed in user with a valid profile.
  Observable<bool> get profileValidity  {
    return _validitySubject.distinctUntilChanged();
  }
  Observable<bool> get loginProgress  {
    return loginInProgress.distinctUntilChanged();
  }
  Observable<WorkflowEvent> get events {
    return _events;
  }

  Source<LoginViewModel> get viewModel {
    return toSource(combineLatest(loginInProgress, createViewModel));
  }

  LoginViewModel createViewModel(bool loginInProgress) {
    return LoginViewModel(primaryButtonText: 'Sign in', onSignInButtonPressed: signIn, showLoadingSpinner: false, signInButtonEnabled: true);
  }

  @provide
  LoginBloc(this._signInRepository, this._cache);

  void signIn() {
    try {
      _signInRepository.signIn().catchError((onError) {});
    } on Exception catch (e, s) {
      SignInEvents.silentSignInFailed;
      _log.severe('Sign in plugin failed: ', e, s);
    }
  }
}

/// Constructs new instances of [LoginBloc]s via the DI framework.
abstract class LoginBlocFactory implements ProvidedService {
  @provide
  LoginBloc loginBloc();
}
