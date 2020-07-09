import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/home/news_feed_list_item/news_feed_list_item_view.dart';
import 'package:aae/home/news_feed_list_item/news_feed_list_item_view_model.dart';
import 'package:aae/home/news_feed_list_item/news_feed_list_item_bloc.dart';
import 'package:flutter/material.dart';

/// [Component] that shows a visual representation of a given [NewsFeedListItem] in a
/// list item form.
///
/// Ties together a [NewsFeedListItemBloc] and [NewsFeedListItem].
class NewsFeedListItemComponent extends StatelessWidget {
  final String newsFeedItemId;

  NewsFeedListItemComponent({
    @required this.newsFeedItemId,
  });

  @override
  Widget build(BuildContext context) {
    return Component<NewsFeedListItemBloc, NewsFeedListItemBlocFactory>(
      bloc: (factory) => factory.newsFeedListItemBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<NewsFeedListItemViewModel>(
          source: bloc.viewModel(newsFeedItemId),
          builder: (snapshot) => NewsFeedListItemView(viewModel: snapshot.value),
        );
      },
    );
  }
}
