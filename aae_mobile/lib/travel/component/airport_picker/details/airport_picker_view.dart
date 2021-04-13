import 'package:aae/model/airport.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/airport_picker_header.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/airport_tile.dart';
import 'package:aae/travel/component/airport_picker/details/widgets/alphabet_search_sidebar.dart';
import 'package:aae/travel/component/airport_picker/scroll_to_index_custom.dart';
import 'package:flutter/material.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:logging/logging.dart';
import 'airport_picker_view_model.dart';

/// The view used for the [AirportPickerComponent].
class AirportPickerView extends StatefulWidget {
  static final _log = Logger('AirportPickerView');

  AirportPickerView(
      {@required this.viewModel, @required this.onAirportSelected});

  final Function(Airport) onAirportSelected;
  final AirportPickerViewModel viewModel;

  @override
  _AirportPickerViewState createState() => _AirportPickerViewState();
}

class _AirportPickerViewState extends State<AirportPickerView> {
//  final ScrollController _scroller = ScrollController();
  final AutoScrollController _scroller = AutoScrollController();
  var controller = IndexedScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AirportPickerHeader(
          onFilterChanged: widget.viewModel.updateAirportFilter,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: IndexedListView.builder(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  controller: controller,
                  itemBuilder: (context, index) {
                    return AirportTile(
                        airport: widget.viewModel.filteredAirports[index],
                        onClicked: () {
                          if (widget.onAirportSelected != null)
                            widget.onAirportSelected(
                                widget.viewModel.filteredAirports[index]);
                        },
                      );
                  },
                ),
              ),
              AlphabetSearchSidebar(
                viewModel: widget.viewModel,
                onScrollTo: _onScrollTo,
              )
            ],
          ),
        )
      ],
    );
  }

  int counter = -1;

  Future _onScrollTo(String character) async {
    int index = widget.viewModel.charIndexes[character];
    setState(() {});
    print(index);

    controller.animateToIndex(index,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

//  Future _onScrollTo(String character) async {
//    int index = widget.viewModel.charIndexes[character];
//    setState(() {
//    });
//
//    _scroller.scrollToIndex(index,
//        duration: Duration(milliseconds: 500),
//        preferPosition: AutoScrollPosition.begin);
//  }

//  old scrollto logic that may be reused later on
//  _onScrollTo(String character) {
//    if (widget.viewModel == null ||
//        widget.viewModel.charIndexes == null ||
//        !widget.viewModel.charIndexes.containsKey(character)) return;
//
//    int index = widget.viewModel.charIndexes[character];
//
//    // maxScrollExtent value is inconsistent
//    double itemSize = (_scroller.position.maxScrollExtent /
//        widget.viewModel.filteredAirports.length);
//    print(_scroller.position.maxScrollExtent);
//    print(widget.viewModel.filteredAirports.length);
//    print(itemSize);
//    print(index);
//
//    double newPosition = index * itemSize;
//
//    //970 : 32 = 30.3125
//    //2030 : 67 = 30.2985
//    // 7395 / 244 = 30.3073
//
//    //_log.info("scrolling from ${scroller.position}. to $newPosition");
//    _scroller.animateTo(
//      newPosition,
//      duration: Duration(milliseconds: 500),
//      curve: Curves.fastOutSlowIn,
//    );
//  }
}
