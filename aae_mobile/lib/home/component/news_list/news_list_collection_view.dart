import 'package:flutter/material.dart';

import 'news_list_collection_view_model.dart';
import 'news_list_view.dart';

class NewsListCollectionView extends StatelessWidget {
  final NewsListCollectionViewModel viewModel;

  NewsListCollectionView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildNewsContainer(context),
      ],
    );
  }

  Widget _buildNewsContainer(BuildContext context) {
    return NewsListView(viewModel: viewModel);
  }
}
