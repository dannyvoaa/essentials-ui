// GENERATED CODE - DO NOT MODIFY BY HAND

part of event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Event> _$eventSerializer = new _$EventSerializer();

class _$EventSerializer implements StructuredSerializer<Event> {
  @override
  final Iterable<Type> types = const [Event, _$Event];
  @override
  final String wireName = 'Event';

  @override
  Iterable<Object> serialize(Serializers serializers, Event object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      '_id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'allDay',
      serializers.serialize(object.allDay, specifiedType: const FullType(bool)),
      'contactEmail',
      serializers.serialize(object.contactEmail,
          specifiedType: const FullType(String)),
      'contactName',
      serializers.serialize(object.contactName,
          specifiedType: const FullType(String)),
      'contactPhone',
      serializers.serialize(object.contactPhone,
          specifiedType: const FullType(String)),
      'ebrg',
      serializers.serialize(object.ebrg, specifiedType: const FullType(bool)),
      'end',
      serializers.serialize(object.end, specifiedType: const FullType(int)),
      'endYear',
      serializers.serialize(object.endYear, specifiedType: const FullType(int)),
      'endMonth',
      serializers.serialize(object.endMonth,
          specifiedType: const FullType(int)),
      'endDay',
      serializers.serialize(object.endDay, specifiedType: const FullType(int)),
      'endHour',
      serializers.serialize(object.endHour, specifiedType: const FullType(int)),
      'endMinute',
      serializers.serialize(object.endMinute,
          specifiedType: const FullType(int)),
      'eventDescription',
      serializers.serialize(object.eventDescription,
          specifiedType: const FullType(String)),
      'eventName',
      serializers.serialize(object.eventName,
          specifiedType: const FullType(String)),
      'locationAddress1',
      serializers.serialize(object.locationAddress1,
          specifiedType: const FullType(String)),
      'locationAddress2',
      serializers.serialize(object.locationAddress2,
          specifiedType: const FullType(String)),
      'locationCity',
      serializers.serialize(object.locationCity,
          specifiedType: const FullType(String)),
      'locationState',
      serializers.serialize(object.locationState,
          specifiedType: const FullType(String)),
      'locationRoomNumber',
      serializers.serialize(object.locationRoomNumber,
          specifiedType: const FullType(String)),
      'locationVenue',
      serializers.serialize(object.locationVenue,
          specifiedType: const FullType(String)),
      'start',
      serializers.serialize(object.start, specifiedType: const FullType(int)),
      'startYear',
      serializers.serialize(object.startYear,
          specifiedType: const FullType(int)),
      'startMonth',
      serializers.serialize(object.startMonth,
          specifiedType: const FullType(int)),
      'startDay',
      serializers.serialize(object.startDay,
          specifiedType: const FullType(int)),
      'startHour',
      serializers.serialize(object.startHour,
          specifiedType: const FullType(int)),
      'startMinute',
      serializers.serialize(object.startMinute,
          specifiedType: const FullType(int)),
      'timeZoneOffset',
      serializers.serialize(object.timeZoneOffset,
          specifiedType: const FullType(int)),
      'created',
      serializers.serialize(object.created, specifiedType: const FullType(int)),
      'createdBy',
      serializers.serialize(object.createdBy,
          specifiedType: const FullType(String)),
      'updated',
      serializers.serialize(object.updated, specifiedType: const FullType(int)),
    ];
    if (object.rev != null) {
      result
        ..add('rev')
        ..add(serializers.serialize(object.rev,
            specifiedType: const FullType(String)));
    }
    if (object.endLocal != null) {
      result
        ..add('endLocal')
        ..add(serializers.serialize(object.endLocal,
            specifiedType: const FullType(int)));
    }
    if (object.startLocal != null) {
      result
        ..add('startLocal')
        ..add(serializers.serialize(object.startLocal,
            specifiedType: const FullType(int)));
    }
    if (object.updatedBy != null) {
      result
        ..add('updatedBy')
        ..add(serializers.serialize(object.updatedBy,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Event deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case '_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rev':
          result.rev = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'allDay':
          result.allDay = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'contactEmail':
          result.contactEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contactName':
          result.contactName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contactPhone':
          result.contactPhone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ebrg':
          result.ebrg = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'end':
          result.end = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endLocal':
          result.endLocal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endYear':
          result.endYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endMonth':
          result.endMonth = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endDay':
          result.endDay = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endHour':
          result.endHour = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'endMinute':
          result.endMinute = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'eventDescription':
          result.eventDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventName':
          result.eventName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationAddress1':
          result.locationAddress1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationAddress2':
          result.locationAddress2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationCity':
          result.locationCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationState':
          result.locationState = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationRoomNumber':
          result.locationRoomNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationVenue':
          result.locationVenue = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'start':
          result.start = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startLocal':
          result.startLocal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startYear':
          result.startYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startMonth':
          result.startMonth = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startDay':
          result.startDay = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startHour':
          result.startHour = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'startMinute':
          result.startMinute = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timeZoneOffset':
          result.timeZoneOffset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'createdBy':
          result.createdBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated':
          result.updated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updatedBy':
          result.updatedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Event extends Event {
  @override
  final String id;
  @override
  final String rev;
  @override
  final bool allDay;
  @override
  final String contactEmail;
  @override
  final String contactName;
  @override
  final String contactPhone;
  @override
  final bool ebrg;
  @override
  final int end;
  @override
  final int endLocal;
  @override
  final int endYear;
  @override
  final int endMonth;
  @override
  final int endDay;
  @override
  final int endHour;
  @override
  final int endMinute;
  @override
  final String eventDescription;
  @override
  final String eventName;
  @override
  final String locationAddress1;
  @override
  final String locationAddress2;
  @override
  final String locationCity;
  @override
  final String locationState;
  @override
  final String locationRoomNumber;
  @override
  final String locationVenue;
  @override
  final int start;
  @override
  final int startLocal;
  @override
  final int startYear;
  @override
  final int startMonth;
  @override
  final int startDay;
  @override
  final int startHour;
  @override
  final int startMinute;
  @override
  final int timeZoneOffset;
  @override
  final int created;
  @override
  final String createdBy;
  @override
  final int updated;
  @override
  final String updatedBy;

  factory _$Event([void Function(EventBuilder) updates]) =>
      (new EventBuilder()..update(updates)).build();

  _$Event._(
      {this.id,
      this.rev,
      this.allDay,
      this.contactEmail,
      this.contactName,
      this.contactPhone,
      this.ebrg,
      this.end,
      this.endLocal,
      this.endYear,
      this.endMonth,
      this.endDay,
      this.endHour,
      this.endMinute,
      this.eventDescription,
      this.eventName,
      this.locationAddress1,
      this.locationAddress2,
      this.locationCity,
      this.locationState,
      this.locationRoomNumber,
      this.locationVenue,
      this.start,
      this.startLocal,
      this.startYear,
      this.startMonth,
      this.startDay,
      this.startHour,
      this.startMinute,
      this.timeZoneOffset,
      this.created,
      this.createdBy,
      this.updated,
      this.updatedBy})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Event', 'id');
    }
    if (allDay == null) {
      throw new BuiltValueNullFieldError('Event', 'allDay');
    }
    if (contactEmail == null) {
      throw new BuiltValueNullFieldError('Event', 'contactEmail');
    }
    if (contactName == null) {
      throw new BuiltValueNullFieldError('Event', 'contactName');
    }
    if (contactPhone == null) {
      throw new BuiltValueNullFieldError('Event', 'contactPhone');
    }
    if (ebrg == null) {
      throw new BuiltValueNullFieldError('Event', 'ebrg');
    }
    if (end == null) {
      throw new BuiltValueNullFieldError('Event', 'end');
    }
    if (endYear == null) {
      throw new BuiltValueNullFieldError('Event', 'endYear');
    }
    if (endMonth == null) {
      throw new BuiltValueNullFieldError('Event', 'endMonth');
    }
    if (endDay == null) {
      throw new BuiltValueNullFieldError('Event', 'endDay');
    }
    if (endHour == null) {
      throw new BuiltValueNullFieldError('Event', 'endHour');
    }
    if (endMinute == null) {
      throw new BuiltValueNullFieldError('Event', 'endMinute');
    }
    if (eventDescription == null) {
      throw new BuiltValueNullFieldError('Event', 'eventDescription');
    }
    if (eventName == null) {
      throw new BuiltValueNullFieldError('Event', 'eventName');
    }
    if (locationAddress1 == null) {
      throw new BuiltValueNullFieldError('Event', 'locationAddress1');
    }
    if (locationAddress2 == null) {
      throw new BuiltValueNullFieldError('Event', 'locationAddress2');
    }
    if (locationCity == null) {
      throw new BuiltValueNullFieldError('Event', 'locationCity');
    }
    if (locationState == null) {
      throw new BuiltValueNullFieldError('Event', 'locationState');
    }
    if (locationRoomNumber == null) {
      throw new BuiltValueNullFieldError('Event', 'locationRoomNumber');
    }
    if (locationVenue == null) {
      throw new BuiltValueNullFieldError('Event', 'locationVenue');
    }
    if (start == null) {
      throw new BuiltValueNullFieldError('Event', 'start');
    }
    if (startYear == null) {
      throw new BuiltValueNullFieldError('Event', 'startYear');
    }
    if (startMonth == null) {
      throw new BuiltValueNullFieldError('Event', 'startMonth');
    }
    if (startDay == null) {
      throw new BuiltValueNullFieldError('Event', 'startDay');
    }
    if (startHour == null) {
      throw new BuiltValueNullFieldError('Event', 'startHour');
    }
    if (startMinute == null) {
      throw new BuiltValueNullFieldError('Event', 'startMinute');
    }
    if (timeZoneOffset == null) {
      throw new BuiltValueNullFieldError('Event', 'timeZoneOffset');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('Event', 'created');
    }
    if (createdBy == null) {
      throw new BuiltValueNullFieldError('Event', 'createdBy');
    }
    if (updated == null) {
      throw new BuiltValueNullFieldError('Event', 'updated');
    }
  }

  @override
  Event rebuild(void Function(EventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventBuilder toBuilder() => new EventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        rev == other.rev &&
        allDay == other.allDay &&
        contactEmail == other.contactEmail &&
        contactName == other.contactName &&
        contactPhone == other.contactPhone &&
        ebrg == other.ebrg &&
        end == other.end &&
        endLocal == other.endLocal &&
        endYear == other.endYear &&
        endMonth == other.endMonth &&
        endDay == other.endDay &&
        endHour == other.endHour &&
        endMinute == other.endMinute &&
        eventDescription == other.eventDescription &&
        eventName == other.eventName &&
        locationAddress1 == other.locationAddress1 &&
        locationAddress2 == other.locationAddress2 &&
        locationCity == other.locationCity &&
        locationState == other.locationState &&
        locationRoomNumber == other.locationRoomNumber &&
        locationVenue == other.locationVenue &&
        start == other.start &&
        startLocal == other.startLocal &&
        startYear == other.startYear &&
        startMonth == other.startMonth &&
        startDay == other.startDay &&
        startHour == other.startHour &&
        startMinute == other.startMinute &&
        timeZoneOffset == other.timeZoneOffset &&
        created == other.created &&
        createdBy == other.createdBy &&
        updated == other.updated &&
        updatedBy == other.updatedBy;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), rev.hashCode), allDay.hashCode), contactEmail.hashCode), contactName.hashCode), contactPhone.hashCode), ebrg.hashCode), end.hashCode), endLocal.hashCode), endYear.hashCode), endMonth.hashCode), endDay.hashCode), endHour.hashCode), endMinute.hashCode), eventDescription.hashCode),
                                                                                eventName.hashCode),
                                                                            locationAddress1.hashCode),
                                                                        locationAddress2.hashCode),
                                                                    locationCity.hashCode),
                                                                locationState.hashCode),
                                                            locationRoomNumber.hashCode),
                                                        locationVenue.hashCode),
                                                    start.hashCode),
                                                startLocal.hashCode),
                                            startYear.hashCode),
                                        startMonth.hashCode),
                                    startDay.hashCode),
                                startHour.hashCode),
                            startMinute.hashCode),
                        timeZoneOffset.hashCode),
                    created.hashCode),
                createdBy.hashCode),
            updated.hashCode),
        updatedBy.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Event')
          ..add('id', id)
          ..add('rev', rev)
          ..add('allDay', allDay)
          ..add('contactEmail', contactEmail)
          ..add('contactName', contactName)
          ..add('contactPhone', contactPhone)
          ..add('ebrg', ebrg)
          ..add('end', end)
          ..add('endLocal', endLocal)
          ..add('endYear', endYear)
          ..add('endMonth', endMonth)
          ..add('endDay', endDay)
          ..add('endHour', endHour)
          ..add('endMinute', endMinute)
          ..add('eventDescription', eventDescription)
          ..add('eventName', eventName)
          ..add('locationAddress1', locationAddress1)
          ..add('locationAddress2', locationAddress2)
          ..add('locationCity', locationCity)
          ..add('locationState', locationState)
          ..add('locationRoomNumber', locationRoomNumber)
          ..add('locationVenue', locationVenue)
          ..add('start', start)
          ..add('startLocal', startLocal)
          ..add('startYear', startYear)
          ..add('startMonth', startMonth)
          ..add('startDay', startDay)
          ..add('startHour', startHour)
          ..add('startMinute', startMinute)
          ..add('timeZoneOffset', timeZoneOffset)
          ..add('created', created)
          ..add('createdBy', createdBy)
          ..add('updated', updated)
          ..add('updatedBy', updatedBy))
        .toString();
  }
}

class EventBuilder implements Builder<Event, EventBuilder> {
  _$Event _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _rev;
  String get rev => _$this._rev;
  set rev(String rev) => _$this._rev = rev;

  bool _allDay;
  bool get allDay => _$this._allDay;
  set allDay(bool allDay) => _$this._allDay = allDay;

  String _contactEmail;
  String get contactEmail => _$this._contactEmail;
  set contactEmail(String contactEmail) => _$this._contactEmail = contactEmail;

  String _contactName;
  String get contactName => _$this._contactName;
  set contactName(String contactName) => _$this._contactName = contactName;

  String _contactPhone;
  String get contactPhone => _$this._contactPhone;
  set contactPhone(String contactPhone) => _$this._contactPhone = contactPhone;

  bool _ebrg;
  bool get ebrg => _$this._ebrg;
  set ebrg(bool ebrg) => _$this._ebrg = ebrg;

  int _end;
  int get end => _$this._end;
  set end(int end) => _$this._end = end;

  int _endLocal;
  int get endLocal => _$this._endLocal;
  set endLocal(int endLocal) => _$this._endLocal = endLocal;

  int _endYear;
  int get endYear => _$this._endYear;
  set endYear(int endYear) => _$this._endYear = endYear;

  int _endMonth;
  int get endMonth => _$this._endMonth;
  set endMonth(int endMonth) => _$this._endMonth = endMonth;

  int _endDay;
  int get endDay => _$this._endDay;
  set endDay(int endDay) => _$this._endDay = endDay;

  int _endHour;
  int get endHour => _$this._endHour;
  set endHour(int endHour) => _$this._endHour = endHour;

  int _endMinute;
  int get endMinute => _$this._endMinute;
  set endMinute(int endMinute) => _$this._endMinute = endMinute;

  String _eventDescription;
  String get eventDescription => _$this._eventDescription;
  set eventDescription(String eventDescription) =>
      _$this._eventDescription = eventDescription;

  String _eventName;
  String get eventName => _$this._eventName;
  set eventName(String eventName) => _$this._eventName = eventName;

  String _locationAddress1;
  String get locationAddress1 => _$this._locationAddress1;
  set locationAddress1(String locationAddress1) =>
      _$this._locationAddress1 = locationAddress1;

  String _locationAddress2;
  String get locationAddress2 => _$this._locationAddress2;
  set locationAddress2(String locationAddress2) =>
      _$this._locationAddress2 = locationAddress2;

  String _locationCity;
  String get locationCity => _$this._locationCity;
  set locationCity(String locationCity) => _$this._locationCity = locationCity;

  String _locationState;
  String get locationState => _$this._locationState;
  set locationState(String locationState) =>
      _$this._locationState = locationState;

  String _locationRoomNumber;
  String get locationRoomNumber => _$this._locationRoomNumber;
  set locationRoomNumber(String locationRoomNumber) =>
      _$this._locationRoomNumber = locationRoomNumber;

  String _locationVenue;
  String get locationVenue => _$this._locationVenue;
  set locationVenue(String locationVenue) =>
      _$this._locationVenue = locationVenue;

  int _start;
  int get start => _$this._start;
  set start(int start) => _$this._start = start;

  int _startLocal;
  int get startLocal => _$this._startLocal;
  set startLocal(int startLocal) => _$this._startLocal = startLocal;

  int _startYear;
  int get startYear => _$this._startYear;
  set startYear(int startYear) => _$this._startYear = startYear;

  int _startMonth;
  int get startMonth => _$this._startMonth;
  set startMonth(int startMonth) => _$this._startMonth = startMonth;

  int _startDay;
  int get startDay => _$this._startDay;
  set startDay(int startDay) => _$this._startDay = startDay;

  int _startHour;
  int get startHour => _$this._startHour;
  set startHour(int startHour) => _$this._startHour = startHour;

  int _startMinute;
  int get startMinute => _$this._startMinute;
  set startMinute(int startMinute) => _$this._startMinute = startMinute;

  int _timeZoneOffset;
  int get timeZoneOffset => _$this._timeZoneOffset;
  set timeZoneOffset(int timeZoneOffset) =>
      _$this._timeZoneOffset = timeZoneOffset;

  int _created;
  int get created => _$this._created;
  set created(int created) => _$this._created = created;

  String _createdBy;
  String get createdBy => _$this._createdBy;
  set createdBy(String createdBy) => _$this._createdBy = createdBy;

  int _updated;
  int get updated => _$this._updated;
  set updated(int updated) => _$this._updated = updated;

  String _updatedBy;
  String get updatedBy => _$this._updatedBy;
  set updatedBy(String updatedBy) => _$this._updatedBy = updatedBy;

  EventBuilder();

  EventBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _rev = _$v.rev;
      _allDay = _$v.allDay;
      _contactEmail = _$v.contactEmail;
      _contactName = _$v.contactName;
      _contactPhone = _$v.contactPhone;
      _ebrg = _$v.ebrg;
      _end = _$v.end;
      _endLocal = _$v.endLocal;
      _endYear = _$v.endYear;
      _endMonth = _$v.endMonth;
      _endDay = _$v.endDay;
      _endHour = _$v.endHour;
      _endMinute = _$v.endMinute;
      _eventDescription = _$v.eventDescription;
      _eventName = _$v.eventName;
      _locationAddress1 = _$v.locationAddress1;
      _locationAddress2 = _$v.locationAddress2;
      _locationCity = _$v.locationCity;
      _locationState = _$v.locationState;
      _locationRoomNumber = _$v.locationRoomNumber;
      _locationVenue = _$v.locationVenue;
      _start = _$v.start;
      _startLocal = _$v.startLocal;
      _startYear = _$v.startYear;
      _startMonth = _$v.startMonth;
      _startDay = _$v.startDay;
      _startHour = _$v.startHour;
      _startMinute = _$v.startMinute;
      _timeZoneOffset = _$v.timeZoneOffset;
      _created = _$v.created;
      _createdBy = _$v.createdBy;
      _updated = _$v.updated;
      _updatedBy = _$v.updatedBy;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Event other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Event;
  }

  @override
  void update(void Function(EventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Event build() {
    final _$result = _$v ??
        new _$Event._(
            id: id,
            rev: rev,
            allDay: allDay,
            contactEmail: contactEmail,
            contactName: contactName,
            contactPhone: contactPhone,
            ebrg: ebrg,
            end: end,
            endLocal: endLocal,
            endYear: endYear,
            endMonth: endMonth,
            endDay: endDay,
            endHour: endHour,
            endMinute: endMinute,
            eventDescription: eventDescription,
            eventName: eventName,
            locationAddress1: locationAddress1,
            locationAddress2: locationAddress2,
            locationCity: locationCity,
            locationState: locationState,
            locationRoomNumber: locationRoomNumber,
            locationVenue: locationVenue,
            start: start,
            startLocal: startLocal,
            startYear: startYear,
            startMonth: startMonth,
            startDay: startDay,
            startHour: startHour,
            startMinute: startMinute,
            timeZoneOffset: timeZoneOffset,
            created: created,
            createdBy: createdBy,
            updated: updated,
            updatedBy: updatedBy);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
