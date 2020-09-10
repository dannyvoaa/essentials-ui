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
  final bool showLoadingSpinner;

  factory _$LoginViewModel([void Function(LoginViewModelBuilder) updates]) =>
      (new LoginViewModelBuilder()..update(updates)).build();

  _$LoginViewModel._(
      {this.primaryButtonText,
      this.onSignInButtonPressed,
      this.signInButtonEnabled,
      this.showLoadingSpinner})
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
    if (showLoadingSpinner == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'showLoadingSpinner');
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
        showLoadingSpinner == other.showLoadingSpinner;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc(0, primaryButtonText.hashCode),
                onSignInButtonPressed.hashCode),
            signInButtonEnabled.hashCode),
        showLoadingSpinner.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginViewModel')
          ..add('primaryButtonText', primaryButtonText)
          ..add('onSignInButtonPressed', onSignInButtonPressed)
          ..add('signInButtonEnabled', signInButtonEnabled)
          ..add('showLoadingSpinner', showLoadingSpinner))
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

  bool _showLoadingSpinner;
  bool get showLoadingSpinner => _$this._showLoadingSpinner;
  set showLoadingSpinner(bool showLoadingSpinner) =>
      _$this._showLoadingSpinner = showLoadingSpinner;

  LoginViewModelBuilder();

  LoginViewModelBuilder get _$this {
    if (_$v != null) {
      _primaryButtonText = _$v.primaryButtonText;
      _onSignInButtonPressed = _$v.onSignInButtonPressed;
      _signInButtonEnabled = _$v.signInButtonEnabled;
      _showLoadingSpinner = _$v.showLoadingSpinner;
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
            showLoadingSpinner: showLoadingSpinner);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
