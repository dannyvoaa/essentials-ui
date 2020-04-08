import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'workgroups_selection_bloc.dart';
import 'workgroups_selection_view.dart';
import 'workgroups_selection_view_model.dart';

/// Allows the user to select the applicable workgroup.
///
/// Ties together [WorkgroupsSelectionBloc] and [WorkgroupsSelectionView].
class WorkgroupsSelectionComponent extends StatelessWidget {
  WorkgroupsSelectionComponent();

  @override
  Widget build(BuildContext context) {
    return Component<WorkgroupsSelectionBloc, WorkgroupsSelectionBlocFactory>(
      bloc: (factory) => factory.workgroupsSelectionBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<WorkgroupsSelectionViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return WorkgroupsSelectionView(
                viewModel: snapshot.value,
              );
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
}
