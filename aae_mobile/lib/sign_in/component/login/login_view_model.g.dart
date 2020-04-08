// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginViewModel extends LoginViewModel {
  @override
  final String primaryButtonText;
  @override
  final AaeCommand onPrimaryButtonPressed;

  factory _$LoginViewModel([void Function(LoginViewModelBuilder) updates]) =>
      (new LoginViewModelBuilder()..update(updates)).build();

  _$LoginViewModel._({this.primaryButtonText, this.onPrimaryButtonPressed})
      : super._() {
    if (primaryButtonText == null) {
      throw new BuiltValueNullFieldError('LoginViewModel', 'primaryButtonText');
    }
    if (onPrimaryButtonPressed == null) {
      throw new BuiltValueNullFieldError(
          'LoginViewModel', 'onPrimaryButtonPressed');
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
    final _$dynamicOther = other as dynamic;
    return other is LoginViewModel &&
        primaryButtonText == other.primaryButtonText &&
        onPrimaryButtonPressed == _$dynamicOther.onPrimaryButtonPressed;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(0, primaryButtonText.hashCode), onPrimaryButtonPressed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginViewModel')
          ..add('primaryButtonText', primaryButtonText)
          ..add('onPrimaryButtonPressed', onPrimaryButtonPressed))
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

  AaeCommand _onPrimaryButtonPressed;
  AaeCommand get onPrimaryButtonPressed => _$this._onPrimaryButtonPressed;
  set onPrimaryButtonPressed(AaeCommand onPrimaryButtonPressed) =>
      _$this._onPrimaryButtonPressed = onPrimaryButtonPressed;

  LoginViewModelBuilder();

  LoginViewModelBuilder get _$this {
    if (_$v != null) {
      _primaryButtonText = _$v.primaryButtonText;
      _onPrimaryButtonPressed = _$v.onPrimaryButtonPressed;
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
            onPrimaryButtonPressed: onPrimaryButtonPressed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
