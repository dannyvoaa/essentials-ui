import 'package:flutter/material.dart';
import 'package:aae/home/news_feed_list_row_collection/news_feed_list_row_collection_view.dart';
import 'news_feed_list_collection_view_model.dart';

class NewsFeedListCollectionView extends StatelessWidget {
  final NewsFeedListCollectionViewModel viewModel;

  NewsFeedListCollectionView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: viewModel.newsFeedCategories.length,
          itemBuilder: (BuildContext context, int myindex) {
            return NewsFeedListRowCollectionView(
                viewModel:
                    viewModel.newsFeedListRowCollectionViewModels[myindex],
                index: myindex);
          },
        ))
      ],
    );
  }
}
