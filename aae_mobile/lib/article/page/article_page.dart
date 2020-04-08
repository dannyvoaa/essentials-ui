import 'package:flutter/material.dart';
import 'package:aae/navigation/page_provider.dart';
import 'package:aae/article/components/article_component_nonspec.dart';
import 'package:aae/article/components/article_component_spec.dart';

class ArticlePage extends StatelessWidget {
  final buildToSpec = true;

  @override
  Widget build(BuildContext context) =>
      buildToSpec ? ArticleComponent() : NonArticleComponent();
}

class ArticlePageProvider implements PageProvider {
  @override
  providePageBuilder(BuildContext context) => (context) => ArticlePage();
}
