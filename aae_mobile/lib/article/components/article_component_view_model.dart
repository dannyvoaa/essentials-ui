import 'package:built_value/built_value.dart';

part 'article_component_view_model.g.dart';

abstract class ArticleComponentViewModel
    implements
        Built<ArticleComponentViewModel, ArticleComponentViewModelBuilder> {
  String get articleID;
  String get author;
  String get articleBody;

  //TODO pass hierarcy data to get the important data into the code base

  //TODO (rpaglinawan): implement any other widgets here

  ArticleComponentViewModel._();

  factory ArticleComponentViewModel(
          [updates(ArticleComponentViewModelBuilder b)]) =
      _$ArticleComponentViewModel;
}
