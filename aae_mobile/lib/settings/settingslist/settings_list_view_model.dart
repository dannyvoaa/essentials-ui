import 'package:aae/common/commands/aae_command.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'settings_list_view_model.g.dart';

/// View model representing a [SettingsListView].
///
abstract class SettingsListViewModel
    implements Built<SettingsListViewModel, SettingsListViewModelBuilder> {
  /// The currently signed in users name.
  String get displayName;

  /// The currently signed in users location.
  String get userlocation;

  /// The current topics for this user
  @nullable
  BuiltList<String> get selectedWorkgroups;

  /// The currently signed in users workgroup.
  @nullable
  List<String> get workgroup;

  /// The topic tapped
  AaeValueCommand<String> get onWorkgroupTapped;

  /// The current topics for this user
  @nullable
  BuiltList<String> get selectedHubLocations;

  /// The currently signed in users workgroup.
  @nullable
  List<String> get hubLocation;

  /// The topic tapped
  AaeValueCommand<String> get onHubLocationTapped;

  /// The current topics for this user
  @nullable
  BuiltList<String> get selectedTopics;

  /// The list of available topics
  List<String> get topics;

  /// The topic tapped
  AaeValueCommand<String> get onTopicTapped;

  SettingsListViewModel._();

  factory SettingsListViewModel({
    @required String displayName,
    @required String userlocation,
    @required List<String> workgroup,
    @required BuiltList<String> selectedWorkgroups,
    @required AaeValueCommand<String> onWorkgroupTapped,
    @required List<String> hubLocation,
    @required BuiltList<String> selectedHubLocations,
    @required AaeValueCommand<String> onHubLocationTapped,
    @required BuiltList<String> selectedTopics,
    @required List<String> topics,
    @required AaeValueCommand<String> onTopicTapped,
  }) = _$SettingsListViewModel._;
}
