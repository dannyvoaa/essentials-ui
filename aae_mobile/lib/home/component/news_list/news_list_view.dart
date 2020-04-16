import 'package:aae/home/component/news_list_row_collection/news_list_row_collection_view.dart';
import 'package:flutter/material.dart';

import 'news_list_collection_view_model.dart';

/// Shows a list of [NewsListRowCollectionComponent]s
///
class NewsListView extends StatelessWidget {
  final NewsListCollectionViewModel viewModel;

  NewsListView({@required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return NewsListRowCollectionView(
          viewModel: viewModel.newsListRowCollectionViewModels[index],
          index: index,
        );
      },
      itemCount: viewModel.newsFeedCategories.length,
    ));
  }
}
