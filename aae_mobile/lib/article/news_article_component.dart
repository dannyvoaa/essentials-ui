import 'package:aae/article/news_article_view_model.dart';
import 'package:aae/article/news_article_bloc.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aae/bloc/source_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class NewsArticleComponent extends StatelessWidget {
  final Map<String, String> args;

  NewsArticleComponent({@required Map<String, dynamic> arguments})
      : assert(arguments != null),
        args = arguments;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Component<NewsArticleBloc, NewsArticleBlocFactory>(bloc: (factory) {
      return factory.articleBloc();
    }, builder: (context, bloc) {
      bloc.loadArticle(args['articleId']);
      return SourceBuilder.of<NewsArticleViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value != null) {
                //NewsArticleViewModel viewModel = snapshot.value;
                String strAuthor = snapshot.value.author;
                String strArticleId = snapshot.value.articleID;
                String strbody16Reg138 = snapshot.value.articleBody;
                return newsArticleScaffoldWidget(
                    context, strAuthor, strArticleId, strbody16Reg138);
              } else {
                return _buildLoadingPageState();
              }
            } else {
              return _buildLoadingPageState();
            }
          });
    });
  }

  Widget _buildLoadingPageState() {
    return Scaffold(body: Center(child: AaeLoadingSpinner()));
  }

  Widget _buttonArticle(String text){
    return Container(
      width:double.infinity,
      margin: EdgeInsets.only(bottom:12,),
      padding: EdgeInsets.all(14),
//      alignment: Alignment(0.0, 0.0),
      color: AaeColors.blue,
      child: Center(
        child: Container(
          width:double.infinity,
          alignment: Alignment.center,
          child: HtmlWidget(
            text,
            customStylesBuilder: (element) {
              if (element.localName == 'a'){
                return {'color': 'white', 'text-decoration': 'none'};
              }
              return null;
            },
            textStyle: AaeTextStyles.btn14,
          ),
        ),
      )
    );
  }

  Widget _borderBox(String text){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom:12,),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AaeColors.ultraLightGray,
          width:1,
        ),
      ),
      child: HtmlWidget(
        text,
//        customStylesBuilder: (element) {},
        customWidgetBuilder: (element){
          if (element.localName == 'h2'){
            return Text(
              element.innerHtml,
              style: AaeTextStyles.title24DarkBlue140,
            );
          }
          else if (element.localName == 'h3'){
            return Text(
              element.innerHtml,
              style: AaeTextStyles.title22DarkBlue140,
            );
          }
          else if (element.localName == 'h4'){
            return HtmlWidget(
              element.innerHtml,
              textStyle: AaeTextStyles.title20MediumGray140,
            );
          }
          else if (element.className == 'page_button'){
            return _buttonArticle(element.innerHtml);
          }
          return null;
        },
      ),
    );
  }

  Widget newsArticleScaffoldWidget(BuildContext context, String strAuthor,
      String strArticleId, String strbody16Reg138) {

    var image = args['articleImage'];

    final String titleFormat = (args['articleSubject'].replaceAll(new RegExp(r'\\'),''));

    return Scaffold(
    //  endDrawer: AaeDrawer(),
      appBar: AppBar(
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: <Color>[AaeColors.blue, AaeColors.lightBlue])),
                      ),

                      elevation: 1,
                      leading: new IconButton(padding: EdgeInsets.only(left: 1),
                        icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
      body: SafeArea(
        child: MediaQuery(
          data: MediaQueryData(textScaleFactor: 1.0),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child:  Text(titleFormat, style: TextStyle(color: AaeColors.darkBlue,height: 1.2,fontSize: 24)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 0.0),
                        child: Text(strAuthor, textAlign: TextAlign.start,),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
//child: Text(strbody16Reg138),
                        child: HtmlWidget(
                          strbody16Reg138,
                          customStylesBuilder: (element) {
                            if (element.classes.contains('ae-image')) {
                              return {'display': 'none'};
                            }
                            else if (element.classes.contains('ae-headline')){
                              return {'display': 'none'};
                            }
                            else if (element.classes.contains('ae-summary')){
                              return {'display': 'none'};
                            }
                            else if (element.classes.contains('video')){
                              return {'display': 'none'};
                            }
                            else if (element.classes.contains('page_button')){
                              return {'width': '100%', 'background-color': '$AaeColors.blue'};
                            }
                            else if (element.localName == 'h3'){
                              return {'color': '#6E8999', 'font-size': '24px', 'font-family': AaeTextStyles.fontLight, 'font-weight': '$FontWeight.normal'};
                            }
//                            else if (element.localName == 'h4'){
//                              return {'color': '#6E8999', 'font-size': '24px', 'font-family': AaeTextStyles.title20MediumGray140, 'font-weight': '$FontWeight.normal'};
//                            }
                            else if (element.className == 'two-col-one'){
                              return{'margin': '0px 0px 0px 0px'};
                            }
                            else if (element.className == 'aa_ultralightgray'){
                              return{'color': '$AaeColors.ultraLightGray'};
                            }
                            else if (element.localName == 'li'){
                              return{'margin': '0px 0px 10px 0px'};
                            }
                            else if (element.localName == 'ul'){
                              return{'margin': '10px 0px 10px 0px'};
                            }
                            else if (element.className == 'ae-signature'){
                              return{'width': '40%'};
                            }
                            else if (element.localName == 'table'){
                              return{'font-size': '12px'};
                            }
                            else if (element.localName == 'td'){
                              return{'padding': '6px'};
                            }
                            else if (element.localName == 'div'){
                              return{'width': '100%'};
                            }
                            else if (element.className == 'aa_darkblue'){
                              return{'color': '$AaeColors.darkBlue'};
                            }
                            else if (element.className == 'aa_blue_bg'){
                              return{'backgroundColor': '$AaeColors.blue'};
                            }
                            else if (element.className == 'aa_blue'){
                              return{'color': '$AaeColors.blue'};
                            }
                            else if (element.className == 'aa_lightblue_bg, .light'){
                              return{'backgroundColor': '$AaeColors.lightBlue'};
                            }
                            else if (element.className == 'aa_lightblue'){
                              return{'color': '$AaeColors.lightBlue'};
                            }
                            else if (element.className == 'aa_teal_bg'){
                              return{'backgroundColor': '$AaeColors.teal'};
                            }
                            else if (element.className == 'aa_teal'){
                              return{'color': '$AaeColors.teal'};
                            }
                            else if (element.className == 'aa_ultralightblue_bg'){
                              return{'backgroundColor': '$AaeColors.highlightBlue'};
                            }
                            else if (element.className == 'aa_ultralightblue'){
                              return{'color': '$AaeColors.highlightBlue'};
                            }
                            else if (element.className == 'aa_green_bg'){
                              return{'backgroundColor': '$AaeColors.green'};
                            }
                            else if (element.className == 'aa_green'){
                              return{'color': '$AaeColors.green'};
                            }
                            else if (element.className == 'aa_yellow_bg'){
                              return{'backgroundColor': '$AaeColors.yellowGreen'};
                            }
                            else if (element.className == 'aa_yellow'){
                              return{'color': '$AaeColors.yellowGreen'};
                            }
                            else if (element.className == 'aa_lightorange_bg'){
                              return{'backgroundColor': '$AaeColors.lightOrange'};
                            }
                            else if (element.className == 'aa_lightorange'){
                              return{'color': '$AaeColors.lightOrange'};
                            }
                            else if (element.className == 'aa_orange_bg'){
                              return{'backgroundColor': '$AaeColors.orange'};
                            }
                            else if (element.className == 'aa_orange'){
                              return{'color': '$AaeColors.orange'};
                            }
                            else if (element.className == 'aa_red_bg'){
                              return{'backgroundColor': '$AaeColors.red'};
                            }
                            else if (element.className == 'aa_red'){
                              return{'color': '$AaeColors.red'};
                            }
                            else if (element.className == 'aa_darkred_bg'){
                              return{'backgroundColor': '$AaeColors.darkRed'};
                            }
                            else if (element.className == 'aa_darkred'){
                              return{'color': '$AaeColors.darkRed'};
                            }
                            else if (element.className == 'aa_black_bg'){
                              return{'backgroundColor': '$AaeColors.black'};
                            }
                            else if (element.className == 'aa_black'){
                              return{'color': '$AaeColors.black'};
                            }
                            else if (element.className == 'aa_darkgray_bg'){
                              return{'backgroundColor': '$AaeColors.darkGray'};
                            }
                            else if (element.className == 'aa_darkgray'){
                              return{'color': '$AaeColors.darkGray'};
                            }
                            else if (element.className == 'aa_mediumgray_bg'){
                              return{'backgroundColor': '$AaeColors.mediumGray'};
                            }
                            else if (element.className == 'aa_mediumgray'){
                              return{'color': '$AaeColors.mediumGray'};
                            }
                            else if (element.className == 'aa_gray_bg'){
                              return{'backgroundColor': '$AaeColors.lightGray'};
                            }
                            else if (element.className == 'aa_gray'){
                              return{'color': '$AaeColors.lightGray'};
                            }
                            else if (element.className == 'aa_lightgray_bg'){
                              return{'backgroundColor': '$AaeColors.gray'};
                            }
                            else if (element.className == 'aa_lightgray'){
                              return{'color': '$AaeColors.gray'};
                            }
                            else if (element.className == 'aa_ultralightgray_bg'){
                              return{'backgroundColor': '$AaeColors.ultraLightGray'};
                            }
                            else if (element.className == 'aa_ultralightgray'){
                              return{'color': '$AaeColors.ultraLightGray'};
                            }
                            return null;
                          },
                          customWidgetBuilder: (element){
                            if (element.className == 'ae-highlight-box'){
                              return _borderBox(element.innerHtml);
                            }
                            else if (element.className == 'page_button'){
                              return _buttonArticle(element.innerHtml);
                            }
                            else if (element.classes.contains('page_button')){
                              return _buttonArticle(element.innerHtml);
                            }
                            else if (element.localName == 'h2'){
                              return Text(
                                element.innerHtml,
                                style: AaeTextStyles.title24DarkBlue140,
                              );
                            }
                            else if (element.localName == 'h3'){
                              return Text(
                                element.innerHtml,
                                style: AaeTextStyles.title22DarkBlue140,
                              );
                            }
                            else if (element.localName == 'h4'){
                              return HtmlWidget(
                                element.innerHtml,
                                textStyle: AaeTextStyles.title20MediumGray140,
                              );
                            }
                            return null;
                          },
                          textStyle: AaeTextStyles.body16Reg138,
                          webView: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
