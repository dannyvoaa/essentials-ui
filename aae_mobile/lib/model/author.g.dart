// GENERATED CODE - DO NOT MODIFY BY HAND

part of author;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Author> _$authorSerializer = new _$AuthorSerializer();

class _$AuthorSerializer implements StructuredSerializer<Author> {
  @override
  final Iterable<Type> types = const [Author, _$Author];
  @override
  final String wireName = 'Author';

  @override
  Iterable<Object> serialize(Serializers serializers, Author object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.image != null) {
      result
        ..add('image')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(Uri)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Author deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Author extends Author {
  @override
  final int id;
  @override
  final Uri image;
  @override
  final String name;

  factory _$Author([void Function(AuthorBuilder) updates]) =>
      (new AuthorBuilder()..update(updates)).build();

  _$Author._({this.id, this.image, this.name}) : super._();

  @override
  Author rebuild(void Function(AuthorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthorBuilder toBuilder() => new AuthorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Author &&
        id == other.id &&
        image == other.image &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), image.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Author')
          ..add('id', id)
          ..add('image', image)
          ..add('name', name))
        .toString();
  }
}

class AuthorBuilder implements Builder<Author, AuthorBuilder> {
  _$Author _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  Uri _image;
  Uri get image => _$this._image;
  set image(Uri image) => _$this._image = image;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  AuthorBuilder();

  AuthorBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _image = _$v.image;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Author other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Author;
  }

  @override
  void update(void Function(AuthorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Author build() {
    final _$result = _$v ?? new _$Author._(id: id, image: image, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
