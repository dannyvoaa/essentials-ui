import 'package:aae/model/countries.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_card.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_country.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_date.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_text.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_read_only.dart';
import 'package:flutter/material.dart';

class PassportCard extends StatelessWidget {
  final ReservationDetailPassengerBuilder passenger;
  final Map<String, Country> countries;
  final bool editable;

  final Function(String) onCitizenshipChanged;

  PassportCard(this.editable, this.passenger, this.countries, {this.onCitizenshipChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AaeDimens.baseUnit / 2),
      child: editable ? _buildEditableContent() : _buildReadOnlyContent(),
    );
  }

  Widget _buildReadOnlyContent() {
    return InternationalDetailsCard.listLayout(
      title:  "${passenger.firstName} ${passenger.lastName}",
      children: [
        InternationalDetailsTileReadOnly(
          label: "Passport number",
          value: passenger.passport.number,
        ),
        InternationalDetailsTileReadOnly(
          label: "Expiration date",
          value: passenger.passport.expirationDate,
          isDate: true,
        ),
        InternationalDetailsTileReadOnly(
          label: "Country of issue",
          value: countries == null ? passenger.passport.issuingCountry : countries[passenger.passport.issuingCountry]?.countryName,
        ),
        InternationalDetailsTileReadOnly(
          label: "Country of nationality",
          value: countries == null ? passenger.countryOfCitizenship : countries[passenger.countryOfCitizenship]?.countryName,
        ),
      ],
    );
  }

  Widget _buildEditableContent() {
    return InternationalDetailsCard.editLayout(
      title:  "${passenger.firstName} ${passenger.lastName}",
      child: Column(
        children: [
          InternationalDetailsTileEditableText(
            label: "Passport number",
            initialValue: passenger.passport.number,
            onChanged: (newValue) => passenger.passport.number = newValue,
          ),
          InternationalDetailsTileEditableDate.textMode(
            label: "Expiration date",
            initialValue: passenger.passport.expirationDate,
            onChanged: (newValue) => passenger.passport.expirationDate = newValue,
            isFutureDate: true,
          ),
          InternationalDetailsTileEditableCountry.textMode(
            label: "Country of issue",
            initialValue: passenger.passport.issuingCountry,
            onChanged: (newValue) => passenger.passport.issuingCountry = newValue,
            countries: this.countries,
          ),
          InternationalDetailsTileEditableCountry.textMode(
            label: "Country of nationality",
            initialValue: passenger.countryOfCitizenship,
            countries: this.countries,
            onChanged: (newValue) {
              passenger.countryOfCitizenship = newValue;
              this.onCitizenshipChanged(newValue);
            },
          ),
        ],
      ),
    );
  }

}