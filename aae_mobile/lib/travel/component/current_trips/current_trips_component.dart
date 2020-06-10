import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'current_trips_bloc.dart';
import 'current_trips_view.dart';
import 'current_trips_view_model.dart';

/// Ties together [CurrentTripsBloc] and [CurrentTripsView].
class CurrentTripsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<CurrentTripsBloc, CurrentTripsBlocFactory>(
      bloc: (factory) => factory.currentTripsBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<CurrentTripsViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return CurrentTripsView(viewModel: snapshot.value);
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
