// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_section_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PreferenceSectionViewModel extends PreferenceSectionViewModel {
  @override
  final Widget table;
  @override
  final AaeCommand onTapped;

  factory _$PreferenceSectionViewModel(
          [void Function(PreferenceSectionViewModelBuilder) updates]) =>
      (new PreferenceSectionViewModelBuilder()..update(updates)).build();

  _$PreferenceSectionViewModel._({this.table, this.onTapped}) : super._() {
    if (table == null) {
      throw new BuiltValueNullFieldError('PreferenceSectionViewModel', 'table');
    }
    if (onTapped == null) {
      throw new BuiltValueNullFieldError(
          'PreferenceSectionViewModel', 'onTapped');
    }
  }

  @override
  PreferenceSectionViewModel rebuild(
          void Function(PreferenceSectionViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreferenceSectionViewModelBuilder toBuilder() =>
      new PreferenceSectionViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final _$dynamicOther = other as dynamic;
    return other is PreferenceSectionViewModel &&
        table == other.table &&
        onTapped == _$dynamicOther.onTapped;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, table.hashCode), onTapped.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreferenceSectionViewModel')
          ..add('table', table)
          ..add('onTapped', onTapped))
        .toString();
  }
}

class PreferenceSectionViewModelBuilder
    implements
        Builder<PreferenceSectionViewModel, PreferenceSectionViewModelBuilder> {
  _$PreferenceSectionViewModel _$v;

  Widget _table;
  Widget get table => _$this._table;
  set table(Widget table) => _$this._table = table;

  AaeCommand _onTapped;
  AaeCommand get onTapped => _$this._onTapped;
  set onTapped(AaeCommand onTapped) => _$this._onTapped = onTapped;

  PreferenceSectionViewModelBuilder();

  PreferenceSectionViewModelBuilder get _$this {
    if (_$v != null) {
      _table = _$v.table;
      _onTapped = _$v.onTapped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreferenceSectionViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreferenceSectionViewModel;
  }

  @override
  void update(void Function(PreferenceSectionViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreferenceSectionViewModel build() {
    final _$result = _$v ??
        new _$PreferenceSectionViewModel._(table: table, onTapped: onTapped);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
