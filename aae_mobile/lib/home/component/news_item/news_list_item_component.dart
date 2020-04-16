import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view.dart';
import 'package:aae/home/component/news_feed_list_item/news_feed_list_item_view_model.dart';
import 'package:aae/home/component/news_item/news_list_item_bloc.dart';
import 'package:flutter/material.dart';

/// [Component] that shows a visual representation of a given [NewsListItem] in a
/// list item form.
///
/// Ties together a [NewsListItemBloc] and [NewsFeedListItem].
class NewsListItemComponent extends StatelessWidget {
  final String newsFeedItemId;

  NewsListItemComponent({
    @required this.newsFeedItemId,
  });

  @override
  Widget build(BuildContext context) {
    return Component<NewsListItemBloc, NewsListItemBlocFactory>(
      bloc: (factory) => factory.newsListItemBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<NewsFeedListItemViewModel>(
          source: bloc.viewModel(newsFeedItemId),
          builder: (snapshot) => NewsFeedListItem(viewModel: snapshot.value),
        );
      },
    );
  }
}
