import 'package:aae/common/commands/aae_command.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:quiver/core.dart';

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

  /// Color of the border of the topic, or absent for no border.
  Optional<Color> get borderColor;

  /// Action to take when the user taps this topic.
  @BuiltValueField(compare: false)
  AaeCommand get onTopicPressed;

  TopicsViewModel._();
  factory TopicsViewModel({
    @required String topic,
    @required Optional<Color> borderColor,
    @required AaeCommand onTopicPressed,
  }) = _$TopicsViewModel._;
}
