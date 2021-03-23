import 'package:aae/model/airport.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/airport_picker_header.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/airport_tile.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/alphabet_search_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'airport_picker_view_model.dart';

/// The view used for the [AirportPickerComponent].
class AirportPickerView extends StatelessWidget {
  static final _log = Logger('AirportPickerView');

  final AirportPickerViewModel viewModel;
  final ScrollController _scroller = ScrollController();
  final Function(Airport) onAirportSelected;

  AirportPickerView({@required this.viewModel, this.onAirportSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AirportPickerHeader(
          onFilterChanged: viewModel.updateAirportFilter,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  controller: _scroller,
                  itemCount: viewModel.filteredAirports.length,
                  itemBuilder: (context, index) {
                    return AirportTile(
                        airport: viewModel.filteredAirports[index],
                        onClicked: () {
                          if (onAirportSelected != null)
                            onAirportSelected(viewModel.filteredAirports[index]);
                        },
                    );
                  },
                ),
              ),
              AlphabetSearchSidebar(
                viewModel: viewModel,
                onScrollTo: _onScrollTo,
              )
            ],
          ),
        )
      ],
    );
  }

  _onScrollTo(String character) {
    if (viewModel == null || viewModel.charIndexes == null || !viewModel.charIndexes.containsKey(character))
      return;

    int index = viewModel.charIndexes[character];

    // maxScrollExtent value is inconsistent
    // 51 and .000064 are hardcoded values that need to be adjusted if the amount of airports changes by a lot
    double newPosition = index * (51 + (viewModel.filteredAirports.length*.00064));

    //_log.info("scrolling from ${scroller.position}. to $newPosition");
    _scroller.animateTo(newPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
