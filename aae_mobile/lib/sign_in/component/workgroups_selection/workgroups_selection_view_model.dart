import 'package:aae/common/commands/aae_command.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

part 'workgroups_selection_view_model.g.dart';

/// View model representing a [WorkgroupsSelectionView].
abstract class WorkgroupsSelectionViewModel implements Built<WorkgroupsSelectionViewModel, WorkgroupsSelectionViewModelBuilder> {
  /// All of the topics to show on the page.
  BuiltList<WorkgroupsViewModel> get workgroups;

  /// Next button enabled state.
  bool get nextButtonEnabled;

  WorkgroupsSelectionViewModel._();
  factory WorkgroupsSelectionViewModel({@required bool nextButtonEnabled, @required BuiltList<WorkgroupsViewModel> workgroups,}) = _$WorkgroupsSelectionViewModel._;}

abstract class WorkgroupsViewModel implements Built<WorkgroupsViewModel, WorkgroupsViewModelBuilder> {
  String get workgroup;
  Optional<Color> get borderColor;
  /// Action to take when the user selects this workgroup.
  AaeCommand get onWorkgroupPressed;
  bool get isSelected;

  WorkgroupsViewModel._();
  factory WorkgroupsViewModel({
    @required String workgroup,
    @required Optional<Color> borderColor,
    @required AaeCommand onWorkgroupPressed,
    @required bool isSelected,
  }) = _$WorkgroupsViewModel._;
}
