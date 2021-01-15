import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/home/news_feed_top_bar/news_feed_top_bar.dart';
import 'package:aae/home/news_feed_list_collection/news_feed_list_collection_component.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:flutter/material.dart';

class SSKeys {
  final GlobalKey<ScaffoldState> scaffoldKeyH = new GlobalKey<ScaffoldState>(debugLabel: 'scaffoldKeyH');
  final GlobalKey<ScaffoldState> scaffoldKeyE = new GlobalKey<ScaffoldState>(debugLabel: 'scaffoldKeyE');
}

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {

  @override
  Widget build(BuildContext context) {
    SSKeys mykeys = new SSKeys();
    setState(() {});
      return Scaffold(
        key: mykeys.scaffoldKeyH,
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
