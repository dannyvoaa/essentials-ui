import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:local_auth/local_auth.dart';

part 'login_view_model.g.dart';

/// View model representing a [LoginView].
abstract class LoginViewModel implements Built<LoginViewModel, LoginViewModelBuilder> {
  String get primaryButtonText;
  AaeCommand get onSignInButtonPressed;
  bool get signInButtonEnabled;
  bool get showLoadingSpinner;

  LoginViewModel._();
  factory LoginViewModel({
    @required String primaryButtonText,
    @required AaeCommand onSignInButtonPressed,
    @required bool signInButtonEnabled,
    @required bool showLoadingSpinner,
  }) = _$LoginViewModel._;
}
