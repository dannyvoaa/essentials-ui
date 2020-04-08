import 'package:inject/inject.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'dart:convert';

class ArticleBloc {
  final String _referenceURL;

  @provide
  ArticleBloc(this._referenceURL);

  //TODO (rpaglinawan): Fill out these details as more information is locked
  void loadFullArticle() {}
}

abstract class ArticleBlocFactory implements ProvidedService {
  @provide
  ArticleBloc _articleBloc();
}
