import 'dart:async';

import 'package:aae/auth/sso_auth.dart';
import 'package:aae/auth/sso_identity.dart';
import 'package:aae/rx_ext/lib/rx_ext.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// Stores state around the current user status and interfaces with the Auth
/// Flutter plugin.
class SignInRepository {
  static final _log = Logger('SignInRepository');
  final SSOAuth _ssoAuthPlugin;

  Future<void> _inProgressSignIn;

  Future<SSOIdentity> get identity => blockingLatest(currentUser);

  final Observable<SSOIdentity> currentUser;

  @provide
  @singleton
  SignInRepository(this._ssoAuthPlugin)
      : currentUser = Observable.fromStream(_ssoAuthPlugin.onCurrentUserChanged)
            .filter((user) => user != null)
            .shareReplay();

  /// Prompts the user to sign in.
  Future<void> signIn() async {
    try {
      // If there is no user:
      if (_ssoAuthPlugin.currentUser == null) {
        // Start a sign in flow if one is not already in progress.

        // Wait for sign in flow to complete.
        await _inProgressSignIn;
      }
    } finally {
      // Signal that there are no sign-in flows in progress.
      _inProgressSignIn = null;
    }
  }

  Future<bool> signInSilently() async {
    final user = await _ssoAuthPlugin.signInSilently();
    return user != null;
  }
}
