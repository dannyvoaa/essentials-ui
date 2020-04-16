// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_list_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EventsListViewModel extends EventsListViewModel {
  @override
  final List<Event> events;
  @override
  final DateTime observingDate;

  factory _$EventsListViewModel(
          [void Function(EventsListViewModelBuilder) updates]) =>
      (new EventsListViewModelBuilder()..update(updates)).build();

  _$EventsListViewModel._({this.events, this.observingDate}) : super._() {
    if (events == null) {
      throw new BuiltValueNullFieldError('EventsListViewModel', 'events');
    }
    if (observingDate == null) {
      throw new BuiltValueNullFieldError(
          'EventsListViewModel', 'observingDate');
    }
  }

  @override
  EventsListViewModel rebuild(
          void Function(EventsListViewModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventsListViewModelBuilder toBuilder() =>
      new EventsListViewModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventsListViewModel &&
        events == other.events &&
        observingDate == other.observingDate;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, events.hashCode), observingDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EventsListViewModel')
          ..add('events', events)
          ..add('observingDate', observingDate))
        .toString();
  }
}

class EventsListViewModelBuilder
    implements Builder<EventsListViewModel, EventsListViewModelBuilder> {
  _$EventsListViewModel _$v;

  List<Event> _events;
  List<Event> get events => _$this._events;
  set events(List<Event> events) => _$this._events = events;

  DateTime _observingDate;
  DateTime get observingDate => _$this._observingDate;
  set observingDate(DateTime observingDate) =>
      _$this._observingDate = observingDate;

  EventsListViewModelBuilder();

  EventsListViewModelBuilder get _$this {
    if (_$v != null) {
      _events = _$v.events;
      _observingDate = _$v.observingDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventsListViewModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EventsListViewModel;
  }

  @override
  void update(void Function(EventsListViewModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EventsListViewModel build() {
    final _$result = _$v ??
        new _$EventsListViewModel._(
            events: events, observingDate: observingDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
