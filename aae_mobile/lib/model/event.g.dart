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
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(String)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'eventName',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'locationAddress1',
      serializers.serialize(object.address1,
          specifiedType: const FullType(String)),
      'locationCity',
      serializers.serialize(object.city, specifiedType: const FullType(String)),
      'locationState',
      serializers.serialize(object.state,
          specifiedType: const FullType(String)),
      'allDay',
      serializers.serialize(object.isAllDay,
          specifiedType: const FullType(bool)),
      'ebrg',
      serializers.serialize(object.isEBRG, specifiedType: const FullType(bool)),
      'contactName',
      serializers.serialize(object.contactName,
          specifiedType: const FullType(String)),
      'start',
      serializers.serialize(object.startDate,
          specifiedType: const FullType(int)),
      'end',
      serializers.serialize(object.endDate, specifiedType: const FullType(int)),
      'timeZoneOffset',
      serializers.serialize(object.timeZone,
          specifiedType: const FullType(int)),
    ];
    if (object.createDate != null) {
      result
        ..add('created')
        ..add(serializers.serialize(object.createDate,
            specifiedType: const FullType(int)));
    }
    if (object.updateDate != null) {
      result
        ..add('updated')
        ..add(serializers.serialize(object.updateDate,
            specifiedType: const FullType(int)));
    }
    if (object.description != null) {
      result
        ..add('eventDescription')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.venue != null) {
      result
        ..add('locationVenue')
        ..add(serializers.serialize(object.venue,
            specifiedType: const FullType(String)));
    }
    if (object.roomNumber != null) {
      result
        ..add('locationRoomNumber')
        ..add(serializers.serialize(object.roomNumber,
            specifiedType: const FullType(String)));
    }
    if (object.address2 != null) {
      result
        ..add('locationAddress2')
        ..add(serializers.serialize(object.address2,
            specifiedType: const FullType(String)));
    }
    if (object.contactEmail != null) {
      result
        ..add('contactEmail')
        ..add(serializers.serialize(object.contactEmail,
            specifiedType: const FullType(String)));
    }
    if (object.contactPhone != null) {
      result
        ..add('contactPhone')
        ..add(serializers.serialize(object.contactPhone,
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
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created':
          result.createDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updated':
          result.updateDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'eventName':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventDescription':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationVenue':
          result.venue = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationRoomNumber':
          result.roomNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationAddress1':
          result.address1 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationAddress2':
          result.address2 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationCity':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'locationState':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'allDay':
          result.isAllDay = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ebrg':
          result.isEBRG = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'contactName':
          result.contactName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contactEmail':
          result.contactEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contactPhone':
          result.contactPhone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'start':
          result.startDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'end':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timeZoneOffset':
          result.timeZone = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
  final String category;
  @override
  final String author;
  @override
  final int createDate;
  @override
  final int updateDate;
  @override
  final String title;
  @override
  final String description;
  @override
  final String venue;
  @override
  final String roomNumber;
  @override
  final String address1;
  @override
  final String address2;
  @override
  final String city;
  @override
  final String state;
  @override
  final bool isAllDay;
  @override
  final bool isEBRG;
  @override
  final String contactName;
  @override
  final String contactEmail;
  @override
  final String contactPhone;
  @override
  final int startDate;
  @override
  final int endDate;
  @override
  final int timeZone;

  factory _$Event([void Function(EventBuilder) updates]) =>
      (new EventBuilder()..update(updates)).build();

  _$Event._(
      {this.id,
      this.category,
      this.author,
      this.createDate,
      this.updateDate,
      this.title,
      this.description,
      this.venue,
      this.roomNumber,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.isAllDay,
      this.isEBRG,
      this.contactName,
      this.contactEmail,
      this.contactPhone,
      this.startDate,
      this.endDate,
      this.timeZone})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Event', 'id');
    }
    if (category == null) {
      throw new BuiltValueNullFieldError('Event', 'category');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('Event', 'author');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Event', 'title');
    }
    if (address1 == null) {
      throw new BuiltValueNullFieldError('Event', 'address1');
    }
    if (city == null) {
      throw new BuiltValueNullFieldError('Event', 'city');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('Event', 'state');
    }
    if (isAllDay == null) {
      throw new BuiltValueNullFieldError('Event', 'isAllDay');
    }
    if (isEBRG == null) {
      throw new BuiltValueNullFieldError('Event', 'isEBRG');
    }
    if (contactName == null) {
      throw new BuiltValueNullFieldError('Event', 'contactName');
    }
    if (startDate == null) {
      throw new BuiltValueNullFieldError('Event', 'startDate');
    }
    if (endDate == null) {
      throw new BuiltValueNullFieldError('Event', 'endDate');
    }
    if (timeZone == null) {
      throw new BuiltValueNullFieldError('Event', 'timeZone');
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
        category == other.category &&
        author == other.author &&
        createDate == other.createDate &&
        updateDate == other.updateDate &&
        title == other.title &&
        description == other.description &&
        venue == other.venue &&
        roomNumber == other.roomNumber &&
        address1 == other.address1 &&
        address2 == other.address2 &&
        city == other.city &&
        state == other.state &&
        isAllDay == other.isAllDay &&
        isEBRG == other.isEBRG &&
        contactName == other.contactName &&
        contactEmail == other.contactEmail &&
        contactPhone == other.contactPhone &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        timeZone == other.timeZone;
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
                                                                            $jc($jc($jc(0, id.hashCode), category.hashCode),
                                                                                author.hashCode),
                                                                            createDate.hashCode),
                                                                        updateDate.hashCode),
                                                                    title.hashCode),
                                                                description.hashCode),
                                                            venue.hashCode),
                                                        roomNumber.hashCode),
                                                    address1.hashCode),
                                                address2.hashCode),
                                            city.hashCode),
                                        state.hashCode),
                                    isAllDay.hashCode),
                                isEBRG.hashCode),
                            contactName.hashCode),
                        contactEmail.hashCode),
                    contactPhone.hashCode),
                startDate.hashCode),
            endDate.hashCode),
        timeZone.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Event')
          ..add('id', id)
          ..add('category', category)
          ..add('author', author)
          ..add('createDate', createDate)
          ..add('updateDate', updateDate)
          ..add('title', title)
          ..add('description', description)
          ..add('venue', venue)
          ..add('roomNumber', roomNumber)
          ..add('address1', address1)
          ..add('address2', address2)
          ..add('city', city)
          ..add('state', state)
          ..add('isAllDay', isAllDay)
          ..add('isEBRG', isEBRG)
          ..add('contactName', contactName)
          ..add('contactEmail', contactEmail)
          ..add('contactPhone', contactPhone)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('timeZone', timeZone))
        .toString();
  }
}

class EventBuilder implements Builder<Event, EventBuilder> {
  _$Event _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  int _createDate;
  int get createDate => _$this._createDate;
  set createDate(int createDate) => _$this._createDate = createDate;

  int _updateDate;
  int get updateDate => _$this._updateDate;
  set updateDate(int updateDate) => _$this._updateDate = updateDate;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _venue;
  String get venue => _$this._venue;
  set venue(String venue) => _$this._venue = venue;

  String _roomNumber;
  String get roomNumber => _$this._roomNumber;
  set roomNumber(String roomNumber) => _$this._roomNumber = roomNumber;

  String _address1;
  String get address1 => _$this._address1;
  set address1(String address1) => _$this._address1 = address1;

  String _address2;
  String get address2 => _$this._address2;
  set address2(String address2) => _$this._address2 = address2;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  bool _isAllDay;
  bool get isAllDay => _$this._isAllDay;
  set isAllDay(bool isAllDay) => _$this._isAllDay = isAllDay;

  bool _isEBRG;
  bool get isEBRG => _$this._isEBRG;
  set isEBRG(bool isEBRG) => _$this._isEBRG = isEBRG;

  String _contactName;
  String get contactName => _$this._contactName;
  set contactName(String contactName) => _$this._contactName = contactName;

  String _contactEmail;
  String get contactEmail => _$this._contactEmail;
  set contactEmail(String contactEmail) => _$this._contactEmail = contactEmail;

  String _contactPhone;
  String get contactPhone => _$this._contactPhone;
  set contactPhone(String contactPhone) => _$this._contactPhone = contactPhone;

  int _startDate;
  int get startDate => _$this._startDate;
  set startDate(int startDate) => _$this._startDate = startDate;

  int _endDate;
  int get endDate => _$this._endDate;
  set endDate(int endDate) => _$this._endDate = endDate;

  int _timeZone;
  int get timeZone => _$this._timeZone;
  set timeZone(int timeZone) => _$this._timeZone = timeZone;

  EventBuilder();

  EventBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _category = _$v.category;
      _author = _$v.author;
      _createDate = _$v.createDate;
      _updateDate = _$v.updateDate;
      _title = _$v.title;
      _description = _$v.description;
      _venue = _$v.venue;
      _roomNumber = _$v.roomNumber;
      _address1 = _$v.address1;
      _address2 = _$v.address2;
      _city = _$v.city;
      _state = _$v.state;
      _isAllDay = _$v.isAllDay;
      _isEBRG = _$v.isEBRG;
      _contactName = _$v.contactName;
      _contactEmail = _$v.contactEmail;
      _contactPhone = _$v.contactPhone;
      _startDate = _$v.startDate;
      _endDate = _$v.endDate;
      _timeZone = _$v.timeZone;
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
            category: category,
            author: author,
            createDate: createDate,
            updateDate: updateDate,
            title: title,
            description: description,
            venue: venue,
            roomNumber: roomNumber,
            address1: address1,
            address2: address2,
            city: city,
            state: state,
            isAllDay: isAllDay,
            isEBRG: isEBRG,
            contactName: contactName,
            contactEmail: contactEmail,
            contactPhone: contactPhone,
            startDate: startDate,
            endDate: endDate,
            timeZone: timeZone);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
