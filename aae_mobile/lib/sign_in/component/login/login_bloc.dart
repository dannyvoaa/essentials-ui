import 'package:aae/auth/auth_biometrics.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
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

  final _currentUsername = createBehaviorSubject(initial: '');
  final _currentPassword = createBehaviorSubject(initial: '');
  final _loginInProgress = createBehaviorSubject(initial: false);

  final _validitySubject = createBehaviorSubject<bool>();
  final _events = Subject<WorkflowEvent>();

  final _altAuthOptions =
      createBehaviorSubject<BiometricType>(initial: BiometricType.fingerprint);

  final _biometricAvailable = createBehaviorSubject<bool>(initial: false);

  /// On sign in status changes, publishes whether we have a signed in user with
  /// a valid profile.
  Observable<bool> get profileValidity =>
      _validitySubject.distinctUntilChanged();

  /// Events to be consumed by any workflows this BLoC is part of.
  Observable<WorkflowEvent> get events => _events;

  /// Publishes the [LoginViewModel].
  Source<LoginViewModel> get viewModel => toSource(combineLatest5(
        _currentUsername,
        _currentPassword,
        _loginInProgress,
        _altAuthOptions,
        _biometricAvailable,
        _createViewModel,
      ));

  @provide
  LoginBloc(this._signInRepository);

  void _signIn() {
    try {
      String _username;
      String _password;

      _loginInProgress.sendNext(true);

      printUsername(String un) {
        _username = un;
        _log.fine(_username);
      }

      printPassword(String pw) {
        _password = pw;
        _log.fine(_password);
      }

      _currentUsername.subscribe(onNext: printUsername);
      _currentPassword.subscribe(onNext: printPassword);

      _signInRepository.signIn(_username, _password).catchError((onError) {});
    } on Exception catch (e, s) {
      SignInEvents.silentSignInFailed;
      _log.severe('Sign in plugin failed: ', e, s);
    }
  }

  _onAuthFailed() {
    // add logic here that will cause a trigger for error dialog box to open
  }

  BiometricType availableAuthMethods() {
    // TODO (rpaglinawan): get all possible auth options from client device
  }

  void _biometricAuth() {}

  LoginViewModel _createViewModel(
    String username,
    String password,
    bool loginInProgress,
    BiometricType biometricOptions,
    bool biometricAvailable,
  ) =>
      LoginViewModel(
          onBiometricAuthPressed: _biometricAuth,
          authType: biometricOptions,
          onPasswordChanged: _currentPassword.sendNext,
          onUsernameChanged: _currentUsername.sendNext,
          primaryButtonText: 'Sign in',
          onSignInButtonPressed: _signIn,
          showLoadingSpinner: loginInProgress,
          biometricAuthEnabled: biometricAvailable,
          signInButtonEnabled: isNotEmpty(password) && isNotEmpty(username));
}

/// Constructs new instances of [LoginBloc]s via the DI framework.
abstract class LoginBlocFactory implements ProvidedService {
  @provide
  LoginBloc loginBloc();
}
