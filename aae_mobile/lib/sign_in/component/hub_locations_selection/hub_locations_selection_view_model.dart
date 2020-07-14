import 'package:aae/common/commands/aae_command.dart';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

part 'hub_locations_selection_view_model.g.dart';

/// View model representing a [HubLocationsSelectionView].
///
abstract class HubLocationsSelectionViewModel
    implements
        Built<HubLocationsSelectionViewModel, HubLocationsSelectionViewModelBuilder> {
  /// All of the topics to show on the page.
  BuiltList<HubLocationsViewModel> get hubLocations;

  /// Next button enabled state.
  bool get nextButtonEnabled;

  HubLocationsSelectionViewModel._();
  factory HubLocationsSelectionViewModel({
    @required BuiltList<HubLocationsViewModel> hubLocations,
    @required bool nextButtonEnabled,
  }) = _$HubLocationsSelectionViewModel._;
}

abstract class HubLocationsViewModel implements Built<HubLocationsViewModel, HubLocationsViewModelBuilder> {
  String get hubLocation;

  /// Action to take when the user selects this hubLocation.
  AaeCommand get onHubLocationPressed;

  bool get isSelected;

  HubLocationsViewModel._();
  factory HubLocationsViewModel({
    @required String hubLocation,
    @required AaeCommand onHubLocationPressed,
    @required bool isSelected,
  }) = _$HubLocationsViewModel._;
}
