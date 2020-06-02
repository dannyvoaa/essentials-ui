import 'package:aae/article/components/article_component_view_model.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:aae/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class NewsArticleComponent extends StatelessWidget {
  final ArticleComponentViewModel componentViewModel;
  final Map<String, String> args;

  NewsArticleComponent({@required this.componentViewModel, this.args});

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: AaeDrawer(),
        appBar: GradientAppBar(
          gradient: AaeColors.appBarGradient,
        ),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              //TODO(rpaglinawan): build article view
              _buildArticleBody(),
              //TODO(rpaglinawan): ask AA what else design was thinking of
              // _buildRelatedArticle(),
            ],
          ),
        ),
      );

  Widget _buildArticleBody() {
    return SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Expanded(
              //TODO: (rpaglinawan): swap out placeholder for article title and image from JIVE
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
                child: Html(
                  data: args['articleSubject'],
                  padding: EdgeInsets.all(18.0),
                  defaultTextStyle: AaeTextStyles.h4,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                    '${componentViewModel.author} | ${componentViewModel.articleID}'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              //TODO (rpaglinawan): fix overflow
              child: Html(
                data: componentViewModel.articleBody,
                padding: EdgeInsets.all(8.0),
              ),
            ),
            Container(
              width: 100.0,
              height: 200.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Text('Placeholder for related article carousel'),
                  Placeholder(
                    strokeWidth: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedArticle() => SliverToBoxAdapter(
        child: Container(
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 100.0,
                child: Card(
                  child: Text('data'),
                ),
              );
            },
          ),
        ),
      );
}
