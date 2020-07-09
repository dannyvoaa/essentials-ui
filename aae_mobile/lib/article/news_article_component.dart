import 'package:aae/article/news_article_view_model.dart';
import 'package:aae/article/news_article_bloc.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:aae/bloc/source_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';


class NewsArticleComponent extends StatelessWidget {
  final Map<String, String> args;

  NewsArticleComponent({@required Map<String, dynamic> arguments})
      : assert(arguments != null),
        args = arguments;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Component<NewsArticleBloc, NewsArticleBlocFactory>(
        bloc: (factory) {
          return factory.articleBloc();
        },
        builder: (context, bloc) {
          bloc.loadArticle(args['articleId']);
          return SourceBuilder.of<NewsArticleViewModel>(
              source: bloc.viewModel,
              builder: (snapshot) {
                if (snapshot.present) {
                  if (snapshot.value != null) {
                    //NewsArticleViewModel viewModel = snapshot.value;
                    String strAuthor = snapshot.value.author;
                    String strArticleId = snapshot.value.articleID;
                    String strArticleBody = snapshot.value.articleBody;
                    return newsArticleScaffoldWidget(
                        context, strAuthor, strArticleId, strArticleBody);
                  } else {
                    print('**NewsArticleComponent**snapshotValue IS NULL**');
                    return _buildLoadingPageState();
                  }
                } else {
                  print('**NewsArticleComponent**snapshot NOT present**');
                  return _buildLoadingPageState();
                }
              });
        }
    );
  }

  Widget _buildLoadingPageState() {
    return Scaffold(body: Center(child: AaeLoadingSpinner()));
  }

  Widget newsArticleScaffoldWidget(BuildContext context, String strAuthor,
      String strArticleId, String strArticleBody) {
    return Scaffold(
      endDrawer: AaeDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Image.network(
                        args['articleImage'],
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          args['articleSubject'],
                          style: AaeTextStyles.h3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(strAuthor + ' | ' + strArticleId),
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Text(strArticleBody),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
