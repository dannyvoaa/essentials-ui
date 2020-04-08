import 'dart:collection';

import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'news_list_collection_view_model.dart';

/// BloC for the [NewsListCollectionComponent].
///
/// Exposes a [NewsListCollectionViewModel] for that component to use.
class NewsListCollectionBloc {
  final NewsFeedRepository _newsFeedRepository;

  Source<NewsListCollectionViewModel> get viewModel =>
      toSource(combineLatest(_newsFeedRepository.newsFeed, _createViewModel));

  @provide
  NewsListCollectionBloc(this._newsFeedRepository);

  NewsListCollectionViewModel _createViewModel(
      UnmodifiableListView<NewsFeedItem> newsFeedItem) {
    return NewsListCollectionViewModel((b) => b
      ..newsFeedItemIds.addAll(listOfNewsFeedItemIds(newsFeedItem))
      ..newsFeedCategories.addAll(listOfNewsFeedCategories(newsFeedItem)));
  }

  List<String> listOfNewsFeedItemIds(
          UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
      newsFeedItems
          .map((newsFeedItem) => (newsFeedItem.id).toString())
          .toList();

  List<String> listOfNewsFeedCategories(
          UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
      newsFeedItems.map((newsFeedItem) => (newsFeedItem.category)).toList();
}

/// Constructs new instances of [NewsListCollectionBloc]s via the DI framework.
abstract class NewsListCollectionBlocFactory implements ProvidedService {
  @provide
  NewsListCollectionBloc newsListCollectionBloc();
}
