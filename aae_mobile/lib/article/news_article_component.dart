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
                String strArticleBody = snapshot.value.articleBody;
                return newsArticleScaffoldWidget(
                    context, strAuthor, strArticleId, strArticleBody);
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

  Widget newsArticleScaffoldWidget(BuildContext context, String strAuthor,
      String strArticleId, String strArticleBody) {

    var image = args['articleImage'];

    return Scaffold(
    //  endDrawer: AaeDrawer(),
      appBar: AppBar(
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: <Color>[AaeColors.blue, AaeColors.gradientTop])),
                      ),

                      elevation: 1,
                      leading: new IconButton(
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
                        child: Html(
                          data: args['articleSubject'],
                          style: {
                            "html": Style(
                              color: AaeColors.darkBlue,
                              fontSize: FontSize(24),
                              textAlign: TextAlign.center,
                              margin: EdgeInsets.only(top: 12, bottom: 2, left: 2, right: 2),
                            ),
                          },
                        ),
                      ),
                      Container(
                        child: Center(
//                        child: Text(image),
                          child: Text(strAuthor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Html(
                          data: strArticleBody,
                          onLinkTap: (url) {
                            print("Opening $url...");
                            launch(url);
                          },
                          onImageTap: (src) {
                            print(src);
                          },
                          onImageError: (exception, stackTrace) {
                            print(exception);
                          },
                          customRender: {
                            'img': (renderContext, child, attributes, _) {
                              var imageUrl = attributes['src'];
                              return Container(
                                child: Image(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                            'video': (renderContext, child, attributes, _){
                              return Container(
                                height: 0,
                                child: Text(''),
                              );
                            },
                          },
                          style: {
                            "body": Style(
                              color: AaeColors.titleGray,
                              margin: EdgeInsets.all(16),
                            ),
                            "div.responsive-col": Style(
                              color: AaeColors.titleGray,
                            ),
                            ".ae-headline, .ae-summary, .ae-image": Style(
                              display: Display.BLOCK,
                              height: 0,
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                            ),
                            "p": Style(
                              margin: EdgeInsets.only(top:2, bottom:12),
                            ),
                            "h1, h2, h3, h4, h5": Style(
                              color: AaeColors.blue,
                              fontFamily: AaeTextStyles.font,
                              fontWeight: FontWeight.w100,
                              margin: EdgeInsets.only(bottom:4, top:26),
                            ),
                            "h1": Style(
                              color: AaeColors.blue,
                              fontSize: FontSize(36),
                            ),
                            "h2": Style(
                              color: AaeColors.darkBlue,
                              fontSize: FontSize(26),
                            ),
                            ".blue h2": Style(
                              color: AaeColors.white,
                            ),
                            "h3": Style(
                              color: AaeColors.mediumGray,
                              fontSize: FontSize(24),
                            ),
                            "h4": Style(
                              color: AaeColors.mediumGray,
                              fontSize: FontSize(18),
                            ),
                            "h5": Style(
                              color: AaeColors.titleGray,
                              fontSize: FontSize(16),
                            ),
                            "ul, ol": Style(
                              margin: EdgeInsets.only(top: 12,),
                            ),
                            "li": Style(
//                            color: AaeColors.red,
                              margin: EdgeInsets.only(left: 2, bottom:10),
                            ),
                            ".dark_ul, .dark_ol": Style(
                              color:AaeColors.white,
                            ),
                            ".dark_hr": Style(
                              backgroundColor: AaeColors.white,
                              height: 2,
                            ),
                            ".page_button, .page_button_two, .page_button_dark, .page_button_dark_two": Style(
                                margin:EdgeInsets.only(top:12,bottom:12,)
                            ),
                            "div.page_button": Style(
                              backgroundColor: AaeColors.blue,
                              textAlign: TextAlign.center,
                              height: 40,
                            ),
                            "div.page_button > a": Style(
                              color:AaeColors.white,
                              textAlign: TextAlign.center,
                              width: double.infinity,
                            ),
                            "div.page_button_two": Style(
                              textAlign: TextAlign.center,
                              height: 40,
                            ),
                            ".dark_link > a": Style(
                              color: AaeColors.white,
                            ),
                            ".page_button_dark": Style(
                              backgroundColor: AaeColors.white,
                              textAlign: TextAlign.center,
                              height: 40,
                            ),
                            ".page_button_dark_two": Style(
                              color: AaeColors.white,
                              textAlign: TextAlign.center,
                              height: 40,
                            ),
                            ".page_button_dark_two > a": Style(
                              color:AaeColors.white,
                            ),
                            "table > tr": Style(
                              margin: EdgeInsets.only(bottom:40,),
                            ),
                            ".video":Style(
                              height:0,
                              backgroundColor: AaeColors.red,
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                            ),
                            "iframe": Style(
                              height: 0,
                              backgroundColor: AaeColors.red,
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                            ),
                            "a": Style(
                              textDecoration: TextDecoration.none,
                            ),
                            "img": Style(
                              textDecoration: TextDecoration.none,
                            ),
                            ".hideOnTablet, .hideOnPhone": Style(
                              display: Display.BLOCK,
                              height: 0,
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                            ),
                            "div.blue": Style(
                              padding:EdgeInsets.all(12),
                            ),
                            ".aa_darkblue_bg, .blue": Style(
                              backgroundColor: AaeColors.darkBlue,
                            ),
                            ".aa_darkblue": Style(
                              color: AaeColors.darkBlue,
                            ),
                            ".aa_blue_bg": Style(
                              backgroundColor: AaeColors.blue,
                            ),
                            ".aa_blue": Style(
                              color: AaeColors.blue,
                            ),
                            ".aa_lightblue_bg, .light": Style(
                              backgroundColor: AaeColors.lightBlue,
                            ),
                            ".aa_lightblue": Style(
                              color: AaeColors.lightBlue,
                            ),
                            ".aa_teal_bg": Style(
                              backgroundColor: AaeColors.teal,
                            ),
                            ".aa_teal": Style(
                              color: AaeColors.teal,
                            ),
                            ".aa_ultralightblue_bg": Style(
                              backgroundColor: AaeColors.highlightBlue,
                            ),
                            ".aa_ultralightblue": Style(
                              color: AaeColors.highlightBlue,
                            ),
                            ".aa_green_bg": Style(
                              backgroundColor: AaeColors.green,
                            ),
                            ".aa_green": Style(
                              color: AaeColors.green,
                            ),
                            ".aa_yellow_bg": Style(
                              backgroundColor: AaeColors.yellowGreen,
                            ),
                            ".aa_yellow": Style(
                              color: AaeColors.yellowGreen,
                            ),
                            ".aa_lightorange_bg": Style(
                              backgroundColor: AaeColors.lightOrange,
                            ),
                            ".aa_lightorange": Style(
                              color: AaeColors.lightOrange,
                            ),
                            ".aa_orange_bg": Style(
                              backgroundColor: AaeColors.orange,
                            ),
                            ".aa_orange": Style(
                              color: AaeColors.orange,
                            ),
                            ".aa_red_bg": Style(
                              backgroundColor: AaeColors.red,
                            ),
                            ".aa_red": Style(
                              color: AaeColors.red,
                            ),
                            ".aa_darkred_bg": Style(
                              backgroundColor: AaeColors.darkRed,
                            ),
                            ".aa_darkred": Style(
                              color: AaeColors.darkRed,
                            ),
                            ".aa_black_bg": Style(
                              backgroundColor: AaeColors.black,
                            ),
                            ".aa_black": Style(
                              color: AaeColors.black,
                            ),
                            ".aa_darkgray_bg": Style(
                              backgroundColor: AaeColors.darkGray,
                            ),
                            ".aa_darkgray": Style(
                              color: AaeColors.darkGray,
                            ),
                            ".aa_mediumgray_bg": Style(
                              backgroundColor: AaeColors.mediumGray,
                            ),
                            ".aa_mediumgray": Style(
                              color: AaeColors.mediumGray,
                            ),
                            ".aa_gray_bg": Style(
                              backgroundColor: AaeColors.lightGray,
                            ),
                            ".aa_gray": Style(
                              color: AaeColors.lightGray,
                            ),
                            ".aa_lightgray_bg": Style(
                              backgroundColor: AaeColors.gray,
                            ),
                            ".aa_lightgray": Style(
                              color: AaeColors.gray,
                            ),
//                            ".aa_ultralightgray_bg": Style(
//                              backgroundColor: AaeColors.ultraLightGray,
//                            ),
                            ".aa_ultralightgray": Style(
                              color: AaeColors.ultraLightGray,
                            ),
                          },
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
