import 'dart:collection';

import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'news_list_row_collection_view_model.dart';

/// BloC for the [NewsListCollectionComponent].
///
/// Exposes a [NewsListRowCollectionViewModel] for that component to use.
class NewsListRowCollectionBloc {
  final NewsFeedRepository _newsFeedRepository;

  Source<NewsListRowCollectionViewModel> get viewModel =>
      toSource(combineLatest(_newsFeedRepository.newsFeed, _createViewModel));

  @provide
  NewsListRowCollectionBloc(this._newsFeedRepository);

  NewsListRowCollectionViewModel _createViewModel(
      UnmodifiableListView<NewsFeedItem> newsFeedItems) {
    return NewsListRowCollectionViewModel((b) => b
      ..newsFeedItemIds.addAll(listOfNewsFeedItemIds(newsFeedItems))
      ..newsFeedItemCategories.addAll(listOfNewsFeedCategories(newsFeedItems)));
  }

  List<String> listOfNewsFeedItemIds(
          UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
      newsFeedItems
          .map((newsFeedItem) => (newsFeedItem.id).toString())
          .toList();

  List<String> listOfNewsFeedCategories(
          UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
      newsFeedItems
          .map((newsFeedItem) => (newsFeedItem.category))
          .toSet()
          .toList();
}

/// Constructs new instances of [NewsListRowCollectionBloc]s via the DI framework.
abstract class NewsListRowCollectionBlocFactory implements ProvidedService {
  @provide
  NewsListRowCollectionBloc newsListRowCollectionBloc();
}
