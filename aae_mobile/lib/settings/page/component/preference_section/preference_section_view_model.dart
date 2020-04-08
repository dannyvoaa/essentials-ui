import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'preference_section_view_model.g.dart';

/// [PreferenceSectionViewModel] is the stores the data for ehat the user's
/// would visually see on screen
abstract class PreferenceSectionViewModel
    implements
        Built<PreferenceSectionViewModel, PreferenceSectionViewModelBuilder> {
  /// [table] is a set of widgets generated in the BLoC that will add more
  /// fields as needed
  Widget get table;

  /// [onTapped] would be the resulting interaction that would occur when the
  /// user fires of the interaction
  AaeCommand get onTapped;

  PreferenceSectionViewModel._();
  factory PreferenceSectionViewModel(
          [updates(PreferenceSectionViewModelBuilder b)]) =
      _$PreferenceSectionViewModel;
}
