// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_list_item_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewsFeedListItemViewModel extends NewsFeedListItemViewModel {
  @override
  final String displayName;
  @override
  final String shortBody;
  @override
  final Uri image;
  @override
  final String author;
  @override
  final int itemId;
  @override
  final AaeContextCommand onTapped;

  factory _$NewsFeedListItemViewModel(
          [void Function(NewsFeedListItemViewModelBuilder) updates]) =>
      (new NewsFeedListItemViewModelBuilder()..update(updates)).build();

  _$NewsFeedListItemViewModel._(
      {this.displayName,
      this.shortBody,
      this.image,
      this.author,
      this.itemId,
      this.onTapped})
      : super._() {
    if (displayName == null) {
      throw new BuiltValueNullFieldError(
          'NewsFeedListItemViewModel', 'displayName');
    }
    if (shortBody == null) {
      throw new BuiltValueNullFieldError(
          'NewsFeedListItemViewModel', 'shortBody');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('NewsFeedListItemViewModel', 'image');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('NewsFeedListItemViewModel', 'author');
    }
    if (itemId == null) {
      throw new BuiltValueNullFieldError('NewsFeedListItemViewModel', 'itemId');
    }
    if (onTapped == null) {
      throw new BuiltValueNullFieldError(
          'NewsFeedListItemViewModel', 'onTapped');
    }
  }

  @override
  NewsFeedListItemViewModel rebuild(
          void Function(NewsFeedListItemViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsFeedListItemViewModelBuilder toBuilder() =>
      new NewsFeedListItemViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final _$dynamicOther = other as dynamic;
    return other is NewsFeedListItemViewModel &&
        displayName == other.displayName &&
        shortBody == other.shortBody &&
        image == other.image &&
        author == other.author &&
        itemId == other.itemId &&
        onTapped == _$dynamicOther.onTapped;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, displayName.hashCode), shortBody.hashCode),
                    image.hashCode),
                author.hashCode),
            itemId.hashCode),
        onTapped.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsFeedListItemViewModel')
          ..add('displayName', displayName)
          ..add('shortBody', shortBody)
          ..add('image', image)
          ..add('author', author)
          ..add('itemId', itemId)
          ..add('onTapped', onTapped))
        .toString();
  }
}

class NewsFeedListItemViewModelBuilder
    implements
        Builder<NewsFeedListItemViewModel, NewsFeedListItemViewModelBuilder> {
  _$NewsFeedListItemViewModel _$v;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _shortBody;
  String get shortBody => _$this._shortBody;
  set shortBody(String shortBody) => _$this._shortBody = shortBody;

  Uri _image;
  Uri get image => _$this._image;
  set image(Uri image) => _$this._image = image;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  int _itemId;
  int get itemId => _$this._itemId;
  set itemId(int itemId) => _$this._itemId = itemId;

  AaeContextCommand _onTapped;
  AaeContextCommand get onTapped => _$this._onTapped;
  set onTapped(AaeContextCommand onTapped) => _$this._onTapped = onTapped;

  NewsFeedListItemViewModelBuilder();

  NewsFeedListItemViewModelBuilder get _$this {
    if (_$v != null) {
      _displayName = _$v.displayName;
      _shortBody = _$v.shortBody;
      _image = _$v.image;
      _author = _$v.author;
      _itemId = _$v.itemId;
      _onTapped = _$v.onTapped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsFeedListItemViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewsFeedListItemViewModel;
  }

  @override
  void update(void Function(NewsFeedListItemViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewsFeedListItemViewModel build() {
    final _$result = _$v ??
        new _$NewsFeedListItemViewModel._(
            displayName: displayName,
            shortBody: shortBody,
            image: image,
            author: author,
            itemId: itemId,
            onTapped: onTapped);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
