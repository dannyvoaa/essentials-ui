import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'news_list_collection_bloc.dart';
import 'news_list_collection_view.dart';
import 'news_list_collection_view_model.dart';

/// Ties together [NewsListCollectionBloc] and [NewsListCollectionView].
class NewsListCollectionComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<NewsListCollectionBloc, NewsListCollectionBlocFactory>(
      bloc: (factory) => factory.newsListCollectionBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<NewsListCollectionViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return NewsListCollectionView(viewModel: snapshot.value);
              }
            } else {
              return _buildLoadingState(context);
            }
          },
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(child: AaeLoadingSpinner());
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'Empty',
      ),
    );
  }
}
