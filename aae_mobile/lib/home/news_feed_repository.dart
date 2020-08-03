import 'dart:collection';
import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/news_feed_json_list.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a [NewsFeed].
///
/// Single source of truth for all News Feed data - do not stream [NewsFeed]s in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class NewsFeedRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('NewsFeedRepository'));
  static const cacheKey = 'NewsFeedRepository.News';
  final ProfileRepository _profileRepository;

  final NewsServiceApi _apiClient;
  final CacheService _cache;

  @provide
  @singleton
  NewsFeedRepository([this._apiClient, this._cache, this._profileRepository]) {
    _profileRepository.fetchActiveProfile().then((value) => fetchNewsFeedJsonList(value));
  } //If the callback returns a Future, the future returned by then will be completed with the same result as the future returned by the callback.

  final _newsFeedJsonList = createBehaviorSubject<UnmodifiableListView<NewsFeedJsonList>>();
  final _newsFeedItemsByNewsFeedItemId = BehaviorSubjectMap<String, NewsFeedItem>();

  Observable<UnmodifiableListView<NewsFeedJsonList>> get newsFeedJsonList => _newsFeedJsonList.distinctUntilChanged(); //Publishes [NewsFeedItem]s
  Observable<NewsFeedItem> newsFeedItemById(String newsFeedItemId) => _newsFeedItemsByNewsFeedItemId.data(newsFeedItemId).distinctUntilChanged(); //Publishes [NewsFeedItem]s by ID.


  fetchNewsFeedJsonList(Profile profile) async {
    try {
      List<String> tags = ['news'];
      if (profile.userlocation != "" && profile.userlocation != null)
        tags.add(profile.userlocation);
      tags.addAll(profile.hubLocation);
      tags.addAll(profile.workgroup);
      tags.addAll(profile.topics);

      List<NewsFeedJsonList> jfeed = (await _apiClient.getNewsFeed(tags));
      _publishNewsFeed(jfeed);
      return jfeed;
    } catch (e, s) {
      _log.severe('Failed to fetch news feed: ', e, s);
      return null;
    }
  }

  void _publishNewsFeed(List<NewsFeedJsonList> jnewsFeed) {
    jnewsFeed.asMap().forEach((index, value) {
      this.publishNewsFeedItems(value.newsFeedJsonList, jnewsFeed);
    });

  }

  void publishNewsFeedItems(Iterable<NewsFeedItem> updatedNewsFeedItems, List<NewsFeedJsonList> jnewsFeed) { //Updates the published streams for the [NewsFeedItems]s specified by [updatedNewsFeedItems].
    for (var newsFeedItem in updatedNewsFeedItems) {
      _newsFeedItemsByNewsFeedItemId.update(newsFeedItem.id.toString(), newsFeedItem);
    }
    _newsFeedJsonList.sendNext(UnmodifiableListView(jnewsFeed));
  }

  Future<void> _saveToCache(news) => _cache.writeString(cacheKey, news);

  @override
  void start() {} // NO-OP
  @override
  void stop() {
    //_newsFeedJsonList.sendCompleted();
  } // NO-OP
  @override
  void clear() {} // NO-OP
}
