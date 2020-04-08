import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'settings_section_view_model.g.dart';

abstract class SettingsSectionViewModel
    implements
        Built<SettingsSectionViewModel, SettingsSectionViewModelBuilder> {
  /// [table] is a set of widgets generated in the BLoC that will add more
  /// fields as needed
  Widget get table;

  /// [onTapped] would be the resulting interaction that would occur when the
  /// user fires of the interaction
  AaeCommand get onTapped;

  SettingsSectionViewModel._();

  factory SettingsSectionViewModel(
          [updates(SettingsSectionViewModelBuilder b)]) =
      _$SettingsSectionViewModel;
}
