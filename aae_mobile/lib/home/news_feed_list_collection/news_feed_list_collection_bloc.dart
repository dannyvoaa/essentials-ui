import 'dart:collection';

import 'package:aae/home/news_feed_list_row_collection/news_feed_list_row_collection_view_model.dart';
import 'package:aae/home/news_feed_repository.dart';
import 'package:aae/model/news_feed_json_list.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'news_feed_list_collection_view_model.dart';

/// BloC for the [NewsFeedListCollectionComponent].
///
/// Exposes a [NewsFeedListCollectionViewModel] for that component to use.
class NewsFeedListCollectionBloc {
  final NewsFeedRepository _newsFeedRepository;
  final ProfileRepository _profileRepository;

  //Source is the producer/source of data. A source is expected to produce a sequence of data over time.
  //Converts the observable to a Source. The observable will be shareReplayed to meet the contracts of Source.
  Source<NewsFeedListCollectionViewModel> get viewModel => toSource(combineLatest2(_newsFeedRepository.newsFeedJsonList, _profileRepository.profile, _createViewModel));

  @provide
  NewsFeedListCollectionBloc(this._newsFeedRepository, this._profileRepository);

  NewsFeedListCollectionViewModel _createViewModel(UnmodifiableListView<NewsFeedJsonList> feed, Profile profile) {
    print('******NewsFeedListCollectionBloc._createViewModel:feed' + feed.toString() + '*****');
    print('******NewsFeedListCollectionBloc._createViewModel:profile' + profile.toString() + '*****');
    _newsFeedRepository.fetchNewsFeedJsonList(profile);
    return NewsFeedListCollectionViewModel((b) => b
      ..newsFeedCategories.addAll(listOfNewsFeedCategories(profile))
      ..newsFeedListRowCollectionViewModels.addAll(_createRowViewModels(feed, profile)));
  }

  List<String> listOfNewsFeedCategories(Profile profile) {
    List<String> categories = <String>['news'];
    if (profile.userlocation != "" || profile.userlocation != null)
      categories.add(profile.userlocation);
    if (profile.userworkgroup != ""|| profile.userworkgroup != null)
      categories.add(profile.userworkgroup);
    categories.addAll(profile.topics);
    categories.addAll(profile.workgroup);
    categories.addAll(profile.hubLocation);
    print('***********Categories*************');
    print(categories);
    return categories;
  }

  List<NewsFeedListRowCollectionViewModel> _createRowViewModels(UnmodifiableListView<NewsFeedJsonList> myfeed, Profile profile) {
    print('******myfeed:' + myfeed.toString() + '*****');
    print('******profile:' + profile.toString() + '*****');
    List<NewsFeedListRowCollectionViewModel> viewModels = <NewsFeedListRowCollectionViewModel>[];
    for (var feed in myfeed) {
      print('******each feed:' + feed.toString() + '*****');
      viewModels.add(NewsFeedListRowCollectionViewModel((b) => b
        ..newsFeedItemIds.addAll(feed.newsFeedJsonList.map((e) => e.id).toList())
        ..newsFeedItemContentIds.addAll(feed.newsFeedJsonList.map((e) => e.contentID).toList())
        ..newsFeedItemCategories.addAll(listOfNewsFeedCategories(profile))));
    }
    return viewModels;
  }
}

/// Constructs new instances of [NewsFeedListCollectionBloc]s via the DI framework.
abstract class NewsFeedListCollectionBlocFactory implements ProvidedService {
  @provide
  NewsFeedListCollectionBloc newsFeedListCollectionBloc();
}
