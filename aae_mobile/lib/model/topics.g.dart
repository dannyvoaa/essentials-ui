// GENERATED CODE - DO NOT MODIFY BY HAND

part of topics;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Topics> _$topicsSerializer = new _$TopicsSerializer();

class _$TopicsSerializer implements StructuredSerializer<Topics> {
  @override
  final Iterable<Type> types = const [Topics, _$Topics];
  @override
  final String wireName = 'Topics';

  @override
  Iterable<Object> serialize(Serializers serializers, Topics object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.topics != null) {
      result
        ..add('topics')
        ..add(serializers.serialize(object.topics,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Topics deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TopicsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'topics':
          result.topics = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Topics extends Topics {
  @override
  final String topics;

  factory _$Topics([void Function(TopicsBuilder) updates]) =>
      (new TopicsBuilder()..update(updates)).build();

  _$Topics._({this.topics}) : super._();

  @override
  Topics rebuild(void Function(TopicsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopicsBuilder toBuilder() => new TopicsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Topics && topics == other.topics;
  }

  @override
  int get hashCode {
    return $jf($jc(0, topics.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Topics')..add('topics', topics))
        .toString();
  }
}

class TopicsBuilder implements Builder<Topics, TopicsBuilder> {
  _$Topics _$v;

  String _topics;
  String get topics => _$this._topics;
  set topics(String topics) => _$this._topics = topics;

  TopicsBuilder();

  TopicsBuilder get _$this {
    if (_$v != null) {
      _topics = _$v.topics;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Topics other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Topics;
  }

  @override
  void update(void Function(TopicsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Topics build() {
    final _$result = _$v ?? new _$Topics._(topics: topics);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
