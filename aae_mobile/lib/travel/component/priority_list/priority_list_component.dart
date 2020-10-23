import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import '../trips/trips_bloc.dart';
import '../trips/trips_view.dart';
import '../trips/trips_view_model.dart';
import 'priority_list_bloc.dart';
import 'priority_list_view.dart';
import 'priority_list_view_model.dart';

/// Ties together [PriorityListBloc] and [PriorityListView].
class PriorityListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<PriorityListBloc, PriorityListBlocFactory>(
      bloc: (factory) => factory.priorityListBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<PriorityListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return PriorityListView(viewModel: snapshot.value);
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
