import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'points_balance_bloc.dart';
import 'points_balance_view.dart';
import 'points_balance_view_model.dart';

/// Ties together [PointsBalanceBloc] and [PointsBalanceView].
class PointsBalanceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<PointsBalanceBloc, PointsBalanceBlocFactory>(
      bloc: (factory) => factory.pointsBalanceBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<PointsBalanceViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return PointsBalanceView(viewModel: snapshot.value);
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
