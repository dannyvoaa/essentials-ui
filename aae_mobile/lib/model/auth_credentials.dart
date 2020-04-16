import 'package:aae/auth/sso_identity.dart';
import 'package:built_value/built_value.dart';

part 'auth_credentials.g.dart';

/// [AuthCredentials] is used to represent userID and password for auth credentials

abstract class AuthCredentials implements Built<AuthCredentials, AuthCredentialsBuilder>{

  @nullable
  String get user;
  @nullable
  String get password;

  SSOIdentity get ssoID;

  AuthCredentials._();
  factory AuthCredentials([updates(AuthCredentialsBuilder b)]) = _$AuthCredentials;
}