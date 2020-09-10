import 'package:built_value/built_value.dart';

part 'news_article_view_model.g.dart';

abstract class NewsArticleViewModel implements Built<NewsArticleViewModel, NewsArticleViewModelBuilder> {
  String get articleID;
  String get author;
  String get articleBody;

  NewsArticleViewModel._();

  factory NewsArticleViewModel([updates(NewsArticleViewModelBuilder b)]) = _$NewsArticleViewModel;
}
