import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view_model.dart';
import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/routes.dart' as routes;

/// BLoC for the [NewsListItemComponent].
///
/// Exposes a [NewsFeedListItemViewModel] for that component to use.
class NewsListItemBloc {
  final NewsFeedRepository _newsFeedRepository;

  String _itemId;

  ///Publishes the [NewsFeedListItemViewModel] for the given newsFeedItemId.
  Source<NewsFeedListItemViewModel> viewModel(String newsFeedItemId) {
    _itemId = newsFeedItemId;
    return toSource(combineLatest(
      _newsFeedRepository.newsFeedItemById(newsFeedItemId),
      _buildViewModel,
    ));
  }

  @provide
  NewsListItemBloc(this._newsFeedRepository);

  NewsFeedListItemViewModel _buildViewModel(NewsFeedItem newsFeedItem) {
    return NewsFeedListItemViewModel((b) => b
      ..displayName = newsFeedItem.title
      ..image = newsFeedItem.image
      ..shortBody = newsFeedItem.description
      ..author = newsFeedItem.author.name
      ..itemId = newsFeedItem.id
      ..onTapped = openNewsArticle);
  }

  void openNewsArticle(BuildContext context) =>
      navigateCommand(routes.buildArticlePageRoute(article: _itemId))(context);
}

/// Constructs new instances of [NewsListItemBloc]s via the DI framework.
abstract class NewsListItemBlocFactory implements ProvidedService {
  @provide
  NewsListItemBloc newsListItemBloc();
}
