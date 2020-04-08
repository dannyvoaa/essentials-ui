// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_balance_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PointsBalanceViewModel extends PointsBalanceViewModel {
  @override
  final String currentBalance;

  factory _$PointsBalanceViewModel(
          [void Function(PointsBalanceViewModelBuilder) updates]) =>
      (new PointsBalanceViewModelBuilder()..update(updates)).build();

  _$PointsBalanceViewModel._({this.currentBalance}) : super._() {
    if (currentBalance == null) {
      throw new BuiltValueNullFieldError(
          'PointsBalanceViewModel', 'currentBalance');
    }
  }

  @override
  PointsBalanceViewModel rebuild(
          void Function(PointsBalanceViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PointsBalanceViewModelBuilder toBuilder() =>
      new PointsBalanceViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PointsBalanceViewModel &&
        currentBalance == other.currentBalance;
  }

  @override
  int get hashCode {
    return $jf($jc(0, currentBalance.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PointsBalanceViewModel')
          ..add('currentBalance', currentBalance))
        .toString();
  }
}

class PointsBalanceViewModelBuilder
    implements Builder<PointsBalanceViewModel, PointsBalanceViewModelBuilder> {
  _$PointsBalanceViewModel _$v;

  String _currentBalance;
  String get currentBalance => _$this._currentBalance;
  set currentBalance(String currentBalance) =>
      _$this._currentBalance = currentBalance;

  PointsBalanceViewModelBuilder();

  PointsBalanceViewModelBuilder get _$this {
    if (_$v != null) {
      _currentBalance = _$v.currentBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PointsBalanceViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PointsBalanceViewModel;
  }

  @override
  void update(void Function(PointsBalanceViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PointsBalanceViewModel build() {
    final _$result =
        _$v ?? new _$PointsBalanceViewModel._(currentBalance: currentBalance);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
