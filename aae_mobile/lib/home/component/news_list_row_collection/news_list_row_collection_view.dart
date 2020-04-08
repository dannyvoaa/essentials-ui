import 'package:aae/home/component/news_item/news_list_item_component.dart';
import 'package:flutter/material.dart';

import 'news_list_row_collection_view_model.dart';

class NewsListRowCollectionView extends StatelessWidget {
  final NewsListRowCollectionViewModel viewModel;

  final int index;

  NewsListRowCollectionView({@required this.viewModel, @required this.index});

  @override
  Widget build(BuildContext context) {
    return index == 1 ? _buildVideoRow(viewModel) : _buildRow(viewModel, index);
  }
}

_buildRow(NewsListRowCollectionViewModel viewModel, index) {
  return Container(
    height: 280,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 16),
          child: Text(
            viewModel.newsFeedItemCategories[index],
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF0078D2),
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 248,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.newsFeedItemIds.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: NewsListItemComponent(
                  newsFeedItemId: viewModel.newsFeedItemIds[index],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

_buildVideoRow(NewsListRowCollectionViewModel viewModel) {
  return Container(
    height: 185,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 16),
          child: Text(
            'Video Center',
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF0078D2),
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Color(0xFFD0DAE0),
          height: 145,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.newsFeedItemIds.length,
            itemBuilder: (_, index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.6, right: 7.5, left: 8),
                    child: Container(
                      height: 101,
                      width: 141,
                      child: Image(
                        fit: BoxFit.scaleDown,
                        image: AssetImage('assets/static_records/image.jpeg'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Video Title Goes Here',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
