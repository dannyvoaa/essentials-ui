import 'package:aae/model/priority_list.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;

part 'priority_list_view_model.g.dart';

/// View model representing a [PriorityListView]
abstract class PriorityListViewModel
    implements Built<PriorityListViewModel, PriorityListViewModelBuilder> {
  @nullable
  PriorityList get priorityList;

  void Function(String origin, int flightNum, DateTime date) get loadPriorityList;

  PriorityListViewModel._();

  factory PriorityListViewModel({
    @required PriorityList priorityList,
    @required Function(String origin, int flightNum, DateTime date) loadPriorityList,
  }) = _$PriorityListViewModel._;
}
