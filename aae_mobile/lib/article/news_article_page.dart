import 'package:flutter/material.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/article/news_article_component.dart';

class NewsArticlePage extends StatelessWidget {
  final Map<String, dynamic> _arguments;

  NewsArticlePage({@required Map<String, dynamic> arguments})
      : assert(arguments != null), _arguments = arguments {
    //print('1***Inside-NewsArticlePage-Constructor***');
  }

  @override
  Widget build(BuildContext context) {
    //print('2***Inside-NewsArticlePage-Build***');
    return NewsArticleComponent(arguments: _arguments);
  }

}

class NewsArticlePageProvider implements PageProvider {
  final Map<String, dynamic> _arguments;

  NewsArticlePageProvider({@required Map<String, dynamic> arguments}) : _arguments = arguments;

  @override
  WidgetBuilder providePageBuilder(BuildContext context) => (context) => NewsArticlePage(arguments: _arguments);
}
