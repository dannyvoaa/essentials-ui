// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_history_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PointsHistoryViewModel extends PointsHistoryViewModel {
  @override
  final BuiltList<RecognitionRegister> recognitionHistory;

  factory _$PointsHistoryViewModel(
          [void Function(PointsHistoryViewModelBuilder) updates]) =>
      (new PointsHistoryViewModelBuilder()..update(updates)).build();

  _$PointsHistoryViewModel._({this.recognitionHistory}) : super._() {
    if (recognitionHistory == null) {
      throw new BuiltValueNullFieldError(
          'PointsHistoryViewModel', 'recognitionHistory');
    }
  }

  @override
  PointsHistoryViewModel rebuild(
          void Function(PointsHistoryViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PointsHistoryViewModelBuilder toBuilder() =>
      new PointsHistoryViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PointsHistoryViewModel &&
        recognitionHistory == other.recognitionHistory;
  }

  @override
  int get hashCode {
    return $jf($jc(0, recognitionHistory.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PointsHistoryViewModel')
          ..add('recognitionHistory', recognitionHistory))
        .toString();
  }
}

class PointsHistoryViewModelBuilder
    implements Builder<PointsHistoryViewModel, PointsHistoryViewModelBuilder> {
  _$PointsHistoryViewModel _$v;

  ListBuilder<RecognitionRegister> _recognitionHistory;
  ListBuilder<RecognitionRegister> get recognitionHistory =>
      _$this._recognitionHistory ??= new ListBuilder<RecognitionRegister>();
  set recognitionHistory(ListBuilder<RecognitionRegister> recognitionHistory) =>
      _$this._recognitionHistory = recognitionHistory;

  PointsHistoryViewModelBuilder();

  PointsHistoryViewModelBuilder get _$this {
    if (_$v != null) {
      _recognitionHistory = _$v.recognitionHistory?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PointsHistoryViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PointsHistoryViewModel;
  }

  @override
  void update(void Function(PointsHistoryViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PointsHistoryViewModel build() {
    _$PointsHistoryViewModel _$result;
    try {
      _$result = _$v ??
          new _$PointsHistoryViewModel._(
              recognitionHistory: recognitionHistory.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'recognitionHistory';
        recognitionHistory.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PointsHistoryViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
