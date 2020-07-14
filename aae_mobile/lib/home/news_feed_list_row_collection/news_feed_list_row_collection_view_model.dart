import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'news_feed_list_row_collection_view_model.g.dart';

/// View model representing a [NewsFeedListRowCollectionView]
abstract class NewsFeedListRowCollectionViewModel implements Built<NewsFeedListRowCollectionViewModel, NewsFeedListRowCollectionViewModelBuilder> {
  BuiltList<String> get newsFeedItemIds;
  BuiltList<String> get newsFeedItemCategories;
  BuiltList<String> get newsFeedItemContentIds;

  NewsFeedListRowCollectionViewModel._();

  factory NewsFeedListRowCollectionViewModel([updates(NewsFeedListRowCollectionViewModelBuilder b)]) =_$NewsFeedListRowCollectionViewModel;
}
