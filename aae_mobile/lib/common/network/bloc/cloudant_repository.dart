import 'dart:convert';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:built_collection/built_collection.dart';
import 'package:logging/logging.dart';
import 'dart:async';

/// [CloudantRepository] this will serve as the absolute truth for any tasks
/// that would depend on a [CloudantQuery]

/// [CloudantQuery] would push out a command of a given [endPoint] that will
/// read from the database
typedef CloudantQuery = void Function(String endPoint);

/// [CloudantResponse] would pass a set of args to the backend to be consumed
/// and return a bool to indicate whether the function was successful
typedef CloudantResponse = bool Function(
  CloudantQuery query,
  Map<String, Object> args,
);

class CloudantRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('CloudantRepository'));

  final CacheService _cache;

  final Map<String, String> _header = {
    'Content-Type': 'application/json',
  };

  String _endPointContext;

  http.Response _response;

  /// [setEndPoint]
  void setEndPoint(String endPointContext) {
    _endPointContext = endPointContext;
  }

  @provide
  @singleton
  CloudantRepository(this._cache);

  ///[Response] is returned on query call for data with [Map] of [args] which is
  /// syntatic sugar for [http.body] args
  http.Response loadFromServer(Map<String, Object> args) {
    _loadFromServer(args);
    return _response;
  }

  void uploadToServer(Map<String, Object> args) => _uploadToServer(args);

  /// [_loadFromServer] passes the [body] parameter
  void _loadFromServer(Map<String, Object> args) {
    var client = http.Client();

    Future.microtask(() async {
      try {
        final response = await http.post(
          '###placeholder for url###$_endPointContext',
          body: args,
          headers: _header,
          encoding: Encoding.getByName('utf-8'),
        );

        response.statusCode == 200
            ? _response = response
            : throw (response.statusCode);
      } catch (e, s) {
        throw ({e: s});
      } finally {
        client.close();
      }
    });
  }

  void _uploadToServer(Map<String, Object> args) {
    var client = http.Client();

    Future.microtask(() async {
      try {
        //TODO (rpaglinawan): implement write function to server
        final response = await http.put(
          '###placeholder for url###$_endPointContext',
          body: args,
          headers: _header,
          encoding: Encoding.getByName('utf-8'),
        );
      } catch (e, s) {
        throw ({e: s});
      } finally {
        client.close();
      }
    });
  }

  @override
  void clear() {}

  @override
  void start() {
    //TODO (rpaglinawan): Start all Cloudant queries
  }

  @override
  void stop() {
    //TODO (rpaglinawan): Stop all Cloudant queries
  }
}
