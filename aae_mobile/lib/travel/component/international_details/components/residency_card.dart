import 'package:aae/model/countries.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_card.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_country.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_date.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_editable_text.dart';
import 'package:aae/travel/component/international_details/widgets/international_details_tile_read_only.dart';
import 'package:aae/travel/component/international_details/widgets/visa_and_residency_pill_buttons.dart';
import 'package:flutter/material.dart';

enum DocumentationType { visa, residencyCard }

class ResidencyCard extends StatefulWidget {
  final ReservationDetailPassengerBuilder passenger;
  final Map<String, Country> countries;
  final bool editable;
  final bool isUsCitizen;

  ResidencyCard(this.editable, this.passenger, this.countries, this.isUsCitizen);

  @override
  ResidencyCardState createState() => ResidencyCardState();
}

class ResidencyCardState extends State<ResidencyCard> with TickerProviderStateMixin {
  DocumentationType documentationType;
  bool isUsResident;

  @override
  void initState() {
    // initialize our visa / residency section based on data in the reservation details.
    if (widget.passenger.visa != null &&
        widget.passenger.visa.number != null &&
        widget.passenger.visa.number.isNotEmpty) {

      documentationType = DocumentationType.visa;
    }

    else if (widget.passenger.usResidencyCard != null &&
        widget.passenger.usResidencyCard.number != null &&
        widget.passenger.usResidencyCard.number.isNotEmpty != null) {

      documentationType = DocumentationType.residencyCard;
    }
    else {
      documentationType = DocumentationType.visa;
    }



    isUsResident = widget.passenger.countryOfResidence == "US";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return widget.editable ? _buildEditableContent() : _buildReadOnlyContent();
  }

  void _onVisaPressed() {
    setState(() {
      documentationType = DocumentationType.visa;
    });
  }

  void _onResidencyPressed() {
    setState(() {
      documentationType = DocumentationType.residencyCard;
    });
  }

  // Read Only Content

  Widget _buildReadOnlyContent() {
    return InternationalDetailsCard.listLayout(
      title:  "Residency",
      children: [
        InternationalDetailsTileReadOnly(
          label: "Country of residence",
          value: widget.countries == null ? widget.passenger.countryOfResidence : widget.countries[widget.passenger.countryOfResidence]?.countryName,
        ),
        ..._buildResidencyDocumentation(),
        ..._buildUsDestination(),

      ],
    );
  }

  List<Widget> _buildResidencyDocumentation() {
    if (widget.isUsCitizen)
      return [];
    if (documentationType == DocumentationType.visa)
      return _buildVisaDocumentation();
    else
      return _buildGreenCardDocumentation();
  }

  List<Widget> _buildVisaDocumentation() {
    return [
      InternationalDetailsTileReadOnly(
        label: "US Visa number",
        value: widget.passenger.visa.number,
      ),
      InternationalDetailsTileReadOnly(
        label: "Date of issue",
        value: widget.passenger.visa.issuedDate,
        isDate: true,
      ),
      InternationalDetailsTileReadOnly(
        label: "City of issue",
        value: widget.passenger.visa.issuingCity,
      ),
    ];
  }

  List<Widget> _buildUsDestination() {
    if (widget.isUsCitizen && isUsResident)
      return [];

    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AaeDimens.baseUnit * 2,
              bottom: AaeDimens.baseUnit / 2,
            ),
            child: Text(
              "US destination",
              style: AaeTextStyles.body16Bold.copyWith(
                color: AaeColors.gray,
              ),
            ),
          ),
          InternationalDetailsTileReadOnly(
            label: "US address",
            value: widget.passenger.destination.address,
          ),
        ],
      ),

      InternationalDetailsTileReadOnly(
        label: "US city",
        value: widget.passenger.destination.city,
      ),
      InternationalDetailsTileReadOnly(
        label: "US state",
        value: widget.passenger.destination.state,
      ),
      InternationalDetailsTileReadOnly(
        label: "US zip code",
        value: widget.passenger.destination.zipCode,
      )
    ];
  }

  List<Widget> _buildGreenCardDocumentation() {
    return [
      InternationalDetailsTileReadOnly(
        label: "US Residency Card number",
        value: widget.passenger.usResidencyCard.number,
      ),
      InternationalDetailsTileReadOnly(
        label: "Expiration date",
        value: widget.passenger.usResidencyCard.expirationDate,
        isDate: true,
      ),
    ];
  }

  // Editable Content

  Widget _buildEditableContent() {
    return InternationalDetailsCard.editLayout(
      title: "Residency",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InternationalDetailsTileEditableCountry.textMode(
            label: "Country of residence",
            initialValue: widget.passenger.countryOfResidence,
            onChanged: (newValue) {
              widget.passenger.countryOfResidence = newValue;
              setState(() {
                isUsResident = widget.passenger.countryOfResidence == "US";
              });
            },
            countries: widget.countries,
          ),
          ..._buildPillButtonWidget(),
          AnimatedSize(
            curve: Curves.easeInOut,
            vsync: this,
            duration: Duration(milliseconds: 500),
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: ValueKey<DocumentationType>(documentationType),
                  children: [
                    ..._buildEditableResidencyDocumentation(),
                    ..._buildEditableUsDestination(),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPillButtonWidget() {
    if (widget.isUsCitizen) return [];

    return [
      Padding(
        padding: const EdgeInsets.only(top: AaeDimens.baseUnit),
        child: VisaAndResidencyPillButtons(
          initialSelection: documentationType,
          onVisaPressed: this._onVisaPressed,
          onResidencyPressed: this._onResidencyPressed,
        ),
      ),
    ];
  }

  List<Widget> _buildEditableResidencyDocumentation() {
    if (widget.isUsCitizen)
      return [];
    else if (documentationType == DocumentationType.visa)
      return _buildEditableVisaDocumentation();
    else
      return _buildEditableGreenCardDocumentation();
  }

  List<Widget> _buildEditableVisaDocumentation() {
    return [
      InternationalDetailsTileEditableText(
        label: "US Visa number",
        initialValue: widget.passenger.visa.number,
        onChanged: (newValue) => widget.passenger.visa.number = newValue,
      ),
      InternationalDetailsTileEditableDate.textMode(
        label: "Date of issue",
        initialValue: widget.passenger.visa.issuedDate,
        onChanged: (newValue) => widget.passenger.visa.issuedDate = newValue,
        isFutureDate: false,
      ),
      InternationalDetailsTileEditableText(
        label: "City of issue",
        initialValue: widget.passenger.visa.issuingCity,
        onChanged: (newValue) => widget.passenger.visa.issuingCity = newValue,
      ),
    ];
  }

  List<Widget> _buildEditableGreenCardDocumentation() {
    return [
      InternationalDetailsTileEditableText(
        label: "US Residency Card number",
        initialValue: widget.passenger.usResidencyCard.number,
        onChanged: (newValue) => widget.passenger.usResidencyCard.number = newValue,
        inputType: TextInputType.number,
      ),
      InternationalDetailsTileEditableDate.textMode(
        label: "Expiration date",
        initialValue: widget.passenger.usResidencyCard.expirationDate,
        onChanged: (newValue) => widget.passenger.usResidencyCard.expirationDate = newValue,
        isFutureDate: true,
      ),
    ];
  }

  List<Widget> _buildEditableUsDestination() {
    if (widget.isUsCitizen && isUsResident)
      return [];

    return [
      Padding(
        padding: const EdgeInsets.only(
          top: AaeDimens.baseUnit * 2,
          bottom: AaeDimens.baseUnit / 2,
          left: AaeDimens.baseUnit / 4,
          right: AaeDimens.baseUnit / 4,
        ),
        child: Text(
          "US destination",
          style: AaeTextStyles.body16Bold.copyWith(
            color: AaeColors.gray,
          ),
        ),
      ),
      InternationalDetailsTileEditableText(
        label: "US address",
        initialValue: widget.passenger.destination.address,
        onChanged: (newValue) => widget.passenger.destination.address = newValue,
      ),

      InternationalDetailsTileEditableText(
        label: "US city",
        initialValue: widget.passenger.destination.city,
        onChanged: (newValue) => widget.passenger.destination.city = newValue,
      ),
      Row(
          children: [
            Expanded(
              child: InternationalDetailsTileEditableText(
                label: "US state",
                initialValue: widget.passenger.destination.state,
                onChanged: (newValue) => widget.passenger.destination.state = newValue,
              ),
            ),
            Expanded(
              child: InternationalDetailsTileEditableText(
                label: "US zip code",
                initialValue: widget.passenger.destination.zipCode,
                onChanged: (newValue) => widget.passenger.destination.zipCode = newValue,
                inputType: TextInputType.number,
              ),
            ),
          ]
      ),
    ];
  }
}


