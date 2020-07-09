import 'package:aae/common/widgets/list/list_view_item.dart';
import 'package:flutter/material.dart';

import 'news_feed_list_item_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class NewsFeedListItemView extends StatelessWidget {
  final NewsFeedListItemViewModel viewModel;

  NewsFeedListItemView({@required this.viewModel});

  @override
  Widget build(BuildContext context) =>
      _buildNewsFeedListItemImageProvider(context);

  Widget _buildNewsFeedListItemImageProvider(BuildContext context) =>
      ListViewItem.titleAndBody(
        image: CachedNetworkImageProvider(viewModel.image.toString()),
        title: viewModel.displayName,
        body: viewModel.shortBody,
        author: viewModel.author,
        onTapped: () => viewModel.onTapped(context),
      );
}
