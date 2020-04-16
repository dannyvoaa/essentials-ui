// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_collection_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewsListCollectionViewModel extends NewsListCollectionViewModel {
  @override
  final BuiltList<String> newsFeedCategories;
  @override
  final BuiltList<NewsListRowCollectionViewModel>
      newsListRowCollectionViewModels;

  factory _$NewsListCollectionViewModel(
          [void Function(NewsListCollectionViewModelBuilder) updates]) =>
      (new NewsListCollectionViewModelBuilder()..update(updates)).build();

  _$NewsListCollectionViewModel._(
      {this.newsFeedCategories, this.newsListRowCollectionViewModels})
      : super._() {
    if (newsFeedCategories == null) {
      throw new BuiltValueNullFieldError(
          'NewsListCollectionViewModel', 'newsFeedCategories');
    }
    if (newsListRowCollectionViewModels == null) {
      throw new BuiltValueNullFieldError(
          'NewsListCollectionViewModel', 'newsListRowCollectionViewModels');
    }
  }

  @override
  NewsListCollectionViewModel rebuild(
          void Function(NewsListCollectionViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsListCollectionViewModelBuilder toBuilder() =>
      new NewsListCollectionViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsListCollectionViewModel &&
        newsFeedCategories == other.newsFeedCategories &&
        newsListRowCollectionViewModels ==
            other.newsListRowCollectionViewModels;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, newsFeedCategories.hashCode),
        newsListRowCollectionViewModels.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewsListCollectionViewModel')
          ..add('newsFeedCategories', newsFeedCategories)
          ..add('newsListRowCollectionViewModels',
              newsListRowCollectionViewModels))
        .toString();
  }
}

class NewsListCollectionViewModelBuilder
    implements
        Builder<NewsListCollectionViewModel,
            NewsListCollectionViewModelBuilder> {
  _$NewsListCollectionViewModel _$v;

  ListBuilder<String> _newsFeedCategories;
  ListBuilder<String> get newsFeedCategories =>
      _$this._newsFeedCategories ??= new ListBuilder<String>();
  set newsFeedCategories(ListBuilder<String> newsFeedCategories) =>
      _$this._newsFeedCategories = newsFeedCategories;

  ListBuilder<NewsListRowCollectionViewModel> _newsListRowCollectionViewModels;
  ListBuilder<NewsListRowCollectionViewModel>
      get newsListRowCollectionViewModels =>
          _$this._newsListRowCollectionViewModels ??=
              new ListBuilder<NewsListRowCollectionViewModel>();
  set newsListRowCollectionViewModels(
          ListBuilder<NewsListRowCollectionViewModel>
              newsListRowCollectionViewModels) =>
      _$this._newsListRowCollectionViewModels = newsListRowCollectionViewModels;

  NewsListCollectionViewModelBuilder();

  NewsListCollectionViewModelBuilder get _$this {
    if (_$v != null) {
      _newsFeedCategories = _$v.newsFeedCategories?.toBuilder();
      _newsListRowCollectionViewModels =
          _$v.newsListRowCollectionViewModels?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsListCollectionViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewsListCollectionViewModel;
  }

  @override
  void update(void Function(NewsListCollectionViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewsListCollectionViewModel build() {
    _$NewsListCollectionViewModel _$result;
    try {
      _$result = _$v ??
          new _$NewsListCollectionViewModel._(
              newsFeedCategories: newsFeedCategories.build(),
              newsListRowCollectionViewModels:
                  newsListRowCollectionViewModels.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'newsFeedCategories';
        newsFeedCategories.build();
        _$failedField = 'newsListRowCollectionViewModels';
        newsListRowCollectionViewModels.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewsListCollectionViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
