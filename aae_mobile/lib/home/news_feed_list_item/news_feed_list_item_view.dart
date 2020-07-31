import 'package:aae/common/widgets/list/list_view_item.dart';
import 'package:flutter/material.dart';

import 'news_feed_list_item_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';

class HtmlTags {
  static String removeTag(String htmlString){
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
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
      String strTitle = HtmlTags.reduceSize(viewModel.displayName, 45);
      String strShortBody = HtmlTags.reduceSize(HtmlTags.removeTag(viewModel.shortBody), 95);
      return ListViewItem.titleAndBody(
        image: CachedNetworkImageProvider(viewModel.image.toString()),
        title: strTitle,
        body: strShortBody,
        author: viewModel.author,
        onTapped: () => viewModel.onTapped(context),
      );
  }
}
