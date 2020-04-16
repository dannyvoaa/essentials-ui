import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view_model.dart';
import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

/// BLoC for the [NewsListItemComponent].
///
/// Exposes a [NewsFeedListItemViewModel] for that component to use.
class NewsListItemBloc {
  final NewsFeedRepository _newsFeedRepository;
  String _articleId;
  String _articleSubject;
  String _articleImageURL;

  ///Publishes the [NewsFeedListItemViewModel] for the given newsFeedItemId.
  Source<NewsFeedListItemViewModel> viewModel(String newsFeedItemId) {
    return toSource(combineLatest(
        _newsFeedRepository.newsFeedItemById(newsFeedItemId), _buildViewModel));
  }

  @provide
  NewsListItemBloc(this._newsFeedRepository);

  NewsFeedListItemViewModel _buildViewModel(NewsFeedItem newsFeedItem) {
    _articleId = newsFeedItem.contentID;
    _articleSubject = newsFeedItem.subject;
    _articleImageURL = newsFeedItem.image.toString();
    return NewsFeedListItemViewModel((b) => b
      ..displayName = newsFeedItem.subject
      ..image = newsFeedItem.image
      ..shortBody = newsFeedItem.body
      ..author = newsFeedItem.author
      ..onTapped = openNewsArticle);
  }

  void openNewsArticle(BuildContext context) {
    debugPrint('hit onTapped in list_item_bloc');
    navigateCommand(
      routes.buildArticlePageRoute(
        article: routes.article,
        parameters: {
          "articleId": _articleId,
          "articleSubject": _articleSubject,
          "articleImage": _articleImageURL
        },
      ),
    )(context);
  }
}

/// Constructs new instances of [NewsListItemBloc]s via the DI framework.
abstract class NewsListItemBlocFactory implements ProvidedService {
  @provide
  NewsListItemBloc newsListItemBloc();
}
