// GENERATED CODE - DO NOT MODIFY BY HAND

part of news_feed;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NewsFeed> _$newsFeedSerializer = new _$NewsFeedSerializer();

class _$NewsFeedSerializer implements StructuredSerializer<NewsFeed> {
  @override
  final Iterable<Type> types = const [NewsFeed, _$NewsFeed];
  @override
  final String wireName = 'NewsFeed';

  @override
  Iterable<Object> serialize(Serializers serializers, NewsFeed object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.newsFeedItemList != null) {
      result
        ..add('NewsFeed')
        ..add(serializers.serialize(object.newsFeedItemList,
            specifiedType: const FullType(
                BuiltList, const [const FullType(NewsFeedItem)])));
    }
    return result;
  }

  @override
  NewsFeed deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsFeedBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'NewsFeed':
          result.newsFeedItemList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NewsFeedItem)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$NewsFeed extends NewsFeed {
  @override
  final BuiltList<NewsFeedItem> newsFeedItemList;

  factory _$NewsFeed([void Function(NewsFeedBuilder) updates]) =>
      (new NewsFeedBuilder()..update(updates)).build();

  _$NewsFeed._({this.newsFeedItemList}) : super._();

  @override
  NewsFeed rebuild(void Function(NewsFeedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsFeedBuilder toBuilder() => new NewsFeedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsFeed && newsFeedItemList == other.newsFeedItemList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, newsFeedItemList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsFeed')
          ..add('newsFeedItemList', newsFeedItemList))
        .toString();
  }
}

class NewsFeedBuilder implements Builder<NewsFeed, NewsFeedBuilder> {
  _$NewsFeed _$v;

  ListBuilder<NewsFeedItem> _newsFeedItemList;
  ListBuilder<NewsFeedItem> get newsFeedItemList =>
      _$this._newsFeedItemList ??= new ListBuilder<NewsFeedItem>();
  set newsFeedItemList(ListBuilder<NewsFeedItem> newsFeedItemList) =>
      _$this._newsFeedItemList = newsFeedItemList;

  NewsFeedBuilder();

  NewsFeedBuilder get _$this {
    if (_$v != null) {
      _newsFeedItemList = _$v.newsFeedItemList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsFeed other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewsFeed;
  }

  @override
  void update(void Function(NewsFeedBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewsFeed build() {
    _$NewsFeed _$result;
    try {
      _$result =
          _$v ?? new _$NewsFeed._(newsFeedItemList: _newsFeedItemList?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'newsFeedItemList';
        _newsFeedItemList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewsFeed', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
