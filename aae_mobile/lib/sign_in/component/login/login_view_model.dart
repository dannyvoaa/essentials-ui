import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:local_auth/local_auth.dart';

part 'login_view_model.g.dart';

/// View model representing a [LoginView].
abstract class LoginViewModel
    implements Built<LoginViewModel, LoginViewModelBuilder> {
  String get primaryButtonText;

  /// Command to call when the sign in button is tapped
  AaeCommand get onSignInButtonPressed;

  /// sign in button enabled state.
  bool get signInButtonEnabled;

  // bool get attempted;

  AaeValueCommand<String> get onPasswordChanged;

  AaeValueCommand<String> get onUsernameChanged;

  AaeCommand get onBiometricAuthPressed;

  BiometricType get authType;

  /// If we should show the loading spinner or not.
  bool get showLoadingSpinner;

  bool get biometricAuthEnabled;

  LoginViewModel._();
  factory LoginViewModel({
    @required String primaryButtonText,
    @required AaeCommand onSignInButtonPressed,
    @required bool signInButtonEnabled,
    @required AaeValueCommand<String> onPasswordChanged,
    @required AaeValueCommand<String> onUsernameChanged,
    @required bool showLoadingSpinner,
    @required BiometricType authType,
    @required bool biometricAuthEnabled,
    @required AaeCommand onBiometricAuthPressed,
  }) = _$LoginViewModel._;
}
