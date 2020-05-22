import 'package:aae/article/components/article_component_view_model.dart';
import 'package:aae/article/repository/article_repository.dart';
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
  NewsArticleBloc(this._newsArticleRepository);

  // TODO (rpaglinawan): pass in an observable of the full page article data
  //into viewmodel generator
  Source<ArticleComponentViewModel> get viewModel => toSource(combineLatest(
      _newsArticleRepository.newsArticle.first(), _createViewModel));

  ArticleComponentViewModel _createViewModel(NewsArticle article) =>
      ArticleComponentViewModel((b) => b
        ..articleID = article.contentID
        ..author = article.authorName
        ..articleBody = article.contentString.content);

  void loadArticle(String articleId) {
    print("Article ID");
    print(articleId);
    _newsArticleRepository.loadFullArticle(articleId);
  }
}

abstract class NewsArticleBlocFactory implements ProvidedService {
  @provide
  NewsArticleBloc articleBloc();
}


