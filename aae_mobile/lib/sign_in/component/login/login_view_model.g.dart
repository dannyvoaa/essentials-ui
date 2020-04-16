// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginViewModel extends LoginViewModel {
  @override
  final String primaryButtonText;
  @override
  final AaeCommand onSignInButtonPressed;
  @override
  final bool signInButtonEnabled;
  @override
  final AaeValueCommand<String> onPasswordChanged;
  @override
  final AaeValueCommand<String> onUsernameChanged;
  @override
  final AaeCommand onBiometricAuthPressed;
  @override
  final BiometricType authType;
  @override
  final bool showLoadingSpinner;
  @override
  final bool biometricAuthEnabled;

  factory _$LoginViewModel([void Function(LoginViewModelBuilder) updates]) =>
      (new LoginViewModelBuilder()..update(updates)).build();

  _$LoginViewModel._(
      {this.primaryButtonText,
      this.onSignInButtonPressed,
      this.signInButtonEnabled,
      this.onPasswordChanged,
      this.onUsernameChanged,
      this.onBiometricAuthPressed,
      this.authType,
      this.showLoadingSpinner,
      this.biometricAuthEnabled})
      : super._() {
    if (primaryButtonText == null) {
      throw new BuiltValueNullFieldError('LoginViewModel', 'primaryButtonText');
    }
    if (onSignInButtonPressed == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'onSignInButtonPressed');
    }
    if (signInButtonEnabled == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'signInButtonEnabled');
    }
    if (onPasswordChanged == null) {
      throw new BuiltValueNullFieldError('LoginViewModel', 'onPasswordChanged');
    }
    if (onUsernameChanged == null) {
      throw new BuiltValueNullFieldError('LoginViewModel', 'onUsernameChanged');
    }
    if (onBiometricAuthPressed == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'onBiometricAuthPressed');
    }
    if (authType == null) {
      throw new BuiltValueNullFieldError('LoginViewModel', 'authType');
    }
    if (showLoadingSpinner == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'showLoadingSpinner');
    }
    if (biometricAuthEnabled == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'biometricAuthEnabled');
    }
  }

  @override
  LoginViewModel rebuild(void Function(LoginViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginViewModelBuilder toBuilder() =>
      new LoginViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is LoginViewModel &&
        primaryButtonText == other.primaryButtonText &&
        onSignInButtonPressed == _$dynamicOther.onSignInButtonPressed &&
        signInButtonEnabled == other.signInButtonEnabled &&
        onPasswordChanged == _$dynamicOther.onPasswordChanged &&
        onUsernameChanged == _$dynamicOther.onUsernameChanged &&
        onBiometricAuthPressed == _$dynamicOther.onBiometricAuthPressed &&
        authType == other.authType &&
        showLoadingSpinner == other.showLoadingSpinner &&
        biometricAuthEnabled == other.biometricAuthEnabled;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, primaryButtonText.hashCode),
                                    onSignInButtonPressed.hashCode),
                                signInButtonEnabled.hashCode),
                            onPasswordChanged.hashCode),
                        onUsernameChanged.hashCode),
                    onBiometricAuthPressed.hashCode),
                authType.hashCode),
            showLoadingSpinner.hashCode),
        biometricAuthEnabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginViewModel')
          ..add('primaryButtonText', primaryButtonText)
          ..add('onSignInButtonPressed', onSignInButtonPressed)
          ..add('signInButtonEnabled', signInButtonEnabled)
          ..add('onPasswordChanged', onPasswordChanged)
          ..add('onUsernameChanged', onUsernameChanged)
          ..add('onBiometricAuthPressed', onBiometricAuthPressed)
          ..add('authType', authType)
          ..add('showLoadingSpinner', showLoadingSpinner)
          ..add('biometricAuthEnabled', biometricAuthEnabled))
        .toString();
  }
}

class LoginViewModelBuilder
    implements Builder<LoginViewModel, LoginViewModelBuilder> {
  _$LoginViewModel _$v;

  String _primaryButtonText;
  String get primaryButtonText => _$this._primaryButtonText;
  set primaryButtonText(String primaryButtonText) =>
      _$this._primaryButtonText = primaryButtonText;

  AaeCommand _onSignInButtonPressed;
  AaeCommand get onSignInButtonPressed => _$this._onSignInButtonPressed;
  set onSignInButtonPressed(AaeCommand onSignInButtonPressed) =>
      _$this._onSignInButtonPressed = onSignInButtonPressed;

  bool _signInButtonEnabled;
  bool get signInButtonEnabled => _$this._signInButtonEnabled;
  set signInButtonEnabled(bool signInButtonEnabled) =>
      _$this._signInButtonEnabled = signInButtonEnabled;

  AaeValueCommand<String> _onPasswordChanged;
  AaeValueCommand<String> get onPasswordChanged => _$this._onPasswordChanged;
  set onPasswordChanged(AaeValueCommand<String> onPasswordChanged) =>
      _$this._onPasswordChanged = onPasswordChanged;

  AaeValueCommand<String> _onUsernameChanged;
  AaeValueCommand<String> get onUsernameChanged => _$this._onUsernameChanged;
  set onUsernameChanged(AaeValueCommand<String> onUsernameChanged) =>
      _$this._onUsernameChanged = onUsernameChanged;

  AaeCommand _onBiometricAuthPressed;
  AaeCommand get onBiometricAuthPressed => _$this._onBiometricAuthPressed;
  set onBiometricAuthPressed(AaeCommand onBiometricAuthPressed) =>
      _$this._onBiometricAuthPressed = onBiometricAuthPressed;

  BiometricType _authType;
  BiometricType get authType => _$this._authType;
  set authType(BiometricType authType) => _$this._authType = authType;

  bool _showLoadingSpinner;
  bool get showLoadingSpinner => _$this._showLoadingSpinner;
  set showLoadingSpinner(bool showLoadingSpinner) =>
      _$this._showLoadingSpinner = showLoadingSpinner;

  bool _biometricAuthEnabled;
  bool get biometricAuthEnabled => _$this._biometricAuthEnabled;
  set biometricAuthEnabled(bool biometricAuthEnabled) =>
      _$this._biometricAuthEnabled = biometricAuthEnabled;

  LoginViewModelBuilder();

  LoginViewModelBuilder get _$this {
    if (_$v != null) {
      _primaryButtonText = _$v.primaryButtonText;
      _onSignInButtonPressed = _$v.onSignInButtonPressed;
      _signInButtonEnabled = _$v.signInButtonEnabled;
      _onPasswordChanged = _$v.onPasswordChanged;
      _onUsernameChanged = _$v.onUsernameChanged;
      _onBiometricAuthPressed = _$v.onBiometricAuthPressed;
      _authType = _$v.authType;
      _showLoadingSpinner = _$v.showLoadingSpinner;
      _biometricAuthEnabled = _$v.biometricAuthEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginViewModel;
  }

  @override
  void update(void Function(LoginViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginViewModel build() {
    final _$result = _$v ??
        new _$LoginViewModel._(
            primaryButtonText: primaryButtonText,
            onSignInButtonPressed: onSignInButtonPressed,
            signInButtonEnabled: signInButtonEnabled,
            onPasswordChanged: onPasswordChanged,
            onUsernameChanged: onUsernameChanged,
            onBiometricAuthPressed: onBiometricAuthPressed,
            authType: authType,
            showLoadingSpinner: showLoadingSpinner,
            biometricAuthEnabled: biometricAuthEnabled);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
