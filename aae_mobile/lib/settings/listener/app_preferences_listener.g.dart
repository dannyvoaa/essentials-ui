// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_listener.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppPreferencesListener extends AppPreferencesListener {
  @override
  final Listenable preferenceListener;
  @override
  final AaePermissions userPermission;

  factory _$AppPreferencesListener(
          [void Function(AppPreferencesListenerBuilder) updates]) =>
      (new AppPreferencesListenerBuilder()..update(updates)).build();

  _$AppPreferencesListener._({this.preferenceListener, this.userPermission})
      : super._() {
    if (preferenceListener == null) {
      throw new BuiltValueNullFieldError(
          'AppPreferencesListener', 'preferenceListener');
    }
    if (userPermission == null) {
      throw new BuiltValueNullFieldError(
          'AppPreferencesListener', 'userPermission');
    }
  }

  @override
  AppPreferencesListener rebuild(
          void Function(AppPreferencesListenerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppPreferencesListenerBuilder toBuilder() =>
      new AppPreferencesListenerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final _$dynamicOther = other as dynamic;
    return other is AppPreferencesListener &&
        preferenceListener == other.preferenceListener &&
        userPermission == _$dynamicOther.userPermission;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, preferenceListener.hashCode), userPermission.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppPreferencesListener')
          ..add('preferenceListener', preferenceListener)
          ..add('userPermission', userPermission))
        .toString();
  }
}

class AppPreferencesListenerBuilder
    implements Builder<AppPreferencesListener, AppPreferencesListenerBuilder> {
  _$AppPreferencesListener _$v;

  Listenable _preferenceListener;
  Listenable get preferenceListener => _$this._preferenceListener;
  set preferenceListener(Listenable preferenceListener) =>
      _$this._preferenceListener = preferenceListener;

  AaePermissions _userPermission;
  AaePermissions get userPermission => _$this._userPermission;
  set userPermission(AaePermissions userPermission) =>
      _$this._userPermission = userPermission;

  AppPreferencesListenerBuilder();

  AppPreferencesListenerBuilder get _$this {
    if (_$v != null) {
      _preferenceListener = _$v.preferenceListener;
      _userPermission = _$v.userPermission;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppPreferencesListener other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppPreferencesListener;
  }

  @override
  void update(void Function(AppPreferencesListenerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppPreferencesListener build() {
    final _$result = _$v ??
        new _$AppPreferencesListener._(
            preferenceListener: preferenceListener,
            userPermission: userPermission);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
