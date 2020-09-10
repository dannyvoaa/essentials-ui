import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'top_bar_title_view_model.g.dart';

/// View model representing a [TopBarTitleView].
abstract class TopBarTitleViewModel implements Built<TopBarTitleViewModel, TopBarTitleViewModelBuilder> {
  String get displayName;

  TopBarTitleViewModel._();

  factory TopBarTitleViewModel({@required String displayName,}) = _$TopBarTitleViewModel._;
}
