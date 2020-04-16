import 'package:aae/auth/auth.dart';
import 'package:aae/auth/secure_cache_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/model/auth_credentials.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:pedantic/pedantic.dart';

/// BLoC for signing the user into the app.
class SignInBloc {
  static const lastUserStatusKey = 'SignInBloc.isLastUserValid';
  static final _log = Logger('SignInBloc');

  final SignInRepository _signInRepository;
  final ProfileRepository _profileRepository;
  final CacheService _cacheService;
  final SecureCacheAuth _cacheAuth;

  final _validitySubject = createBehaviorSubject<bool>();
  final _eventSubject = Subject<WorkflowEvent>();

  /// On sign in status changes, publishes whether we have a signed in user with
  /// a valid profile.
  Observable<bool> get profileValidity =>
      _validitySubject.distinctUntilChanged();

  /// Events to be consumed by any workflows this BLoC is part of.
  Observable<WorkflowEvent> get events => _eventSubject;

  @provide
  @singleton
  SignInBloc(this._signInRepository, this._profileRepository,
      this._cacheService, this._cacheAuth) {
    _signInRepository.currentUser.subscribe(
        onNext: (_) => _eventSubject.sendNext(SignInEvents.currentUserChanged));
  }

  /// Signals that an account was successfully created so that repositories can
  /// be started.
  void onAccountCreated() {
    //TODO: (kiheke) - Sync profile with cache on successful creation.
    _validitySubject.sendNext(true);
  }

  /// Signals that the logged in user is no longer verified to be valid.
  ///
  /// This may get called when the logged in account changes, etc.
  void onProfileInvalid() {
    _cacheService.writeBool(lastUserStatusKey, false);
    _validitySubject.sendNext(false);
  }

  /// Attempts to sign the user in silently.
  ///
  /// Generates a silentSignInFailed event if the user could not be signed in
  /// silently, and a validationSucceeded event if the conditions allow for
  /// bypassing the user validation step.
  void signInSilently() async {
    final lastUserValid = _cacheService.readBool(lastUserStatusKey).or(false);
    if (!await _signInRepository.signInSilently()) {
      _eventSubject.sendNext(SignInEvents.silentSignInFailed);
      unawaited(_cacheService.writeBool(lastUserStatusKey, false));
    } else if (lastUserValid) {
      _log.info('Bypassing user verification step.');
      _eventSubject.sendNext(SignInEvents.validationSucceeded);
      _validitySubject.sendNext(true);
    }
  }

  /// Attempts to validate the current user for AAE.
  ///
  /// Sends events indicating success or failure of this operation.
  void validate() async {
    AuthCredentials validAuth;
    unawaited(_cacheService.writeBool(lastUserStatusKey, false));
    var profileIsValid = false;
    try {
      await _profileRepository.validateIdentity();
      _eventSubject.sendNext(SignInEvents.validationSucceeded);
      profileIsValid = true;
    } on ProfileNotFoundException {
      _eventSubject.sendNext(SignInEvents.profileNotFound);
    } on TokenException {
      _eventSubject.sendNext(SignInEvents.authFlowFailed);
    } finally {
      _validitySubject.sendNext(profileIsValid);

      unawaited(_cacheService.writeBool(lastUserStatusKey, profileIsValid));
      _signInRepository.currentUser.subscribe(onNext: (identity) {
        validAuth = AuthCredentials((b) => b
          ..ssoID = identity
          ..user = identity.id
          ..password = identity.token);
      });
      unawaited(_cacheAuth.writeCredentials(authorizedUser: validAuth));
      await _profileRepository.validateIdentity();
    }
  }
}

abstract class SignInBlocFactory implements ProvidedService {
  @provide
  SignInBloc signInBloc();
}
