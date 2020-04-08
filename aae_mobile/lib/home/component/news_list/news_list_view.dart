import 'package:aae/home/component/news_list_row_collection/news_list_row_collection_component.dart';
import 'package:flutter/material.dart';

import 'news_list_collection_view_model.dart';

/// Shows a list of [NewsListCardComponent]s
///
class NewsListView extends StatelessWidget {
  final NewsListCollectionViewModel viewModel;
  NewsListView({@required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return NewsListRowCollectionComponent(index: index);
      },
      itemCount: viewModel.newsFeedCategories.toSet().length,
    ));
  }
}
