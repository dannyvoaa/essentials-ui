import 'dart:collection';

import 'package:aae/home/component/news_list_row_collection/news_list_row_collection_view_model.dart';
import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/model/news_feed.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/profile/repository/profile_repository.dart';
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
  final ProfileRepository _profileRepository;

  Source<NewsListCollectionViewModel> get viewModel => toSource(combineLatest2(
      _newsFeedRepository.newsFeed,
      _profileRepository.profile,
      _createViewModel));

  @provide
  NewsListCollectionBloc(this._newsFeedRepository, this._profileRepository);

  NewsListCollectionViewModel _createViewModel(
      UnmodifiableListView<NewsFeed> feed, Profile profile) {
    return NewsListCollectionViewModel((b) => b
      ..newsFeedCategories.addAll(listOfNewsFeedCategories(profile))
      ..newsListRowCollectionViewModels
          .addAll(_createRowViewModels(feed, profile)));
  }

  List<String> listOfNewsFeedCategories(Profile profile) {
    List<String> categories = <String>[
      'news',
      'People-Culture',
      'Cargo',
      'dfw',
    ];
    categories.addAll(profile.topics);
    categories.addAll(profile.workgroup);
    print(categories);
    return categories;
  }

  List<NewsListRowCollectionViewModel> _createRowViewModels(
      UnmodifiableListView<NewsFeed> feed, Profile profile) {
    List<NewsListRowCollectionViewModel> viewModels =
        <NewsListRowCollectionViewModel>[];
    for (var feed in feed) {
      viewModels.add(NewsListRowCollectionViewModel((b) => b
        ..newsFeedItemIds
            .addAll(feed.newsFeedItemList.map((e) => e.id).toList())
        ..contentIds
            .addAll(feed.newsFeedItemList.map((e) => e.contentID).toList())
        ..newsFeedItemCategories.addAll(listOfNewsFeedCategories(profile))));
    }
    return viewModels;
  }
}

/// Constructs new instances of [NewsListCollectionBloc]s via the DI framework.
abstract class NewsListCollectionBlocFactory implements ProvidedService {
  @provide
  NewsListCollectionBloc newsListCollectionBloc();
}
