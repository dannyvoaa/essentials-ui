import 'package:aae/home/news_feed_list_row_collection/news_feed_list_row_collection_view_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'news_feed_list_collection_view_model.g.dart';

/// View model representing a [NewsFeedListView]
abstract class NewsFeedListCollectionViewModel implements Built<NewsFeedListCollectionViewModel, NewsFeedListCollectionViewModelBuilder> {
  BuiltList<String> get newsFeedCategories;
  BuiltList<NewsFeedListRowCollectionViewModel> get newsFeedListRowCollectionViewModels;

  NewsFeedListCollectionViewModel._();

  factory NewsFeedListCollectionViewModel([updates(NewsFeedListCollectionViewModelBuilder b)]) = _$NewsFeedListCollectionViewModel;
}
