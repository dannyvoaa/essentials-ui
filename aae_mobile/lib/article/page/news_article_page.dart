import 'package:aae/article/bloc/article_bloc.dart';
import 'package:aae/article/components/article_component_view_model.dart';
import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/article/components/article_component_view_nonspec.dart';
import 'package:aae/article/components/article_component_view_spec.dart';

class NewsArticlePage extends StatelessWidget {
  final Map<String, dynamic> _arguments;

  NewsArticlePage({@required Map<String, dynamic> arguments})
      : assert(arguments != null),
        _arguments = arguments;

  @override
  Widget build(BuildContext context) {
    debugPrint(_parseArgument(_arguments));
    //TODO (rpaglinawan) implement builder for this component
    return buildSpecNewsArticleComponent();
  }

  Widget buildSpecNewsArticleComponent() {
    return Component<NewsArticleBloc, NewsArticleBlocFactory>(
        bloc: (factory) => factory.articleBloc(),
        builder: (context, bloc) => SourceBuilder.of<ArticleComponentViewModel>(
            source: bloc.viewModel,
            builder: (snapshot) {
              bloc.loadArticle(_arguments['articleId']);
              if (snapshot.present) {
                if (snapshot.value != null){
                  return NewsArticleComponent(componentViewModel: snapshot.value, args: _arguments);
                } else {
                  return _buildLoadingPageState();
                }
              } else {
                return _buildLoadingPageState();
              }
            }));
  }

  Widget _buildLoadingPageState() {
    return Scaffold(
        body: Center(
      child: AaeLoadingSpinner(),
    ));
  }

  String _parseArgument(Map<String, dynamic> argument) => argument['articleId'];
}

class NewsArticlePageProvider implements PageProvider {
  final Map<String, dynamic> _arguments;

  NewsArticlePageProvider({@required Map<String, dynamic> arguments})
      : _arguments = arguments;

  @override
  providePageBuilder(BuildContext context) => (context) {
        return NewsArticlePage(
          arguments: _arguments,
        );
      };
}
