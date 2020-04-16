import 'package:local_auth/local_auth.dart';
import 'package:built_value/built_value.dart';

part 'biometric_auth.g.dart';

abstract class BiometricAuth implements Built<BiometricAuth, BiometricAuthBuilder>{
  BiometricType get authType;
  String get platform;
  String get operatingSystem;

  BiometricAuth._();
  factory BiometricAuth([updates(BiometricAuthBuilder b)]) = _$BiometricAuth;
}