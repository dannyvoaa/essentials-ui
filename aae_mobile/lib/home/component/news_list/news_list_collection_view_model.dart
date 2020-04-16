import 'package:aae/home/component/news_list_row_collection/news_list_row_collection_view_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'news_list_collection_view_model.g.dart';

/// View model representing a [NewsListView]
abstract class NewsListCollectionViewModel
    implements
        Built<NewsListCollectionViewModel, NewsListCollectionViewModelBuilder> {
  BuiltList<String> get newsFeedCategories;

  BuiltList<NewsListRowCollectionViewModel> get newsListRowCollectionViewModels;

  NewsListCollectionViewModel._();

  factory NewsListCollectionViewModel(
          [updates(NewsListCollectionViewModelBuilder b)]) =
      _$NewsListCollectionViewModel;
}
