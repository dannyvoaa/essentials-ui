// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_row_collection_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewsListRowCollectionViewModel extends NewsListRowCollectionViewModel {
  @override
  final BuiltList<String> newsFeedItemIds;
  @override
  final BuiltList<String> newsFeedItemCategories;

  factory _$NewsListRowCollectionViewModel(
          [void Function(NewsListRowCollectionViewModelBuilder) updates]) =>
      (new NewsListRowCollectionViewModelBuilder()..update(updates)).build();

  _$NewsListRowCollectionViewModel._(
      {this.newsFeedItemIds, this.newsFeedItemCategories})
      : super._() {
    if (newsFeedItemIds == null) {
      throw new BuiltValueNullFieldError(
          'NewsListRowCollectionViewModel', 'newsFeedItemIds');
    }
    if (newsFeedItemCategories == null) {
      throw new BuiltValueNullFieldError(
          'NewsListRowCollectionViewModel', 'newsFeedItemCategories');
    }
  }

  @override
  NewsListRowCollectionViewModel rebuild(
          void Function(NewsListRowCollectionViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsListRowCollectionViewModelBuilder toBuilder() =>
      new NewsListRowCollectionViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsListRowCollectionViewModel &&
        newsFeedItemIds == other.newsFeedItemIds &&
        newsFeedItemCategories == other.newsFeedItemCategories;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc(0, newsFeedItemIds.hashCode), newsFeedItemCategories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsListRowCollectionViewModel')
          ..add('newsFeedItemIds', newsFeedItemIds)
          ..add('newsFeedItemCategories', newsFeedItemCategories))
        .toString();
  }
}

class NewsListRowCollectionViewModelBuilder
    implements
        Builder<NewsListRowCollectionViewModel,
            NewsListRowCollectionViewModelBuilder> {
  _$NewsListRowCollectionViewModel _$v;

  ListBuilder<String> _newsFeedItemIds;
  ListBuilder<String> get newsFeedItemIds =>
      _$this._newsFeedItemIds ??= new ListBuilder<String>();
  set newsFeedItemIds(ListBuilder<String> newsFeedItemIds) =>
      _$this._newsFeedItemIds = newsFeedItemIds;

  ListBuilder<String> _newsFeedItemCategories;
  ListBuilder<String> get newsFeedItemCategories =>
      _$this._newsFeedItemCategories ??= new ListBuilder<String>();
  set newsFeedItemCategories(ListBuilder<String> newsFeedItemCategories) =>
      _$this._newsFeedItemCategories = newsFeedItemCategories;

  NewsListRowCollectionViewModelBuilder();

  NewsListRowCollectionViewModelBuilder get _$this {
    if (_$v != null) {
      _newsFeedItemIds = _$v.newsFeedItemIds?.toBuilder();
      _newsFeedItemCategories = _$v.newsFeedItemCategories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsListRowCollectionViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewsListRowCollectionViewModel;
  }

  @override
  void update(void Function(NewsListRowCollectionViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewsListRowCollectionViewModel build() {
    _$NewsListRowCollectionViewModel _$result;
    try {
      _$result = _$v ??
          new _$NewsListRowCollectionViewModel._(
              newsFeedItemIds: newsFeedItemIds.build(),
              newsFeedItemCategories: newsFeedItemCategories.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'newsFeedItemIds';
        newsFeedItemIds.build();
        _$failedField = 'newsFeedItemCategories';
        newsFeedItemCategories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewsListRowCollectionViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
