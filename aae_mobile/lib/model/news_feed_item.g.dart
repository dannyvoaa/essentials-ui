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
    final result = <Object>[
      'authorname',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'bodytext',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'contentID',
      serializers.serialize(object.contentID,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image, specifiedType: const FullType(Uri)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
    ];

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
        case 'authorname':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bodytext':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contentID':
          result.contentID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$NewsFeedItem extends NewsFeedItem {
  @override
  final String author;
  @override
  final String body;
  @override
  final String contentID;
  @override
  final String id;
  @override
  final Uri image;
  @override
  final String subject;

  factory _$NewsFeedItem([void Function(NewsFeedItemBuilder) updates]) =>
      (new NewsFeedItemBuilder()..update(updates)).build();

  _$NewsFeedItem._(
      {this.author,
      this.body,
      this.contentID,
      this.id,
      this.image,
      this.subject})
      : super._() {
    if (author == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'author');
    }
    if (body == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'body');
    }
    if (contentID == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'contentID');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'id');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'image');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('NewsFeedItem', 'subject');
    }
  }

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
        body == other.body &&
        contentID == other.contentID &&
        id == other.id &&
        image == other.image &&
        subject == other.subject;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, author.hashCode), body.hashCode),
                    contentID.hashCode),
                id.hashCode),
            image.hashCode),
        subject.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsFeedItem')
          ..add('author', author)
          ..add('body', body)
          ..add('contentID', contentID)
          ..add('id', id)
          ..add('image', image)
          ..add('subject', subject))
        .toString();
  }
}

class NewsFeedItemBuilder
    implements Builder<NewsFeedItem, NewsFeedItemBuilder> {
  _$NewsFeedItem _$v;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  String _contentID;
  String get contentID => _$this._contentID;
  set contentID(String contentID) => _$this._contentID = contentID;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  Uri _image;
  Uri get image => _$this._image;
  set image(Uri image) => _$this._image = image;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  NewsFeedItemBuilder();

  NewsFeedItemBuilder get _$this {
    if (_$v != null) {
      _author = _$v.author;
      _body = _$v.body;
      _contentID = _$v.contentID;
      _id = _$v.id;
      _image = _$v.image;
      _subject = _$v.subject;
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
    final _$result = _$v ??
        new _$NewsFeedItem._(
            author: author,
            body: body,
            contentID: contentID,
            id: id,
            image: image,
            subject: subject);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
