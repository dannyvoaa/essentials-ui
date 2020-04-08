import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/component/news_feed_top_bar/news_feed_top_bar.dart';
import 'package:aae/home/component/news_list/news_list_collection_component.dart';
import 'package:aae/navigation/page_provider.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO (rpaglinawan): match interface to spec with shadow dithering
      endDrawer: AaeDrawer(),
      appBar: NewsFeedTopBar(),
      body: NewsListCollectionComponent(),
    );
  }
}

class NewsPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => NewsPage();
  }
}
