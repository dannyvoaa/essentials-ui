// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_list_view_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EventsListViewModel extends EventsListViewModel {
  @override
  final BuiltList<Event> events;

  factory _$EventsListViewModel(
          [void Function(EventsListViewModelBuilder) updates]) =>
      (new EventsListViewModelBuilder()..update(updates)).build();

  _$EventsListViewModel._({this.events}) : super._() {
    if (events == null) {
      throw new BuiltValueNullFieldError('EventsListViewModel', 'events');
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
    return other is EventsListViewModel && events == other.events;
  }

  @override
  int get hashCode {
    return $jf($jc(0, events.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EventsListViewModel')
          ..add('events', events))
        .toString();
  }
}

class EventsListViewModelBuilder
    implements Builder<EventsListViewModel, EventsListViewModelBuilder> {
  _$EventsListViewModel _$v;

  ListBuilder<Event> _events;
  ListBuilder<Event> get events => _$this._events ??= new ListBuilder<Event>();
  set events(ListBuilder<Event> events) => _$this._events = events;

  EventsListViewModelBuilder();

  EventsListViewModelBuilder get _$this {
    if (_$v != null) {
      _events = _$v.events?.toBuilder();
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
    _$EventsListViewModel _$result;
    try {
      _$result = _$v ?? new _$EventsListViewModel._(events: events.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EventsListViewModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
