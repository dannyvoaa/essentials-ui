import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'trips_bloc.dart';
import 'trips_view.dart';
import 'trips_view_model.dart';


/// Ties together [TripsBloc] and [TripsView].
class TripsComponent extends StatelessWidget {

  TripsComponent({this.loadReservationDetail});

  final Function(BuildContext, String) loadReservationDetail;

  @override
  Widget build(BuildContext context) {
    return Component<TripsBloc, TripsBlocFactory>(
      bloc: (factory) => factory.tripsBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<TripsViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              if (snapshot.value == null) {
                return _buildEmptyState(context);
              } else {
                return TripsView(viewModel: snapshot.value);
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
