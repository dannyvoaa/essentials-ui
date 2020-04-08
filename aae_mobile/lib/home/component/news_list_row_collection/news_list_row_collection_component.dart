import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'news_list_row_collection_bloc.dart';
import 'news_list_row_collection_view.dart';
import 'news_list_row_collection_view_model.dart';

/// Ties together [NewsListRowCollectionBloc] and [NewsListRowCollectionView].
class NewsListRowCollectionComponent extends StatelessWidget {
  final int index;

  NewsListRowCollectionComponent({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Component<NewsListRowCollectionBloc,
        NewsListRowCollectionBlocFactory>(
      bloc: (factory) => factory.newsListRowCollectionBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<NewsListRowCollectionViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return NewsListRowCollectionView(
                  viewModel: snapshot.value,
                  index: index,
                );
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
