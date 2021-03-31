import 'package:aae/model/countries.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

import 'international_details_tile_editable.dart';

class InternationalDetailsTileEditableCountry extends StatefulWidget {
  final String label;
  final Country initialValue;
  final Function (Country newValue) onChanged;
  final Map<String, Country> countries;

  InternationalDetailsTileEditableCountry({
    this.label,
    this.initialValue,
    this.onChanged,
    this.countries,
  });

  InternationalDetailsTileEditableCountry.textMode({
    String label,
    Map<String, Country> countries,
    String initialValue,
    Function(String newValue) onChanged,
  }): this(
    label: label,
    initialValue: countries == null ? null : countries[initialValue],
    countries: countries,
    onChanged: (Country newValue) {
      if (onChanged == null) return;

      if (newValue == null)
        onChanged(null);
      else
        onChanged(newValue.countryCode);
    },
  );

  @override
  _InternationalDetailsTileEditableCountryState createState() => _InternationalDetailsTileEditableCountryState();
}

class _InternationalDetailsTileEditableCountryState extends State<InternationalDetailsTileEditableCountry> {
  Country value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.countries == null)
    //   return InternationalDetailsEditableTile.buildTextField();

    return InternationalDetailsTileEditable(
      label: widget.label,
      formField: DropdownButtonFormField<Country>(
        value: value,
        style: AaeTextStyles.body16,
        items: _buildCountryMenuItems(),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: AaeDimens.baseUnit/4),
        ),
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });

          if (widget.onChanged != null) widget.onChanged(newValue);
        },
      ),
    );
  }

  List<DropdownMenuItem<Country>> _buildCountryMenuItems() {
    List<DropdownMenuItem<Country>> items = [];

    List<Country> sortedCountries = widget.countries?.values?.toList() ?? [];
    sortedCountries.sort((Country a, Country b) {
      return a.countryName.compareTo(b.countryName);
    });

    if (widget.countries != null) {
      items.add(_buildMenuItem(widget.countries['US']));
      for (Country currCountry in sortedCountries) {
        if (currCountry.countryCode != 'US')
          items.add(_buildMenuItem(currCountry));
      }
    }


    return items;
  }

  DropdownMenuItem<Country> _buildMenuItem(Country country) {
    return DropdownMenuItem<Country>(
      value: country,
      child: Text(
        country.countryName,
        style: AaeTextStyles.body16,
      ),
    );
  }
}
