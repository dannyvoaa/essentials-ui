import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/travel/component/ui/travel_snack_bar.dart';
import 'package:flutter/material.dart';
import 'flight_status_bloc.dart';
import 'flight_status_view.dart';
import 'flight_status_view_model.dart';

class FlightStatusArguments {
  final String origin;
  final String flightNumber;
  final String date;

  FlightStatusArguments(
      {@required this.origin,
      @required this.flightNumber,
      @required this.date});
}

/// Ties together [FlightStatusBloc] and [FlightStatusView].
class FlightStatusComponent extends StatelessWidget {
  final String flightNumber;
  final String origin;
  final String date;
  final TravelSnackBar travelSnackBar = new TravelSnackBar();

  FlightStatusComponent({this.flightNumber, this.origin, this.date});

  FlightStatusComponent.from(FlightStatusArguments args):
        this.origin = args.origin,
        this.flightNumber = args.flightNumber,
        this.date = args.date;
  @override
  Widget build(BuildContext context) {
    return Component<FlightStatusBloc, FlightStatusBlocFactory>(
      bloc: (factory) => factory.flightStatusBloc(),
      builder: (context, bloc) {
        bloc.loadFlightStatus(this.flightNumber, this.origin, this.date);
        return SourceBuilder.of<FlightStatusViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightStatus != null &&
                snapshot.value.flightStatus.flightNumber != null) {
              return FlightStatusView(viewModel: snapshot.value);
            } else if (snapshot.present &&
                snapshot.value != null &&
                snapshot.value.flightStatus == null) {
              return _buildLoadingState(context);
            } else {
              travelSnackBar.showSnackBar(
                  context,
                  'No results were found. Please try again.',
                  AaeColors.darkRed,
                  true);
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
