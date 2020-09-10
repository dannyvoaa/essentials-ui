import 'package:aae/common/widgets/list/list_view_item.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;
import 'news_feed_list_item_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';

class HtmlUtils {
  static String removeTag(String htmlString){
    var document = parse(htmlString, encoding: 'UTF-8');
    String parsedString = document.body.text;
    return parsedString;
  }

  static String decodeMessage(String strmessage) {
    var decoded = utf8.decode(strmessage.runes.toList());
    return decoded;
  }
  static String reduceSize(String strText, int intLength){
    if (strText.length >= intLength) {
      strText = strText.substring(0, (intLength - 1));
      if (strText.contains(" ")) {
        strText = strText.substring(0, strText.lastIndexOf(" ")) + "...";
      } else {
        strText = strText + "...";
      }
    }
    return strText;
  }
}

class NewsFeedListItemView extends StatelessWidget {
  final NewsFeedListItemViewModel viewModel;

  NewsFeedListItemView({@required this.viewModel});

  @override
  Widget build(BuildContext context) => _buildNewsFeedListItemImageProvider(context);

  Widget _buildNewsFeedListItemImageProvider(BuildContext context) {
      String strTitle = HtmlUtils.reduceSize(viewModel.displayName.trim(), 50);
      strTitle = HtmlUtils.decodeMessage(strTitle);
      String strShortBody = HtmlUtils.reduceSize(viewModel.shortBody.trim(), 78);
      strShortBody = HtmlUtils.decodeMessage(strShortBody);
      return ListViewItem.titleAndBody(
        image: CachedNetworkImageProvider(viewModel.image.toString()),
        title: strTitle,
        body: strShortBody,
        author: viewModel.author,
        onTapped: () => viewModel.onTapped(context),
      );
  }
}
