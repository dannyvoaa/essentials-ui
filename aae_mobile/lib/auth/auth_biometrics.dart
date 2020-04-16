import 'dart:io';
import 'package:aae/rx/behavior_subject.dart';
import 'package:local_auth/local_auth.dart';

/// [LoginBiometrics] handles the logic for the biometric requirements on android and iOS
class LoginBiometrics {
  LoginBiometrics() {
    _checkBioMethods();
  }
  List<BiometricType> _availableBiometrics;
  LocalAuthentication _localAuth;

  final _availableBiometricOptions = createBehaviorSubject<BiometricType>();

  /// [_checkBioMethods] checks what methods are available on device
  _checkBioMethods() {
    if (Platform.isIOS) {
      _checkCupertinoVersion();
    } else if (Platform.isAndroid) {
      _checkAndroidVersion();
    }
  }

  /// [_checkAndroidVersion] checks the SDK version of user device to see what bio auth methods are available
  _checkAndroidVersion() async {
    _availableBiometrics = await _localAuth.getAvailableBiometrics();
    if (_availableBiometrics.contains(BiometricType.iris)) {
      // TODO (rpaglinawan): handle auth sign in for FaceID enrolled device
      _availableBiometricOptions.sendNext(_availableBiometrics
          .where((element) => element == BiometricType.iris)
          .first);
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      // TODO (rpaglinawan): handle auth sign in for TouchId enrolled device
      _availableBiometricOptions.sendNext(_availableBiometrics
          .where((element) => element == BiometricType.fingerprint)
          .first);
    }
  }

  /// [_checkCupertinoVersion] checks the OS version to see if device support FaceID
  _checkCupertinoVersion() async {
    _availableBiometrics = await _localAuth.getAvailableBiometrics();
    if (_availableBiometrics.contains(BiometricType.face)) {
      // TODO (rpaglinawan): handle auth sign in for FaceID enrolled device
      _availableBiometricOptions.sendNext(_availableBiometrics
          .where((element) => element == BiometricType.face)
          .first);
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      // TODO (rpaglinawan): handle auth sign in for TouchId enrolled device
      _availableBiometricOptions.sendNext(_availableBiometrics
          .where((element) => element == BiometricType.fingerprint)
          .first);
    }
  }

  Future<void> triggerAuthentication() async {}

  void signInOnSuccess() {
    /// TODO (rpaglinawan): trigger authentification event to happen on success of the event
  }

  /// [cancelAuthentification] is the manual handbrake to cancel authentificaiton flow
  void cancelAuthentification() {
    _localAuth.stopAuthentication();
  }
}
