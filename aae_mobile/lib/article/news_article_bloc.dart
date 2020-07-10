import 'package:aae/article/news_article_view_model.dart';
import 'package:aae/article/news_article_repository.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

class NewsArticleBloc {
  // final String _referenceURL = '';
  static final _log = Logger('NewsArticleBloc');

  final NewsArticleRepository _newsArticleRepository;

  @provide
  NewsArticleBloc(this._newsArticleRepository) {
    //print('**NewsArticleBloc-Constructor**');
  }

  // TODO (rpaglinawan): pass in an observable of the full page article data
  //into viewmodel generator
  Source<NewsArticleViewModel> get viewModel {
    return toSource(combineLatest(_newsArticleRepository.newsArticleObservable, _createViewModel));
  }

  NewsArticleViewModel _createViewModel(NewsArticle article) {
    return NewsArticleViewModel(
            (b) {
                  b..articleID = article.contentID;
                  b..author = article.authorName;
                  b..articleBody = article.contentString.content;
            }
      );

  }

  void loadArticle(String articleId) {
    _newsArticleRepository.loadFullArticle(articleId);
  }

  void stopEmittingEvents() {
    _newsArticleRepository.clear();
  }
}

abstract class NewsArticleBlocFactory implements ProvidedService {
  @provide
  NewsArticleBloc articleBloc();
}
