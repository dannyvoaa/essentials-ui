import 'dart:async';

import 'package:aae/auth/auth.dart';
import 'package:aae/auth/sso_auth.dart' hide TokenException;
import 'package:aae/auth/sso_identity.dart';
import 'package:aae/rx_ext/lib/rx_ext.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// Stores state around the current user status and interfaces with the Auth
class SignInRepository implements SSOIdentityProvider {
  static final _log = Logger('SignInRepository');
  final SSOAuth _ssoAuthPlugin;

  @override
  Future<SSOIdentity> get identity => blockingLatest(currentUser);

  @override
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
      _promptSignIn();
    } on PlatformException catch (e) {
      throw TokenException('Error signing in with SSO:', e);
    }
  }

  Future<void> _promptSignIn() {
    _log.info('Showing login screen');
    return _ssoAuthPlugin.signIn();
  }

  Future<bool> signInSilently() async {
    final user = _ssoAuthPlugin.signInSilently();
    return user != null;
  }
}
