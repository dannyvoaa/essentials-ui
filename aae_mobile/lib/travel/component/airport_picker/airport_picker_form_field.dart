import 'package:aae/model/airport.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/airport_picker/airport_picker_component.dart';
import 'package:flutter/material.dart';

/// A field meant to be used on a form that allows the user to choose
/// an AA serviced airport. Tapping the field will trigger a bottom sheet
/// containing a AirportPickerComponent that will display a filterable list of
/// airports pulled from Sabre.
///
/// The field will not successfully validate if no selection has been made.
class AirportPickerFormField extends StatefulWidget {
  final Function(Airport) onAirportSelected;

  AirportPickerFormField({this.onAirportSelected});

  @override
  State<StatefulWidget> createState() => _AirportPickerFormFieldState();
}

class _AirportPickerFormFieldState extends State<AirportPickerFormField> {
  Airport _selectedAirport;

  final _hintStyle = TextStyle(
    fontSize: 15,
    color: AaeColors.gray,
    fontFamily: 'AmericanSans',
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              color: AaeColors.halfwayLightGray,
            ),
          ),
        ),
        child: Text(_selectedAirport == null ? 'City/airport' : _selectedAirport.code,
          style: _selectedAirport == null ? _hintStyle : AaeTextStyles.subtitle18,
        ),
      ),
      onTap: () => AirportPickerComponent.showAsModalBottomSheet(
        context: context,
        onAirportSelected: (airport) {
          // update our form field with the new value
          this.setState(() {
            _selectedAirport = airport;
          });

          // and notify any listeners of the change
          if (widget.onAirportSelected != null)
            widget.onAirportSelected(airport);
        },
      )
    );
  }
}
