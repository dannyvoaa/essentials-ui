import 'dart:async';
import 'dart:convert';

import 'package:aae/api/travel_api_client.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/airport.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:built_collection/built_collection.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a [Trips] response.
///
/// Single source of truth for all Trips data - do not stream in another
/// service, take a dependency on this repository instead.
///
/// Handles caching and fetching the latest data when appropriate.
class TravelRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('TravelRepository'));
  final TravelServiceApi _travelApiClient;
  final SSOAuth _ssoAuth;

  static const cacheKey = 'TravelRepository.Travel';

  final _pnrs = createBehaviorSubject<BuiltList<Pnr>>();
  final _currentPriorityList = createBehaviorSubject<PriorityList>();
  final _reservationDetail = createBehaviorSubject<ReservationDetail>();
  final _flightStatus = createBehaviorSubject<FlightStatus>();
  final _flightSearch = createBehaviorSubject<FlightSearch>();
  final _airports = createBehaviorSubject<BuiltList<Airport>>();

  final CacheService _cache;
  static String tripsKey = 'trips';

  Observable<BuiltList<Pnr>> get pnrs => _pnrs;
  Observable<PriorityList> get currentPriorityList => _currentPriorityList;
  Observable<ReservationDetail> get reservationDetail => _reservationDetail;
  Observable<FlightStatus> get flightStatus => _flightStatus;
  Observable<FlightSearch> get flightSearch => _flightSearch;
  Observable<BuiltList<Airport>> get airports => _airports;

  BuiltList<Airport> _cachedAirports;

  void set flightStatus(var value) {
    flightStatus = value;
  }

  void set flightSearch(var value) {
    flightSearch = value;
  }

  @provide
  @singleton
  TravelRepository(this._cache, this._travelApiClient, this._ssoAuth) {
    _loadFromTripsCache();
    fetchTrips();
    loadAirports();
//    fetchFlightStatus(1,2);
  }

  void _loadFromTripsCache() {
    _cache
        .readString(tripsKey)
        .transform(_tripsToModel)
        .ifPresent(_publishTrips);
  }

  void _publishTrips(Trips trips) {
    _pnrs.sendNext(trips.pnrs);
  }

  static Trips _tripsToModel(String tripsJson) {
    Trips trips = serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  fetchTrips() async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
    	try {
      		Trips trips = await _travelApiClient.getReservations(strEmployeeId,strSmsession);
      		_saveToCache(tripsKey, trips.toJson());
      		_loadFromTripsCache();
    	} catch (e, s) {
      		_log.severe('Failed to fetch trips: ', e, s);
      		return null;
    	}
    } else {
      _log.severe('No SMSession found');
      return null;
    }
  }

  loadPriorityList(String origin, int flightNum, DateTime date) async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
      _currentPriorityList.sendNext(null);
    	PriorityList priorityList = await _travelApiClient.getPriorityList(strEmployeeId, strSmsession, origin, flightNum, date);
	    _currentPriorityList.sendNext(priorityList);
    } else {
      _log.severe('No SMSession found');
      return null;
    }
  }

  loadAirports() async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
      if (_cachedAirports == null) {
        _cachedAirports = await _travelApiClient.getAirports(strEmployeeId, strSmsession);
      }
      {
        _log.info('using cached airport list');
      }
      _airports.sendNext(_cachedAirports);
    } else {
      _log.severe('No SMSession found');
      return null;
    }
  }

  loadFlightStatus(flightNumber, origin, date) async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
      FlightStatus flightStatus;
      try {
        _flightStatus.sendNext(null);
        flightStatus = await _travelApiClient.getFlightStatus(strEmployeeId, strSmsession, flightNumber, origin, date);
        _flightStatus.sendNext(flightStatus);
        return true;

      } catch (e, s) {
        _log.severe('Failed to fetch flightStatus', e, s);
        flightStatus = new FlightStatus();
        _flightStatus.sendNext(flightStatus);
      }
    } else {
        _log.severe('No SMSession found');
      	return null;
    }
  }

  loadFlightSearch(origin, destination, date) async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
      FlightSearch flightSearch;
      try {
        _flightSearch.sendNext(null);
        flightSearch = await _travelApiClient.getFlightSearch(strEmployeeId, strSmsession, origin, destination, date);
        _flightSearch.sendNext(flightSearch);
        return true;
      } catch (e, s) {
        _log.severe('Failed to fetch flightSearch', e, s);
        flightSearch = new FlightSearch();
        _flightSearch.sendNext(flightSearch);
      }
    } else {
    	_log.severe('No SMSession found');
      	return null;
    }
  }

  loadReservationDetail(String pnr) async {
    String strEmployeeId = _ssoAuth.currentUser.id;
    String strSmsession =  _cache.readString("SMSESSION").value.toString();

    if (strSmsession != null) {
    	_reservationDetail.sendNext(null);
    	ReservationDetail reservationDetail = await _travelApiClient.getReservationDetail(strEmployeeId, strSmsession, pnr);
    	_reservationDetail.sendNext(reservationDetail);
    } else {
    	_log.severe('No SMSession found');
      	return null;
    }
  }

  Future<void> _saveToCache(String key, String data) =>
      _cache.writeString(key, data);

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
