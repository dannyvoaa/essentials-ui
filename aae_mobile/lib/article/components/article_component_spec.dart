import 'package:flutter/material.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/theme/typography.dart';

class ArticleComponent extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: AaeDrawer(),
        appBar: AppBar(),
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
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      title: Text('News article'),
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://www.aa.com/content/images/homepage/mobile-hero/en_US/Airplane-1.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildArticleBody() {
    return SliverPadding(
      padding: const EdgeInsets.all(0.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Expanded(
              child: Image.network(
                'https://www.aa.com/content/images/homepage/mobile-hero/en_US/Airplane-1.png',
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
                  'Article Title Goes Here',
                  style: AaeTextStyles.h3,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text('Employee Name | 07/02/2019'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              //TODO (rpaglinawan): fix overflow
              child: Text(
                  'Lorem ipsum dolor sit amet, ne menandri honestatis sea, has euismod'
                  ' assueverit ne, ex vis quis viderer consectetuer. Alii utroque '
                  'definiebas vis at, quo no quando aliquam eruditi. Ne inermis moderatius '
                  'mei. Duo cu purto doctus impetus, ad sea debitis interesset quaerendum. '
                  'At option evertitur sea.\n\n'
                  'Sea an diam persecuti dissentias. Vix paulo aliquid suavitate ea, labores '
                  'iracundia mei cu. Purto appellantur ius no, at sint nihil pericula mei. '
                  'Sed gloriatur scripserit voluptatibus ei. Cu scaevola lobortis atomorum nec, '
                  'ad nam putent audire, te bonorum explicari vel.\n\n'
                  'Sea nihil doming recteque ad. Vim te impetus persequeris. Graecis atomorum '
                  'dissentiet ei pro, odio audire ad pro. Qui cu fierent iracundia adipiscing, '
                  'ea lucilius elaboraret dissentias pro, maiorum mediocrem omittantur et his. '
                  'Eos simul affert labore an, ius no euismod mediocrem. Ut animal definitionem '
                  'qui. Illud graeco ne quo.\n\n'
                  'Pri alienum scaevola ut. At sumo mollis eum, id melius molestie rationibus '
                  'pro, te prima veniam splendide est. Vel id noster aperiri salutandi, vulputate'
                  ' posidonium ne nec. Brute vocent rationibus ad mea. Ut fuisset fastidii '
                  'incorrupte duo. Nullam dicunt cu his, eu soleat equidem posidonium cum. '
                  'Eos no eros errem suscipiantur, eu omnis prompta percipit eam, dicit semper '
                  'fierent eum ex.\n\n'
                  'Persius eripuit ad quo, eu eam ignota utamur, te mea nobis omittam. Quo '
                  'in iisque aperiri perpetua. Vix id quidam conceptam, ius an mundi debitis '
                  'volumus. Mea ut utinam tamquam, mea delicata assueverit cu, dolore adipisci '
                  'ne sed. Facer eligendi oportere id sea. Pri ut diam vidisse invidunt. Vidit '
                  'autem nusquam eu mei, an per falli legimus volutpat.'),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: CustomScrollView(
  //       slivers: <Widget>[
  //         SliverPadding(
  //           padding: EdgeInsets.all(16.0),
  //           sliver: SliverList(
  //             delegate: SliverChildListDelegate(
  //               [
  //                 Card(
  //                   child: Text('data'),
  //                 ),
  //                 Card(
  //                   child: Text('data'),
  //                 ),
  //                 Card(
  //                   child: Text('data'),
  //                 ),
  //                 Card(
  //                   child: Text('data'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SliverToBoxAdapter(
  //           child: Container(
  //             height: 100.0,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: 10,
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                   width: 100.0,
  //                   child: Card(
  //                     child: Text('data'),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
