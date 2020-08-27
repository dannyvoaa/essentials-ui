import 'package:aae/home/news_feed_list_item/news_feed_list_item_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'news_feed_list_row_collection_view_model.dart';

class NewsFeedListRowCollectionView extends StatelessWidget {
  final NewsFeedListRowCollectionViewModel viewModel;

  final int index;

  NewsFeedListRowCollectionView({@required this.viewModel, @required this.index});

  @override
  Widget build(BuildContext context) {
    return _buildRow(viewModel, index);
  }
}

_buildRow(NewsFeedListRowCollectionViewModel viewModel, index) {
  return Container(
//    height: 370,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 14),
          child: _buildRowHeader(viewModel, index),
        ),
        Container(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.newsFeedItemIds.length,
            padding: EdgeInsets.only(left:3.0,),
            itemBuilder: (_, index) {
              return Padding(
//                padding: EdgeInsets.symmetric(horizontal: 6),
                padding: EdgeInsets.only(left:6.0),
                child: NewsFeedListItemComponent(
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

_buildVideoRow(NewsFeedListRowCollectionViewModel viewModel) {
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

_buildRowHeader(NewsFeedListRowCollectionViewModel viewModel, index) {
    switch (index) {
      case 0:
        {
          return Text(
            'News',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0078D2),
                fontWeight: FontWeight.bold),
          );
        }
        break;

      default:
        {
          return Text(
            toBeginningOfSentenceCase(viewModel.newsFeedItemCategories[index]),
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0078D2),
                fontWeight: FontWeight.bold),
          );
        }
        break;
    }
}