import 'dart:async';
import 'dart:convert';

import 'package:aae/api/travel_api_client.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/airport.dart';
import 'package:aae/model/boarding_pass.dart';
import 'package:aae/model/check_in_request.dart';
import 'package:aae/model/countries.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/model/flight_status.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/travel/component/checkin/checkin_component.dart';
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
  final _boardingPasses = createBehaviorSubject<BuiltList<BoardingPass>>();

  final CacheService _cache;
  static String tripsKey = 'trips';
  String strEmployeeId;
  String strSmsession;

  Observable<BuiltList<Pnr>> get pnrs => _pnrs;
  Observable<PriorityList> get currentPriorityList => _currentPriorityList;
  Observable<ReservationDetail> get reservationDetail => _reservationDetail;
  Observable<FlightStatus> get flightStatus => _flightStatus;
  Observable<FlightSearch> get flightSearch => _flightSearch;
  Observable<BuiltList<Airport>> get airports => _airports;
  Observable<BuiltList<BoardingPass>> get boardingPasses => _boardingPasses;

  BuiltList<Airport> cachedAirports;
  Map<String, Country> cachedCountries;
  String currentBoardingPassPnr;
  String currentReservationDetailsPnr;

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
    Trips trips =
        serializers.deserializeWith(Trips.serializer, jsonDecode(tripsJson));
    return trips;
  }

  bool existsEmployeeIdAndSMSession() {
    bool bExists = false;
    if (_ssoAuth.currentUser != null) {
      strEmployeeId = _ssoAuth.currentUser.id;
      strSmsession = _cache.readString("SMSESSION").value.toString();

      _log.info("empId: $strEmployeeId, smsession: strSmsession");

      if ((strSmsession != "") || (strSmsession != null)) {
        bExists = true;
      } else {
        _log.info('No SMSession found');
      }
    } else {
      _log.info('No current User found');
    }
    return bExists;
  }

  fetchTrips() async {
    if (existsEmployeeIdAndSMSession()) {
      try {
        Trips trips =
            await _travelApiClient.getReservations(strEmployeeId, strSmsession);
        _saveToCache(tripsKey, trips.toJson());
        _loadFromTripsCache();
      } catch (e, s) {
        _log.severe('Failed to fetch trips: ', e);
        return null;
      }
    } else {
      return null;
    }
  }

  loadPriorityList(String origin, int flightNum, DateTime date) async {
    if (existsEmployeeIdAndSMSession()) {
      PriorityList priorityList;
      try {
        _currentPriorityList.sendNext(null);
        priorityList = await _travelApiClient.getPriorityList(
            strEmployeeId, strSmsession, origin, flightNum, date);
        _currentPriorityList.sendNext(priorityList);
      } catch (e, s) {
        priorityList = new PriorityList();
        _currentPriorityList.sendNext(priorityList);
      }
    } else {
      return null;
    }
  }

  loadAirports() async {
    if (existsEmployeeIdAndSMSession()) {
      if (cachedAirports == null) {
        cachedAirports =
            await _travelApiClient.getAirports(strEmployeeId, strSmsession);
      } else {
        _log.info('using cached airport list');
      }
      _airports.sendNext(cachedAirports);
    } else {
      return null;
    }
  }

  loadCountries() async {
    if (!existsEmployeeIdAndSMSession()) {
      return null;
    }

    if (cachedCountries == null) {
      BuiltList<Country> countriesList = await _travelApiClient.getCountries(strEmployeeId, strSmsession);
      cachedCountries = {};

      for(Country currCountry in countriesList) {
        CountryBuilder b = currCountry.toBuilder();
        if (b.countryName == "Sao Tome and Principe")
          b.countryName = "São Tomé and Príncipe";
        currCountry = b.build();

        cachedCountries[currCountry.countryCode] = currCountry;
      }
    } else {
      _log.info('using cached countries list');
    }
  }

  loadFlightStatus(flightNumber, origin, date) async {
    if (existsEmployeeIdAndSMSession()) {
      FlightStatus flightStatus;
      try {
        _flightStatus.sendNext(null);
        flightStatus = await _travelApiClient.getFlightStatus(
            strEmployeeId, strSmsession, flightNumber, origin, date);
        _flightStatus.sendNext(flightStatus);
        return true;
      } catch (e, s) {
        _log.severe('Failed to fetch flightStatus', e, s);
        flightStatus = new FlightStatus();
        _flightStatus.sendNext(flightStatus);
      }
    } else {
      return null;
    }
  }

  loadFlightSearch(origin, destination, date) async {
    if (existsEmployeeIdAndSMSession()) {
      FlightSearch flightSearch;
      try {
        _flightSearch.sendNext(null);
        flightSearch = await _travelApiClient.getFlightSearch(
            strEmployeeId, strSmsession, origin, destination, date);
        _flightSearch.sendNext(flightSearch);
        return true;
      } catch (e, s) {
        _log.severe('Failed to fetch flightSearch', e, s);
        flightSearch = new FlightSearch();
        _flightSearch.sendNext(flightSearch);
      }
    } else {
      return null;
    }
  }

  loadReservationDetail(String pnr, bool forceRefresh) async {
    _log.info("loadReservationDetail!");

    if (!existsEmployeeIdAndSMSession()) {
      _log.severe("missing siteminder info!");
      return;
    }

    if (currentReservationDetailsPnr == pnr && !forceRefresh) {
      _log.info("no reservation retrieval needed!");
      return;
    }

    _log.info("clearing reservationDetails");
    _reservationDetail.sendNext(null);
    currentReservationDetailsPnr = pnr;

    try {
      ReservationDetail reservationDetail = await _travelApiClient.getReservationDetail(strEmployeeId, strSmsession, pnr);
      _log.info("updating reservationDetails with ${reservationDetail?.recordLocator}");
      _reservationDetail.sendNext(reservationDetail);
    } catch (e) {
      currentReservationDetailsPnr = null;
      throw e;
    }
  }

  updateReservationDetail(ReservationDetail reservation) {
    if (reservation == null || reservation.recordLocator != currentReservationDetailsPnr) {
      _log.info("you can only update the currently loaded pnr!");
    }

    _log.info("updating reservation...");
    _reservationDetail.sendNext(reservation);
  }

  performCheckIn(CheckInArguments checkInArgs) async {
    if (!existsEmployeeIdAndSMSession())
      return;

    _boardingPasses.sendNext(null);
    currentBoardingPassPnr = checkInArgs.pnr;

    try {

      BuiltList<BoardingPass> passes = await _travelApiClient.pushCheckIn(checkInArgs, strEmployeeId, strSmsession);
      _boardingPasses.sendNext(passes);
    } catch (e) {
      currentBoardingPassPnr = null;
      throw e;
    }
  }

  loadBoardingPasses(String pnr, bool forceRefresh) async {
    if (!existsEmployeeIdAndSMSession())
      return;

    // if we already have boarding passes for the given pnr
    // and we are not forcing a refresh, no need to make a call.
    if (currentBoardingPassPnr == pnr && !forceRefresh) {
      return;
    }

    _boardingPasses.sendNext(null);
    currentBoardingPassPnr = pnr;
    try {
      BuiltList<BoardingPass> passes = await _travelApiClient
          .getBoardingPasses(strEmployeeId, strSmsession, pnr);
      _boardingPasses.sendNext(passes);
    } catch (e) {
      currentBoardingPassPnr = null;
      throw e;
    }
  }

  cancelReservation (String pnr) async {
    if (!existsEmployeeIdAndSMSession())
      return;

    _boardingPasses.sendNext(null);
    try {
      BuiltList<BoardingPass> passes = await _travelApiClient.cancelReservation(pnr, strEmployeeId, strSmsession);
      _boardingPasses.sendNext(passes);
    } catch (e) {
      currentBoardingPassPnr = null;
      throw e;
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
