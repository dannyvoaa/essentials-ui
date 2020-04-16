import 'package:aae/common/commands/aae_command.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'topics_selection_view_model.g.dart';

/// View model representing a [TopicsSelectionView].
///
abstract class TopicsSelectionViewModel
    implements
        Built<TopicsSelectionViewModel, TopicsSelectionViewModelBuilder> {
  /// All of the topics to show on the page.
  BuiltList<TopicsViewModel> get topics;

  bool get nextButtonEnabled;

  TopicsSelectionViewModel._();
  factory TopicsSelectionViewModel({
    @required BuiltList<TopicsViewModel> topics,
    @required bool nextButtonEnabled,
  }) = _$TopicsSelectionViewModel._;
}

abstract class TopicsViewModel
    implements Built<TopicsViewModel, TopicsViewModelBuilder> {
  String get topic;

  /// Action to take when the user selects this topic.
  AaeCommand get onTopicPressed;

  bool get isSelected;

  TopicsViewModel._();
  factory TopicsViewModel({
    @required String topic,
    @required AaeCommand onTopicPressed,
    @required bool isSelected,
  }) = _$TopicsViewModel._;
}
