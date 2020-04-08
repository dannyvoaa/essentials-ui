import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'settings_buttons_list_view_model.g.dart';

/// View model representing a [SettingsButtonsListView].
///
abstract class SettingsButtonsListViewModel
    implements
        Built<SettingsButtonsListViewModel,
            SettingsButtonsListViewModelBuilder> {
  List<SettingsButton> get buttons;

  SettingsButtonsListViewModel._();

  factory SettingsButtonsListViewModel({
    @required List<SettingsButton> buttons,
  }) = _$SettingsButtonsListViewModel._;
}

abstract class SettingsButton
    implements Built<SettingsButton, SettingsButtonBuilder> {
  String get text;

  IconData get icon;

  AaeContextCommand get route;

  SettingsButton._();

  factory SettingsButton({
    @required String text,
    @required IconData icon,
    @required AaeContextCommand route,
  }) = _$SettingsButton._;
}
