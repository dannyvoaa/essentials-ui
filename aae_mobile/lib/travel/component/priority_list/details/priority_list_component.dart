import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/priority_list/details/priority_list_view.dart';
import 'package:aae/travel/component/priority_list/details/priority_list_view_model.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';

import 'priority_list_bloc.dart';

class PriorityListArguments {
  final String origin;
  final int flightNumber;
  final DateTime departureDate;

  PriorityListArguments(
      {@required this.origin,
      @required this.flightNumber,
      @required this.departureDate});
}

/// Ties together [PriorityListBloc] and [PriorityListView].
class PriorityListComponent extends StatelessWidget {
  final String origin;
  final int flightNumber;
  final DateTime departureDate;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  PriorityListComponent(
      {@required this.origin,
      @required this.flightNumber,
      @required this.departureDate});

  PriorityListComponent.from(PriorityListArguments args)
      : this.origin = args.origin,
        this.flightNumber = args.flightNumber,
        this.departureDate = args.departureDate;

  @override
  Widget build(BuildContext context) {
    return Component<PriorityListBloc, PriorityListBlocFactory>(
      bloc: (factory) => factory.priorityListBloc(),
      builder: (context, bloc) {
        // initiate our back end call
        bloc.loadPriorityList(origin, flightNumber, departureDate);

        // and build our view
        return SourceBuilder.of<PriorityListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.priorityList != null &&
                snapshot.value.priorityList.destinationAirportCode != null) {
              return PriorityListView(viewModel: snapshot.value);
            } else if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.priorityList == null) {
              return Center(child: AaeLoadingSpinner());
            } else {
              travelSnackBar.showSnackBar(
                  context,
                  'No results were found. Please try again.',
                  AaeColors.orange,
                  true);
              return Center(child: AaeLoadingSpinner());
            }
          },
        );
      },
    );
  }
}
