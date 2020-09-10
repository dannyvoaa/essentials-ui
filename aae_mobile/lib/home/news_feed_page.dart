import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/news_feed_top_bar/news_feed_top_bar.dart';
import 'package:aae/home/news_feed_list_collection/news_feed_list_collection_component.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:flutter/material.dart';

class NewsFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AaeDrawer(),
      appBar: NewsFeedTopBar(),
      body: NewsFeedListCollectionComponent(),
    );
  }
}

class NewsFeedPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => NewsFeedPage();
  }
}
