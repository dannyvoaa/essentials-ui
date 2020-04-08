import 'dart:async';

import 'sso_identity.dart';

class SSOAuth {
  /// TODO: (kiheke) Test credentials, remove when aae App Id servers is created
  final String clientId = '0a8926d0-0009-48f6-b753-a3646a6c11d8';
  final String tenantId = '95debee2-f9c4-4dec-b30c-701d9d7f8216';
  final String secret = 'YTI1MjM0MDItMTRlYi00NTBmLThkZDEtMGQwZGJmYjU2ZWNm';

  final String oAuthServerUrl =
      'https://us-south.appid.cloud.ibm.com/oauth/v4/95debee2-f9c4-4dec-b30c-701d9d7f8216/token';

  SSOIdentity user;

  SSOAuth() {
    _setCurrentUser(user);
  }
  final _currentUserController = StreamController<SSOIdentity>.broadcast();

  Stream<SSOIdentity> get onCurrentUserChanged => _currentUserController.stream;

  SSOIdentity _setCurrentUser(SSOIdentity currentUser) {
    if (currentUser != _currentUser) {
      _currentUser = currentUser;
      _currentUserController.add(_currentUser);
    }
    return _currentUser;
  }

  /// The currently signed in account, or null if the user is signed out
  SSOIdentity _currentUser;
  SSOIdentity get currentUser => _currentUser;

  Future<SSOIdentity> signInSilently() {
    return null;
  }
}
