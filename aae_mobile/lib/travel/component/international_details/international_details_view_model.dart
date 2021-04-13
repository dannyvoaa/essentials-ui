import 'package:aae/model/countries.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

import 'components/international_details_action_bar.dart';
import 'components/residency_card.dart';

part 'international_details_view_model.g.dart';

/// View model representing a [InternationalDetailsView]
abstract class InternationalDetailsViewModel
    implements Built<InternationalDetailsViewModel, InternationalDetailsViewModelBuilder> {

  /// Details about the current passenger for which the user is trying to check in.
  @nullable ReservationDetailPassenger get passenger;

  /// All countries available for selection in various fields.
  @nullable Map<String, Country> get countries;

  @nullable String get recordLocator;

  /// Within the [reservationDetails], the index of the traveler currently being
  /// viewed / edited.
  @nullable int get currentTravelerIndex;

  @nullable bool get hasMoreTravelers;

  /// Indicates whether the screen is currently editable or not.
  @nullable InternationalDetailsEditMode get mode;

  /// If the traveler is not a US citizen this indicates whether they have provided
  /// US Residency Card information or Visa Information.
  @nullable DocumentationType get chosenDocumentationType;

  /// Locally updates the current reservation in preparation for a future check in request.
  /// Note that this does *not* update the PNR in Sabre or the PNR Summary in ATD. THe user
  /// must complete the check-in flow for any changes to be applied.
  @nullable Function(ReservationDetailPassengerBuilder passengerBuilder) get updatePassenger;

  InternationalDetailsViewModel._();

  factory InternationalDetailsViewModel({
    @required ReservationDetailPassenger passenger,
    @required Map<String, Country> countries,
    @required String recordLocator,
    @required int currentTravelerIndex,
    @required bool hasMoreTravelers,
    @required InternationalDetailsEditMode mode,
    @required DocumentationType chosenDocumentationType,
    @required Function(ReservationDetailPassengerBuilder passengerBuilder) updatePassenger,
  }) = _$InternationalDetailsViewModel._;
}
