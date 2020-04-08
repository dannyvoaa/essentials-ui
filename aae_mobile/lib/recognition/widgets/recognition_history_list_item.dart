//import 'package:aae/recognition/widgets/recognition_history_list_item_view_model.dart';
//import 'package:aae/theme/dimensions.dart';
//import 'package:flutter/material.dart';
//
//class RecognitionHistoryListItem extends StatelessWidget {
//  final RecognitionHistoryListItemViewModel _viewModel;
//
//  RecognitionHistoryListItem(this._viewModel);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//        padding: const EdgeInsetsDirectional.only(
//          top: AaeDimens.baseUnit,
//        ),
//        child: SizedBox(
//          width: AaeDimens.contentWidth,
//          height: AaeDimens.listViewItemHeight,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(_viewModel.date),
//              Row(
//                children: <Widget>[
//                  _buildAvatar(_viewModel.image),
//                  Column(
//                    children: <Widget>[
//                      Text(_viewModel.name),
//                      Text(_viewModel.shortBody),
//                    ],
//                  ),
//                  Text(_viewModel.amount),
//                ],
//              )
//            ],
//          ),
//        ));
//  }
//
//  Widget _buildAvatar(String url) {
//    return Image.network(url);
//  }
//}
