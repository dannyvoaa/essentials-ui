// GENERATED CODE - DO NOT MODIFY BY HAND

part of recognition_register;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RecognitionRegister> _$recognitionRegisterSerializer =
    new _$RecognitionRegisterSerializer();

class _$RecognitionRegisterSerializer
    implements StructuredSerializer<RecognitionRegister> {
  @override
  final Iterable<Type> types = const [
    RecognitionRegister,
    _$RecognitionRegister
  ];
  @override
  final String wireName = 'RecognitionRegister';

  @override
  Iterable<Object> serialize(
      Serializers serializers, RecognitionRegister object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(String)),
      'avatar_url',
      serializers.serialize(object.avatarUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  RecognitionRegister deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RecognitionRegisterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar_url':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$RecognitionRegister extends RecognitionRegister {
  @override
  final String id;
  @override
  final String date;
  @override
  final String name;
  @override
  final String message;
  @override
  final String amount;
  @override
  final String avatarUrl;

  factory _$RecognitionRegister(
          [void Function(RecognitionRegisterBuilder) updates]) =>
      (new RecognitionRegisterBuilder()..update(updates)).build();

  _$RecognitionRegister._(
      {this.id,
      this.date,
      this.name,
      this.message,
      this.amount,
      this.avatarUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'id');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'date');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'name');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'message');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'amount');
    }
    if (avatarUrl == null) {
      throw new BuiltValueNullFieldError('RecognitionRegister', 'avatarUrl');
    }
  }

  @override
  RecognitionRegister rebuild(
          void Function(RecognitionRegisterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecognitionRegisterBuilder toBuilder() =>
      new RecognitionRegisterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecognitionRegister &&
        id == other.id &&
        date == other.date &&
        name == other.name &&
        message == other.message &&
        amount == other.amount &&
        avatarUrl == other.avatarUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), date.hashCode), name.hashCode),
                message.hashCode),
            amount.hashCode),
        avatarUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RecognitionRegister')
          ..add('id', id)
          ..add('date', date)
          ..add('name', name)
          ..add('message', message)
          ..add('amount', amount)
          ..add('avatarUrl', avatarUrl))
        .toString();
  }
}

class RecognitionRegisterBuilder
    implements Builder<RecognitionRegister, RecognitionRegisterBuilder> {
  _$RecognitionRegister _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _amount;
  String get amount => _$this._amount;
  set amount(String amount) => _$this._amount = amount;

  String _avatarUrl;
  String get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String avatarUrl) => _$this._avatarUrl = avatarUrl;

  RecognitionRegisterBuilder();

  RecognitionRegisterBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _date = _$v.date;
      _name = _$v.name;
      _message = _$v.message;
      _amount = _$v.amount;
      _avatarUrl = _$v.avatarUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecognitionRegister other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RecognitionRegister;
  }

  @override
  void update(void Function(RecognitionRegisterBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RecognitionRegister build() {
    final _$result = _$v ??
        new _$RecognitionRegister._(
            id: id,
            date: date,
            name: name,
            message: message,
            amount: amount,
            avatarUrl: avatarUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
