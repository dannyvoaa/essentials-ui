import 'package:aae/model/countries.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/travel/component/international_details/components/emergency_contact_card.dart';
import 'package:aae/travel/component/international_details/components/international_details_action_bar.dart';
import 'package:aae/travel/component/international_details/components/passport_card.dart';
import 'package:aae/travel/component/international_details/components/residency_card.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'international_details_component.dart';
import 'international_details_view_model.dart';


/// Manages navigation between a read only and editable view of a passenger's
/// information related to international travel.
class InternationalDetailsView extends StatefulWidget {
  final InternationalDetailsViewModel viewModel;
  final Map<String, Country> countries;
  final Function(BuildContext, String) onCompleted;

  InternationalDetailsView({this.viewModel, this.onCompleted}):
        this.countries = viewModel.countries;

  @override
  _InternationalDetailsViewState createState() => _InternationalDetailsViewState();
}

class _InternationalDetailsViewState
    extends State<InternationalDetailsView>
    with TickerProviderStateMixin {

  static final _log = Logger('InternationalDetailsView');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ReservationDetailPassengerBuilder passenger;
  InternationalDetailsEditMode currentMode = InternationalDetailsEditMode.readOnly;
  bool usCitizen;

  @override
  initState() {
    super.initState();

    _initPassengerData();
  }

  _initPassengerData() {
    passenger = widget.viewModel.passenger.toBuilder();
    usCitizen = passenger.countryOfCitizenship == 'US';
  }

  @override
  Widget build(BuildContext context) {
    bool editable = (currentMode == InternationalDetailsEditMode.editable);
    
    return WillPopScope(
      onWillPop: () async => await _onBackPressed(context),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  PassportCard(editable, passenger, widget.countries,
                    onCitizenshipChanged: this._onCitizenshipChanged,
                  ),
                  EmergencyContactCard(editable, passenger, widget.countries),
                  ResidencyCard(editable, passenger, widget.countries, usCitizen)
                ],
              ),
            ),
          ),
          InternationalDetailsActionBar(
            initialMode: currentMode,
            onContinuePressed: this._onContinuePressed,
            onEditPressed: this._onEditPressed,
            onSavePressed: this._onSavePressed,
          )
        ],
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    if (widget.viewModel.hasMoreTravelers) {
      InternationalDetailsComponent.routeTo(context,
        pnr: widget.viewModel.recordLocator,
        travelerIndex: widget.viewModel.currentTravelerIndex + 1,
      );
    } else {
      _log.info("international details review complete");
      widget.onCompleted(context, widget.viewModel.recordLocator);
    }
  }

  void _onEditPressed(BuildContext context) {
    setState(() {
      currentMode = InternationalDetailsEditMode.editable;
    });
  }

  void _onSavePressed(BuildContext context) {
    _formKey.currentState.save();
    widget.viewModel.updatePassenger(passenger);

    setState(() {
      currentMode = InternationalDetailsEditMode.readOnly;
    });
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (currentMode == InternationalDetailsEditMode.editable) {
      setState(() {
        currentMode = InternationalDetailsEditMode.readOnly;
        _initPassengerData();
      });
      return false;
    }
    return true;
  }

  void _onCitizenshipChanged(String newValue) {
    setState(() {
      usCitizen = (newValue == 'US');
    });
  }
}