import 'package:aae/model/countries.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_card.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_country.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_text.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_read_only.dart';
import 'package:flutter/material.dart';

class EmergencyContactCard extends StatelessWidget {
  final ReservationDetailPassengerBuilder passenger;
  final Map<String, Country> countries;
  final bool editable;

  EmergencyContactCard(this.editable, this.passenger, this.countries);

  @override
  Widget build(BuildContext context) {
    return editable ? _buildEditableContent() : _buildReadOnlyContent();
  }

  Widget _buildReadOnlyContent() {
    return InternationalDetailsCard.listLayout(
      title:  "Emergency contact",
      children: [
        InternationalDetailsTileReadOnly(
          label: "First name",
          value: passenger.emergencyContact.firstName,
        ),
        InternationalDetailsTileReadOnly(
          label: "Last name",
          value: passenger.emergencyContact.lastName,
        ),
        InternationalDetailsTileReadOnly(
          label: "Country",
          value: countries == null ? passenger.emergencyContact.country : countries[passenger.emergencyContact.country]?.countryName,
        ),
        InternationalDetailsTileReadOnly(
          label: "Phone number",
          value: passenger.emergencyContact.phoneNumber,
        ),
      ],
    );
  }

  Widget _buildEditableContent() {
    return InternationalDetailsCard.editLayout(
      title:  "Emergency contact",
      child: Column(
        children: [
          InternationalDetailsTileEditableText(
            label: "First name",
            initialValue: passenger.emergencyContact.firstName,
            onChanged: (newValue) => passenger.emergencyContact.firstName = newValue,
          ),
          InternationalDetailsTileEditableText(
            label: "Last name",
            initialValue: passenger.emergencyContact.lastName,
            onChanged: (newValue) => passenger.emergencyContact.lastName = newValue,
          ),
          Row(children:[
            Expanded(
              child: InternationalDetailsTileEditableCountry.textMode(
                label: "Country",
                initialValue: passenger.emergencyContact.country,
                onChanged: (newValue) => passenger.emergencyContact.country = newValue,
                countries: this.countries,
              ),
            ),
            Expanded(
              child: InternationalDetailsTileEditableText(
                label: "Phone number",
                initialValue: passenger.emergencyContact.phoneNumber,
                onChanged: (newValue) => passenger.emergencyContact.phoneNumber = newValue,
                inputType: TextInputType.number,
              ),
            ),
          ]
          ),
        ],
      ),
    );
  }

}