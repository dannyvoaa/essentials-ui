import 'dart:convert';

import 'package:aae/events/repository/events_repository.dart';
import 'package:aae/model/event.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:aae/common/network/network_cloudant.dart';
import 'package:http/http.dart' as http;

import 'events_list_view_model.dart';

/// BloC for the [EventsListComponent].
///
/// Exposes a [EventsListViewModel] for that component to use.
class EventsListBloc {
  final EventsRepository _eventsRepository;
  final NetworkCloudant _networkCloudant = NetworkCloudant();
  final apiEndpoint =
      'https://uisheitzearionstoodueget:eccadc4ad470f4ed210410939dc5a2115b0d7b58@ebc9e7bc-8615-4d08-8451-4f7f5c7d85ee-bluemix.cloudant.com';

  Source<EventsListViewModel> get viewModel =>
      toSource(combineLatest(_eventsRepository.eventsList, _createViewModel));

  @provide
  EventsListBloc(this._eventsRepository);

  EventsListViewModel _createViewModel(BuiltList<Event> listOfEvents) {
    _reloadData();
    return EventsListViewModel((b) => b..events.addAll(listOfEvents));
  }

  final Map<String, Object> body = {
    'selector': {
      'end': {'\$gte': (DateTime.now().millisecondsSinceEpoch / 1000).round()}
    },
    'fields': [],
    'sort': [
      {'allDay:number': 'asc'},
      {'start:number': 'asc'},
      {'eventName:string': 'asc'}
    ]
  };

  final Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  Future<void> _reloadData() async {
    var client = http.Client();
    final json = jsonEncode(body);

    Future.microtask(() async {
      try {
        final response = await http.post('$apiEndpoint/events/_find',
            body: json, headers: header, encoding: Encoding.getByName('utf-8'));

        response.statusCode == 200
            ? debugPrint('returned body:${response.body}')
            : debugPrint('ERROR');
      } catch (e, s) {
        debugPrint('thrown error: $e\n\nStatus: $s');
      } finally {
        client.close();
      }
    });
  }
}

/// Constructs new instances of [EventsListBloc]s via the DI framework.
abstract class EventsListBlocFactory implements ProvidedService {
  @provide
  EventsListBloc eventsListBloc();
}
