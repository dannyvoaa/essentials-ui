// GENERATED CODE - DO NOT MODIFY BY HAND

part of profile;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Profile> _$profileSerializer = new _$ProfileSerializer();

class _$ProfileSerializer implements StructuredSerializer<Profile> {
  @override
  final Iterable<Type> types = const [Profile, _$Profile];
  @override
  final String wireName = 'Profile';

  @override
  Iterable<Object> serialize(Serializers serializers, Profile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.aaId != null) {
      result
        ..add('aaid')
        ..add(serializers.serialize(object.aaId,
            specifiedType: const FullType(String)));
    }
    if (object.jiveId != null) {
      result
        ..add('jiveid')
        ..add(serializers.serialize(object.jiveId,
            specifiedType: const FullType(String)));
    }
    if (object.profileImage != null) {
      result
        ..add('profileimage')
        ..add(serializers.serialize(object.profileImage,
            specifiedType: const FullType(String)));
    }
    if (object.topics != null) {
      result
        ..add('topics')
        ..add(serializers.serialize(object.topics,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Topics)])));
    }
    if (object.workgroup != null) {
      result
        ..add('workgroup')
        ..add(serializers.serialize(object.workgroup,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Workgroup)])));
    }
    return result;
  }

  @override
  Profile deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'aaid':
          result.aaId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'jiveid':
          result.jiveId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profileimage':
          result.profileImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'topics':
          result.topics.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Topics)]))
              as BuiltList<dynamic>);
          break;
        case 'workgroup':
          result.workgroup.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Workgroup)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$Profile extends Profile {
  @override
  final String aaId;
  @override
  final String jiveId;
  @override
  final String profileImage;
  @override
  final BuiltList<Topics> topics;
  @override
  final BuiltList<Workgroup> workgroup;

  factory _$Profile([void Function(ProfileBuilder) updates]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.aaId, this.jiveId, this.profileImage, this.topics, this.workgroup})
      : super._();

  @override
  Profile rebuild(void Function(ProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => new ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        aaId == other.aaId &&
        jiveId == other.jiveId &&
        profileImage == other.profileImage &&
        topics == other.topics &&
        workgroup == other.workgroup;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, aaId.hashCode), jiveId.hashCode),
                profileImage.hashCode),
            topics.hashCode),
        workgroup.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('aaId', aaId)
          ..add('jiveId', jiveId)
          ..add('profileImage', profileImage)
          ..add('topics', topics)
          ..add('workgroup', workgroup))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _aaId;
  String get aaId => _$this._aaId;
  set aaId(String aaId) => _$this._aaId = aaId;

  String _jiveId;
  String get jiveId => _$this._jiveId;
  set jiveId(String jiveId) => _$this._jiveId = jiveId;

  String _profileImage;
  String get profileImage => _$this._profileImage;
  set profileImage(String profileImage) => _$this._profileImage = profileImage;

  ListBuilder<Topics> _topics;
  ListBuilder<Topics> get topics =>
      _$this._topics ??= new ListBuilder<Topics>();
  set topics(ListBuilder<Topics> topics) => _$this._topics = topics;

  ListBuilder<Workgroup> _workgroup;
  ListBuilder<Workgroup> get workgroup =>
      _$this._workgroup ??= new ListBuilder<Workgroup>();
  set workgroup(ListBuilder<Workgroup> workgroup) =>
      _$this._workgroup = workgroup;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _aaId = _$v.aaId;
      _jiveId = _$v.jiveId;
      _profileImage = _$v.profileImage;
      _topics = _$v.topics?.toBuilder();
      _workgroup = _$v.workgroup?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Profile;
  }

  @override
  void update(void Function(ProfileBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Profile build() {
    _$Profile _$result;
    try {
      _$result = _$v ??
          new _$Profile._(
              aaId: aaId,
              jiveId: jiveId,
              profileImage: profileImage,
              topics: _topics?.build(),
              workgroup: _workgroup?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'topics';
        _topics?.build();
        _$failedField = 'workgroup';
        _workgroup?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Profile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
