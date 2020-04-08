// GENERATED CODE - DO NOT MODIFY BY HAND

part of news_feed_item;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NewsFeedItem> _$newsFeedItemSerializer =
    new _$NewsFeedItemSerializer();

class _$NewsFeedItemSerializer implements StructuredSerializer<NewsFeedItem> {
  @override
  final Iterable<Type> types = const [NewsFeedItem, _$NewsFeedItem];
  @override
  final String wireName = 'NewsFeedItem';

  @override
  Iterable<Object> serialize(Serializers serializers, NewsFeedItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.author != null) {
      result
        ..add('author')
        ..add(serializers.serialize(object.author,
            specifiedType: const FullType(Author)));
    }
    if (object.category != null) {
      result
        ..add('category')
        ..add(serializers.serialize(object.category,
            specifiedType: const FullType(String)));
    }
    if (object.date != null) {
      result
        ..add('date')
        ..add(serializers.serialize(object.date,
            specifiedType: const FullType(DateTime)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
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
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NewsFeedItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsFeedItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'author':
          result.author.replace(serializers.deserialize(value,
              specifiedType: const FullType(Author)) as Author);
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$NewsFeedItem extends NewsFeedItem {
  @override
  final Author author;
  @override
  final String category;
  @override
  final DateTime date;
  @override
  final String description;
  @override
  final int id;
  @override
  final Uri image;
  @override
  final String title;

  factory _$NewsFeedItem([void Function(NewsFeedItemBuilder) updates]) =>
      (new NewsFeedItemBuilder()..update(updates)).build();

  _$NewsFeedItem._(
      {this.author,
      this.category,
      this.date,
      this.description,
      this.id,
      this.image,
      this.title})
      : super._();

  @override
  NewsFeedItem rebuild(void Function(NewsFeedItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsFeedItemBuilder toBuilder() => new NewsFeedItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsFeedItem &&
        author == other.author &&
        category == other.category &&
        date == other.date &&
        description == other.description &&
        id == other.id &&
        image == other.image &&
        title == other.title;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, author.hashCode), category.hashCode),
                        date.hashCode),
                    description.hashCode),
                id.hashCode),
            image.hashCode),
        title.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsFeedItem')
          ..add('author', author)
          ..add('category', category)
          ..add('date', date)
          ..add('description', description)
          ..add('id', id)
          ..add('image', image)
          ..add('title', title))
        .toString();
  }
}

class NewsFeedItemBuilder
    implements Builder<NewsFeedItem, NewsFeedItemBuilder> {
  _$NewsFeedItem _$v;

  AuthorBuilder _author;
  AuthorBuilder get author => _$this._author ??= new AuthorBuilder();
  set author(AuthorBuilder author) => _$this._author = author;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  Uri _image;
  Uri get image => _$this._image;
  set image(Uri image) => _$this._image = image;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  NewsFeedItemBuilder();

  NewsFeedItemBuilder get _$this {
    if (_$v != null) {
      _author = _$v.author?.toBuilder();
      _category = _$v.category;
      _date = _$v.date;
      _description = _$v.description;
      _id = _$v.id;
      _image = _$v.image;
      _title = _$v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsFeedItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewsFeedItem;
  }

  @override
  void update(void Function(NewsFeedItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewsFeedItem build() {
    _$NewsFeedItem _$result;
    try {
      _$result = _$v ??
          new _$NewsFeedItem._(
              author: _author?.build(),
              category: category,
              date: date,
              description: description,
              id: id,
              image: image,
              title: title);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'author';
        _author?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewsFeedItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
