import 'package:aae/common/widgets/list/list_view_item.dart';
import 'package:flutter/material.dart';

import 'news_feed_list_item_view_model.dart';

class NewsFeedListItem extends StatelessWidget {
  final NewsFeedListItemViewModel viewModel;

  NewsFeedListItem({@required this.viewModel});

  @override
  Widget build(BuildContext context) =>
      _buildNewsFeedListItemImageProvider(context);

  Widget _buildNewsFeedListItemImageProvider(BuildContext context) =>
      ListViewItem.titleAndBody(
        image: _buildImageProvider(viewModel.image.toString()),
        title: viewModel.displayName,
        body: viewModel.shortBody,
        author: viewModel.author,
        onTapped: () => viewModel.onTapped(context),
      );

  ImageProvider _buildImageProvider(String url) {
    return (url == null)? Image.network(url) : NetworkImage(url.toString());
  }
}
