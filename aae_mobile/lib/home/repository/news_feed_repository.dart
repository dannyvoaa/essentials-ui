import 'dart:collection';
import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/news_feed.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/model/serializers.dart';
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

  final _newsFeed = createBehaviorSubject<UnmodifiableListView<NewsFeedItem>>();

  /// All content by their by their news feed item id.
  final _newsFeedItemsByNewsFeedItemId =
      BehaviorSubjectMap<String, NewsFeedItem>();

  /// News feed item by their category
  final _newsFeedItemsByCategory = BehaviorSubjectMap<String, NewsFeedItem>();

  /// Updates the published streams for the [NewsFeedItems]s specified by [updatedNewsFeedItems].
  void publishNewsFeedItems(Iterable<NewsFeedItem> updatedNewsFeedItems) {
    for (var newsFeedItem in updatedNewsFeedItems) {
      _newsFeedItemsByNewsFeedItemId.update(
          newsFeedItem.id.toString(), newsFeedItem);

      /// Ensure that only news feed items are added by their category
      if (newsFeedItem.category == 'Announcements') {
        _newsFeedItemsByCategory.update(newsFeedItem.category, newsFeedItem);
      }
    }
  }

  final NewsServiceApi _apiClient;
  final CacheService _cache;

  /// Publishes the [NewsFeedItem]s
  Observable<UnmodifiableListView<NewsFeedItem>> get newsFeed => _newsFeed;

  /// Publishes a [NewsFeedItem]s by ID.
  Observable<NewsFeedItem> newsFeedItemById(String newsFeedItemId) =>
      _newsFeedItemsByNewsFeedItemId
          .data(newsFeedItemId)
          .distinctUntilChanged();

  /// Publishes a [NewsFeedItem]s by category.
  Observable<NewsFeedItem> newsFeedItemByCategory(String category) =>
      _newsFeedItemsByCategory.data(category).distinctUntilChanged();

  @provide
  @singleton
  NewsFeedRepository(this._apiClient, this._cache) {
    //_loadFromCache();
    _fetchNewsList();
  }

  void _loadFromCache() {
    // Look up the news from cache, publish it if we have it:
    _cache
        .readString(cacheKey)
        .transform(_newsFeedToModel)
        .ifPresent(_publishNewsFeed);
  }

  void _publishNewsFeed(Iterable<NewsFeedItem> newsFeedItems) {
    _newsFeed.sendNext(UnmodifiableListView(newsFeedItems));
    this.publishNewsFeedItems(newsFeedItems);
  }

  static List<NewsFeedItem> _newsFeedToModel(String news) {
    NewsFeed newsFeed =
        serializers.deserializeWith(NewsFeed.serializer, jsonDecode(news));

    return newsFeed.newsFeedItemList
        .map((NewsFeedItem newsFeedItem) => newsFeedItem)
        .toList();
  }

  Future<void> _saveToCache(news) => _cache.writeString(cacheKey, news);

  // TODO: (kiheke) - Switch to api call when service is ready.
  _fetchNewsList() async {
    var feed;
    try {
      NewsFeed feed = (await _apiClient.getNewsFeed());
      _saveToCache(feed.toJson());
      _loadFromCache();
    } catch (e, s) {
      _log.severe('Failed to fetch news feed: ', e, s);
      return null;
    }
    return feed;
  }

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
