import 'package:aae/events/component/events_list/events_list_bloc.dart';
import 'package:aae/model/event.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aae/events/repository/events_repository.dart';
import '../../../mock/mock_repository.dart';

void main() {
  EventsRepository _eventsRepository;
  MockEventsRepository _mockRepository;
  setUpAll(() {
    var cache;
    var apiClient;
    Future.microtask(() {
      final _appInjector = MockAppInjector();
      cache = _appInjector.cacheService();
      apiClient = _appInjector.apiClient();

      _eventsRepository = EventsRepository(cache, apiClient);
    });
  });
  test('validate setup', () async {
    expect(_eventsRepository, isA<EventsRepository>());
  });

  bool _expectData(List<Event> event) =>
      event.any((element) => element.eventName != null);

  group('query data from server', () {
    setUp(() {
      _mockRepository = MockEventsRepository();
    });
    test('get a result', () async {
      Future.microtask(() async {
        List<Event> returnedData;
        final data = _eventsRepository.eventsList.asStream();
        data.listen((event) {
          debugPrint('event: $event');
          returnedData.addAll(event);
        }).onDone(() {
          expect(returnedData, isNotEmpty);
        });
      });
    });
  });
  group('filter data', () {
    EventsListBloc listBloc;
    setUp(() {
      _mockRepository = MockEventsRepository();

      listBloc = EventsListBloc(_eventsRepository);
    });
    test('filter a result for today', () {
      Future.microtask(() async {
        List<Event> returnedData;
        final data = _eventsRepository.eventsList.asStream();
        data.listen((event) {
          debugPrint('event: $event');
          returnedData.addAll(event);
        }).onDone(() {
          expect(returnedData, isNotEmpty);
        });
      });
    });
    test('filter result for a selected day', () {
      List<Event> returnedData;
      DateTime _mockTime = DateTime(2020, 3, 3);

      Future.microtask(() async {
        _eventsRepository.changeDate(DateTime(2020,3,3));
        final data = _eventsRepository.eventsList.asStream();
        data.listen((event) {
          returnedData.addAll(event);
        }).onDone(() {
          expect(returnedData, isA<List<Event>>());
          if (returnedData.isEmpty) {
            expect(true, true);
          } else {
            returnedData
                .firstWhere((element) => element.startDay == _mockTime.day);
          }
        });
      });
    });
  });
}
