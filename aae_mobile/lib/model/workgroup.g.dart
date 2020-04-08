// GENERATED CODE - DO NOT MODIFY BY HAND

part of workgroup;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Workgroup> _$workgroupSerializer = new _$WorkgroupSerializer();

class _$WorkgroupSerializer implements StructuredSerializer<Workgroup> {
  @override
  final Iterable<Type> types = const [Workgroup, _$Workgroup];
  @override
  final String wireName = 'Workgroup';

  @override
  Iterable<Object> serialize(Serializers serializers, Workgroup object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.workgroups != null) {
      result
        ..add('workgroup')
        ..add(serializers.serialize(object.workgroups,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Workgroup deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WorkgroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'workgroup':
          result.workgroups = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Workgroup extends Workgroup {
  @override
  final String workgroups;

  factory _$Workgroup([void Function(WorkgroupBuilder) updates]) =>
      (new WorkgroupBuilder()..update(updates)).build();

  _$Workgroup._({this.workgroups}) : super._();

  @override
  Workgroup rebuild(void Function(WorkgroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkgroupBuilder toBuilder() => new WorkgroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Workgroup && workgroups == other.workgroups;
  }

  @override
  int get hashCode {
    return $jf($jc(0, workgroups.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Workgroup')
          ..add('workgroups', workgroups))
        .toString();
  }
}

class WorkgroupBuilder implements Builder<Workgroup, WorkgroupBuilder> {
  _$Workgroup _$v;

  String _workgroups;
  String get workgroups => _$this._workgroups;
  set workgroups(String workgroups) => _$this._workgroups = workgroups;

  WorkgroupBuilder();

  WorkgroupBuilder get _$this {
    if (_$v != null) {
      _workgroups = _$v.workgroups;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Workgroup other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Workgroup;
  }

  @override
  void update(void Function(WorkgroupBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Workgroup build() {
    final _$result = _$v ?? new _$Workgroup._(workgroups: workgroups);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
