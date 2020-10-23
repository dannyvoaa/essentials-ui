import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'priority_list_view_model.g.dart';

/// View model representing a [PriorityListView]
abstract class PriorityListViewModel
    implements Built<PriorityListViewModel, PriorityListViewModelBuilder> {

  PriorityList get priorityList;

  PriorityListViewModel._();

  factory PriorityListViewModel([updates(PriorityListViewModelBuilder b)]) = _$PriorityListViewModel;
}
