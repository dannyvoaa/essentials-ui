import 'package:aae/model/event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'events_list_view_model.g.dart';

/// View model representing a [EventsListView].
abstract class EventsListViewModel
    implements Built<EventsListViewModel, EventsListViewModelBuilder> {
  /// [data] would return a list of events from the data base
  BuiltList<Event> get events;

  // /// [dayId] would set and organize a set of [Event]s to the id associated with
  // ///  the dayId
  // String get dayId;

  // /// [eventId] would be unique
  // String get eventId;

  //AaeCommand get onEventSelected;

  //Color get categoryColor;

  EventsListViewModel._();

  factory EventsListViewModel([updates(EventsListViewModelBuilder b)]) =
      _$EventsListViewModel;
}
