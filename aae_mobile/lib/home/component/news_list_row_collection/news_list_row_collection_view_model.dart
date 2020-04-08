import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'news_list_row_collection_view_model.g.dart';

/// View model representing a [NewsListRowCollectionView]
abstract class NewsListRowCollectionViewModel
    implements
        Built<NewsListRowCollectionViewModel,
            NewsListRowCollectionViewModelBuilder> {
  BuiltList<String> get newsFeedItemIds;
  BuiltList<String> get newsFeedItemCategories;

  NewsListRowCollectionViewModel._();

  factory NewsListRowCollectionViewModel(
          [updates(NewsListRowCollectionViewModelBuilder b)]) =
      _$NewsListRowCollectionViewModel;
}
