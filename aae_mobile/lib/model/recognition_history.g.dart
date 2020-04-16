// GENERATED CODE - DO NOT MODIFY BY HAND

part of recognition_history;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecognitionHistory> _$recognitionHistorySerializer =
    new _$RecognitionHistorySerializer();

class _$RecognitionHistorySerializer
    implements StructuredSerializer<RecognitionHistory> {
  @override
  final Iterable<Type> types = const [RecognitionHistory, _$RecognitionHistory];
  @override
  final String wireName = 'RecognitionHistory';

  @override
  Iterable<Object> serialize(Serializers serializers, RecognitionHistory object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'current_balance',
      serializers.serialize(object.currentBalance,
          specifiedType: const FullType(String)),
      'recognition_register',
      serializers.serialize(object.recognitionRegister,
          specifiedType: const FullType(
              BuiltList, const [const FullType(RecognitionRegister)])),
    ];

    return result;
  }

  @override
  RecognitionHistory deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecognitionHistoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'current_balance':
          result.currentBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'recognition_register':
          result.recognitionRegister.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(RecognitionRegister)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$RecognitionHistory extends RecognitionHistory {
  @override
  final String currentBalance;
  @override
  final BuiltList<RecognitionRegister> recognitionRegister;

  factory _$RecognitionHistory(
          [void Function(RecognitionHistoryBuilder) updates]) =>
      (new RecognitionHistoryBuilder()..update(updates)).build();

  _$RecognitionHistory._({this.currentBalance, this.recognitionRegister})
      : super._() {
    if (currentBalance == null) {
      throw new BuiltValueNullFieldError(
          'RecognitionHistory', 'currentBalance');
    }
    if (recognitionRegister == null) {
      throw new BuiltValueNullFieldError(
          'RecognitionHistory', 'recognitionRegister');
    }
  }

  @override
  RecognitionHistory rebuild(
          void Function(RecognitionHistoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecognitionHistoryBuilder toBuilder() =>
      new RecognitionHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecognitionHistory &&
        currentBalance == other.currentBalance &&
        recognitionRegister == other.recognitionRegister;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, currentBalance.hashCode), recognitionRegister.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecognitionHistory')
          ..add('currentBalance', currentBalance)
          ..add('recognitionRegister', recognitionRegister))
        .toString();
  }
}

class RecognitionHistoryBuilder
    implements Builder<RecognitionHistory, RecognitionHistoryBuilder> {
  _$RecognitionHistory _$v;

  String _currentBalance;
  String get currentBalance => _$this._currentBalance;
  set currentBalance(String currentBalance) =>
      _$this._currentBalance = currentBalance;

  ListBuilder<RecognitionRegister> _recognitionRegister;
  ListBuilder<RecognitionRegister> get recognitionRegister =>
      _$this._recognitionRegister ??= new ListBuilder<RecognitionRegister>();
  set recognitionRegister(
          ListBuilder<RecognitionRegister> recognitionRegister) =>
      _$this._recognitionRegister = recognitionRegister;

  RecognitionHistoryBuilder();

  RecognitionHistoryBuilder get _$this {
    if (_$v != null) {
      _currentBalance = _$v.currentBalance;
      _recognitionRegister = _$v.recognitionRegister?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecognitionHistory other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RecognitionHistory;
  }

  @override
  void update(void Function(RecognitionHistoryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RecognitionHistory build() {
    _$RecognitionHistory _$result;
    try {
      _$result = _$v ??
          new _$RecognitionHistory._(
              currentBalance: currentBalance,
              recognitionRegister: recognitionRegister.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'recognitionRegister';
        recognitionRegister.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RecognitionHistory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
