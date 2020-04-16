import 'package:aae/api/api_client.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

class NewsArticleRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('NewsArticleRepository'));

  static const cacheKey = 'NewsArticleRepository.News';

  final _article = createBehaviorSubject<NewsArticle>();
  Observable<NewsArticle> get onSelectedArticle => _article;

  final NewsServiceApi _apiClient;

  final _newsArticleSubject = createBehaviorSubject<NewsArticle>()
    ..distinctUntilChanged();

  Observable<NewsArticle> get newsArticle => _newsArticleSubject;

  //TODO (rpaglinawan): Fill out these details as more information is locked
  void loadFullArticle(String id) async {
    try {
      NewsArticle data = await _apiClient.getArticleData(articleId: id);
      _log.shout('${data.runtimeType}');
      publishNewsArticle(data);
    } catch (e, s) {
      _log.severe('Failed to fetch article: ', e, s);
      return null;
    }
  }

  void publishNewsArticle(NewsArticle newsArticle) {
    _newsArticleSubject
      ..sendNext(newsArticle)
      ..sendCompleted();
  }

  @provide
  @singleton
  NewsArticleRepository(this._apiClient);

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
