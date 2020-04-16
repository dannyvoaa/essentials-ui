import 'dart:collection';
import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/news_feed.dart';
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

  final _newsFeed = createBehaviorSubject<UnmodifiableListView<NewsFeed>>();

  /// All content by their by their news feed item id.
  final _newsFeedItemsByNewsFeedItemId =
      BehaviorSubjectMap<String, NewsFeedItem>();

  /// Updates the published streams for the [NewsFeedItems]s specified by [updatedNewsFeedItems].
  void publishNewsFeedItems(Iterable<NewsFeedItem> updatedNewsFeedItems) {
    for (var newsFeedItem in updatedNewsFeedItems) {
      _newsFeedItemsByNewsFeedItemId.update(
          newsFeedItem.id.toString(), newsFeedItem);
    }
  }

  // TODO(rpaglianwan): ask about this will it share same function as [NewsArticleServiceApi]
  final NewsServiceApi _apiClient;
  final CacheService _cache;

  /// Publishes the [NewsFeedItem]s
  Observable<UnmodifiableListView<NewsFeed>> get newsFeed => _newsFeed;

  /// Publishes a [NewsFeedItem]s by ID.
  Observable<NewsFeedItem> newsFeedItemById(String newsFeedItemId) =>
      _newsFeedItemsByNewsFeedItemId
          .data(newsFeedItemId)
          .distinctUntilChanged();

  @provide
  @singleton
  NewsFeedRepository(this._apiClient, this._cache, this._profileRepository) {
    _profileRepository
        .fetchActiveProfile()
        .then((value) => _fetchNewsFeedList(value));
  }

//  void _loadFromCache() {
//    // Look up the news from cache, publish it if we have it:
//    _cache
//        .readString(cacheKey)
//        .transform(_newsFeedToModel)
//        .ifPresent(_publishNewsFeed);
//  }

  void _publishNewsFeed(List<NewsFeed> newsFeed) {
    _newsFeed.sendNext(UnmodifiableListView(newsFeed));
    newsFeed.asMap().forEach((index, value) {
      this.publishNewsFeedItems(value.newsFeedItemList);
    });
  }

  static List<NewsFeedItem> _newsFeedToModel(String news) {
    NewsFeed newsFeed =
        serializers.deserializeWith(NewsFeed.serializer, jsonDecode(news));

    return newsFeed.newsFeedItemList
        .map((NewsFeedItem newsFeedItem) => newsFeedItem)
        .toList();
  }

  Future<void> _saveToCache(news) => _cache.writeString(cacheKey, news);

  _fetchNewsFeedList(Profile profile) async {
    try {
      List<String> tags = ['news', 'Cargo', 'dfw', 'Reservations'];
      tags.addAll(profile.topics);
      tags.addAll(profile.workgroup);
      _log.shout(tags);
      List<NewsFeed> feed = (await _apiClient.getNewsFeed(tags));
      _publishNewsFeed(feed);
      return feed;
    } catch (e, s) {
      _log.severe('Failed to fetch news feed: ', e, s);
      return null;
    }
  }

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
