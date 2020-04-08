// GENERATED CODE - DO NOT MODIFY BY HAND

part of settings_item;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PreferenceItem> _$preferenceItemSerializer =
    new _$PreferenceItemSerializer();

class _$PreferenceItemSerializer
    implements StructuredSerializer<PreferenceItem> {
  @override
  final Iterable<Type> types = const [PreferenceItem, _$PreferenceItem];
  @override
  final String wireName = 'PreferenceItem';

  @override
  Iterable<Object> serialize(Serializers serializers, PreferenceItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.topicPReference != null) {
      result
        ..add('topic')
        ..add(serializers.serialize(object.topicPReference,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Topics)])));
    }
    if (object.workgroupPreference != null) {
      result
        ..add('workgroup')
        ..add(serializers.serialize(object.workgroupPreference,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Workgroup)])));
    }
    return result;
  }

  @override
  PreferenceItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreferenceItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'topic':
          result.topicPReference.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Topics)]))
              as BuiltList<dynamic>);
          break;
        case 'workgroup':
          result.workgroupPreference.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Workgroup)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$PreferenceItem extends PreferenceItem {
  @override
  final BuiltList<Topics> topicPReference;
  @override
  final BuiltList<Workgroup> workgroupPreference;

  factory _$PreferenceItem([void Function(PreferenceItemBuilder) updates]) =>
      (new PreferenceItemBuilder()..update(updates)).build();

  _$PreferenceItem._({this.topicPReference, this.workgroupPreference})
      : super._();

  @override
  PreferenceItem rebuild(void Function(PreferenceItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreferenceItemBuilder toBuilder() =>
      new PreferenceItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreferenceItem &&
        topicPReference == other.topicPReference &&
        workgroupPreference == other.workgroupPreference;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, topicPReference.hashCode), workgroupPreference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreferenceItem')
          ..add('topicPReference', topicPReference)
          ..add('workgroupPreference', workgroupPreference))
        .toString();
  }
}

class PreferenceItemBuilder
    implements Builder<PreferenceItem, PreferenceItemBuilder> {
  _$PreferenceItem _$v;

  ListBuilder<Topics> _topicPReference;
  ListBuilder<Topics> get topicPReference =>
      _$this._topicPReference ??= new ListBuilder<Topics>();
  set topicPReference(ListBuilder<Topics> topicPReference) =>
      _$this._topicPReference = topicPReference;

  ListBuilder<Workgroup> _workgroupPreference;
  ListBuilder<Workgroup> get workgroupPreference =>
      _$this._workgroupPreference ??= new ListBuilder<Workgroup>();
  set workgroupPreference(ListBuilder<Workgroup> workgroupPreference) =>
      _$this._workgroupPreference = workgroupPreference;

  PreferenceItemBuilder();

  PreferenceItemBuilder get _$this {
    if (_$v != null) {
      _topicPReference = _$v.topicPReference?.toBuilder();
      _workgroupPreference = _$v.workgroupPreference?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreferenceItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreferenceItem;
  }

  @override
  void update(void Function(PreferenceItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreferenceItem build() {
    _$PreferenceItem _$result;
    try {
      _$result = _$v ??
          new _$PreferenceItem._(
              topicPReference: _topicPReference?.build(),
              workgroupPreference: _workgroupPreference?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'topicPReference';
        _topicPReference?.build();
        _$failedField = 'workgroupPreference';
        _workgroupPreference?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PreferenceItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
