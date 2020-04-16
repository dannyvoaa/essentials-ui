import 'package:aae/model/event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'events_list_view_model.g.dart';

/// View model representing a [EventsListView].
abstract class EventsListViewModel
    implements Built<EventsListViewModel, EventsListViewModelBuilder> {
  /// The Events of each individual item to show in the collection widget.
  List<Event> get events;

  DateTime get observingDate;

  //AaeCommand get onEventSelected;

  //Color get categoryColor;

  EventsListViewModel._();

  factory EventsListViewModel([updates(EventsListViewModelBuilder b)]) =
      _$EventsListViewModel;
}
