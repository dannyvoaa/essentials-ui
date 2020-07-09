import 'package:aae/api/api_client.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:aae/cache/cache_service.dart';

class NewsArticleRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('NewsArticleRepository'));
  static const cacheKey = 'NewsArticleRepository.News';

  final NewsServiceApi _apiClient;
  CacheService _cache;

  @provide
  @singleton
  NewsArticleRepository(this._apiClient);

  //final _newsArticleBehaviorSubject2 = createBehaviorSubject<NewsArticle>()..takeLast(1);


  final _newsArticleBehaviorSubject = callCreateNewsArticleSubject();

  static callCreateNewsArticleSubject() {
    return createBehaviorSubject<NewsArticle>()..distinctUntilChanged();
  }


  Observable<NewsArticle> get newsArticleObservable {
    return _newsArticleBehaviorSubject;
  }


  void loadFullArticle(String id) async {
    try {
      //_cache.writeString('newsArticleId', id);
      NewsArticle data = await _apiClient.getArticleData(articleId: id);
      //_cache.writeString('newsArticleId', id);
      _newsArticleBehaviorSubject.sendNext(data); /// Emits the [data] event to this observer.
    } catch (e, s) {
      _log.info('Failed to fetch article: ', e, s);
      return null;
    }
  }


  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void stop() {
    // TODO: implement stop
  }
}
