import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/model/airport.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'details/airport_picker_bloc.dart';
import 'details/airport_picker_view.dart';
import 'details/airport_picker_view_model.dart';

/// A component that lists all AA serviced airports pulled from Sabre.
/// allowing the user to filter the list and choose an airport, to be
/// returned to a parent component.
class AirportPickerComponent extends StatelessWidget {
  static final _log = Logger('AirportPickerComponent');

  final Function(Airport) onAirportSelected;
  final bool isModal;

  AirportPickerComponent({this.onAirportSelected, this.isModal = false});

  @override
  Widget build(BuildContext context) {
    return Component<AirportPickerBloc, AirportPickerBlocFactory>(
      bloc: (factory) => factory.airportPickerBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<AirportPickerViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            _log.info('airports: ${snapshot.value.filteredAirports?.length}');
            if (snapshot.present && snapshot.value != null && snapshot.value.filteredAirports != null) {
              return AirportPickerView(
                viewModel: snapshot.value,
                onAirportSelected: (airport) {
                  if (isModal)
                    Navigator.maybePop(context);

                  if (onAirportSelected != null)
                    this.onAirportSelected(airport);
                },
              );
            } else {
              return Center(child: AaeLoadingSpinner());
            }
          },        );
      },
    );
  }

  /// Displays the AirportPickerComponent in a modal bottom sheet overlaying
  /// the user interface.
  static showAsModalBottomSheet({
    @required BuildContext context,
    Function(Airport) onAirportSelected,
  }) {
    showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        //barrierColor: Color(0x01000000),
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.95,
          child: Padding(
            padding: EdgeInsets.only(
              // allows the bottom sheet to get out of the keyboard's way
              //bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AirportPickerComponent(
              onAirportSelected: onAirportSelected,
              isModal: true,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16)
          ),
        )
    );
  }
}
