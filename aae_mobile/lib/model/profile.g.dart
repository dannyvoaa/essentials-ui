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
    if (object.userlocation != null) {
      result
        ..add('userlocation')
        ..add(serializers.serialize(object.userlocation,
            specifiedType: const FullType(String)));
    }
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.displayName != null) {
      result
        ..add('displayName')
        ..add(serializers.serialize(object.displayName,
            specifiedType: const FullType(String)));
    }
    if (object.topics != null) {
      result
        ..add('topics')
        ..add(serializers.serialize(object.topics,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.workgroup != null) {
      result
        ..add('workgroup')
        ..add(serializers.serialize(object.workgroup,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.hubLocation != null) {
      result
        ..add('hubLocation')
        ..add(serializers.serialize(object.hubLocation,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
        case 'userlocation':
          result.userlocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'topics':
          result.topics.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'workgroup':
          result.workgroup.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'hubLocation':
          result.hubLocation.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Profile extends Profile {
  @override
  final String userlocation;
  @override
  final String username;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final BuiltList<String> topics;
  @override
  final BuiltList<String> workgroup;
  @override
  final BuiltList<String> hubLocation;

  factory _$Profile([void Function(ProfileBuilder) updates]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.userlocation,
      this.username,
      this.email,
      this.displayName,
      this.topics,
      this.workgroup,
      this.hubLocation})
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
        userlocation == other.userlocation &&
        username == other.username &&
        email == other.email &&
        displayName == other.displayName &&
        topics == other.topics &&
        workgroup == other.workgroup &&
        hubLocation == other.hubLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, userlocation.hashCode), username.hashCode),
                        email.hashCode),
                    displayName.hashCode),
                topics.hashCode),
            workgroup.hashCode),
        hubLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('userlocation', userlocation)
          ..add('username', username)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('topics', topics)
          ..add('workgroup', workgroup)
          ..add('hubLocation', hubLocation))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _userlocation;
  String get userlocation => _$this._userlocation;
  set userlocation(String userlocation) => _$this._userlocation = userlocation;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  ListBuilder<String> _topics;
  ListBuilder<String> get topics =>
      _$this._topics ??= new ListBuilder<String>();
  set topics(ListBuilder<String> topics) => _$this._topics = topics;

  ListBuilder<String> _workgroup;
  ListBuilder<String> get workgroup =>
      _$this._workgroup ??= new ListBuilder<String>();
  set workgroup(ListBuilder<String> workgroup) => _$this._workgroup = workgroup;

  ListBuilder<String> _hubLocation;
  ListBuilder<String> get hubLocation =>
      _$this._hubLocation ??= new ListBuilder<String>();
  set hubLocation(ListBuilder<String> hubLocation) =>
      _$this._hubLocation = hubLocation;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _userlocation = _$v.userlocation;
      _username = _$v.username;
      _email = _$v.email;
      _displayName = _$v.displayName;
      _topics = _$v.topics?.toBuilder();
      _workgroup = _$v.workgroup?.toBuilder();
      _hubLocation = _$v.hubLocation?.toBuilder();
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
              userlocation: userlocation,
              username: username,
              email: email,
              displayName: displayName,
              topics: _topics?.build(),
              workgroup: _workgroup?.build(),
              hubLocation: _hubLocation?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'topics';
        _topics?.build();
        _$failedField = 'workgroup';
        _workgroup?.build();
        _$failedField = 'hubLocation';
        _hubLocation?.build();
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
