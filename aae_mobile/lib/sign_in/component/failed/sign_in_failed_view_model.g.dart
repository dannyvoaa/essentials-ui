// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_failed_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignInFailedViewModel extends SignInFailedViewModel {
  @override
  final String primaryButtonText;
  @override
  final AaeCommand onPrimaryButtonPressed;

  factory _$SignInFailedViewModel(
          [void Function(SignInFailedViewModelBuilder) updates]) =>
      (new SignInFailedViewModelBuilder()..update(updates)).build();

  _$SignInFailedViewModel._(
      {this.primaryButtonText, this.onPrimaryButtonPressed})
      : super._() {
    if (primaryButtonText == null) {
      throw new BuiltValueNullFieldError(
          'SignInFailedViewModel', 'primaryButtonText');
    }
    if (onPrimaryButtonPressed == null) {
      throw new BuiltValueNullFieldError(
          'SignInFailedViewModel', 'onPrimaryButtonPressed');
    }
  }

  @override
  SignInFailedViewModel rebuild(
          void Function(SignInFailedViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignInFailedViewModelBuilder toBuilder() =>
      new SignInFailedViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is SignInFailedViewModel &&
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
    return (newBuiltValueToStringHelper('SignInFailedViewModel')
          ..add('primaryButtonText', primaryButtonText)
          ..add('onPrimaryButtonPressed', onPrimaryButtonPressed))
        .toString();
  }
}

class SignInFailedViewModelBuilder
    implements Builder<SignInFailedViewModel, SignInFailedViewModelBuilder> {
  _$SignInFailedViewModel _$v;

  String _primaryButtonText;
  String get primaryButtonText => _$this._primaryButtonText;
  set primaryButtonText(String primaryButtonText) =>
      _$this._primaryButtonText = primaryButtonText;

  AaeCommand _onPrimaryButtonPressed;
  AaeCommand get onPrimaryButtonPressed => _$this._onPrimaryButtonPressed;
  set onPrimaryButtonPressed(AaeCommand onPrimaryButtonPressed) =>
      _$this._onPrimaryButtonPressed = onPrimaryButtonPressed;

  SignInFailedViewModelBuilder();

  SignInFailedViewModelBuilder get _$this {
    if (_$v != null) {
      _primaryButtonText = _$v.primaryButtonText;
      _onPrimaryButtonPressed = _$v.onPrimaryButtonPressed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInFailedViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SignInFailedViewModel;
  }

  @override
  void update(void Function(SignInFailedViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignInFailedViewModel build() {
    final _$result = _$v ??
        new _$SignInFailedViewModel._(
            primaryButtonText: primaryButtonText,
            onPrimaryButtonPressed: onPrimaryButtonPressed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
