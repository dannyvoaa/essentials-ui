import 'package:aae/article/components/article_component_view_model.dart';
import 'package:flutter/material.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/theme/typography.dart';

class NonArticleComponent extends StatelessWidget {
  final ArticleComponentViewModel componentViewModel;
  final Map<String, String> args;

  NonArticleComponent({@required this.componentViewModel, this.args});

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: AaeDrawer(),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              //TODO(rpaglinawan): build a photoview header
              _buildSliverAppBar(),
              //TODO(rpaglinawan): build article view
              _buildArticleBody(),
              //TODO(rpaglinawan): ask AA what else design was thinking of
            ],
          ),
        ),
      );
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      title: Text(
        'News article',
        style: AaeTextStyles.h3,
      ),
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://www.aa.com/content/images/homepage/mobile-hero/en_US/Airplane-1.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildRelatedArticles() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100.0,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            Container(
              width: 100.0,
              child: Center(
                child: Text('placeholder for\n related articles'),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  SliverList _buildArticleBody() {
    return SliverList(
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
              child: Text(
                args['articleSubject'],
                style: AaeTextStyles.h3,
                textAlign: TextAlign.center,
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
            child: Text(componentViewModel.articleBody),
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
    );
  }
}
