import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rx_ext/lib/rx_ext.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A Repository containing the most up to date version of the current user's
/// [Profile]. Handles caching and fetching the latest data when appropriate.
///
/// Used as a data source for BLoCs.
class ProfileRepository implements Repository {
  static final _log = Logger(Repository.buildLogName('ProfileRepository'));

  static const cacheKey = 'ProfileRepository.Profile';

  /// Endpoint for the user_preferences cloudant database
  static const apiEndpoint =
      'https://toreetherywhimandifersee:55608bd3e3255fe1851de225ce562d4cab7d8fa2@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud/user_preferences/b4eabdbfde6a14ad41a342a5a9a4b99c';

  static const apiEndpointInsert = "https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/user-profile/aeuserinsertintodb.json";
  static const apiEndpointGetRev = "https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/user-profile/aeuserexistsindb.json";
  static const apiEndpointUpdate = "https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/user-profile/aeuserupdateindb.json";


  final _profile = createBehaviorSubject<Profile>();

  final CacheService _cache;
  final NewsServiceApi _apiClient;
  final SSOAuth _ssoAuth;

  @provide
  @singleton
  ProfileRepository(this._cache, this._apiClient, this._ssoAuth) {
    _loadFromCache();
  }

  ///Publishes the current logged in user's profile.
  Observable<Profile> get profile => _profile;

  void _loadFromCache() {
    // Look up the current profile from cache, publish it if we have it:
    _cache
        .readString(cacheKey)
        .transform(_profileToModel)
        .ifPresent(_profile.sendNext);
  }

  Future<void> _saveToCache(Profile profile) =>
      _cache.writeString(cacheKey, profile.toJson());

  static Profile _profileToModel(String cachedProfile) {
    Profile profile = serializers.deserializeWith(
        Profile.serializer, jsonDecode(cachedProfile));
    return profile;
  }

  /// Fetches the current user's profile to attempt to validate their identity.
  /// Throws [ProfileNotFoundException] if the user needs
  /// to create a profile before they can use the app.
  Future<void> validateIdentity() async {
    Profile profile;
    try {
      profile = await _apiClient.getProfile(_ssoAuth.currentUser.id);
    } catch (e, s) {
        _log.severe('Failed to verify profile:', e, s);
        throw ProfileNotFoundException('User does not have a profile');
    }
    _profile.sendNext(profile.rebuild((builder) => builder.displayName = _ssoAuth.currentUser.displayName));
  }

  //TODO: (kiheke) - Update to use api.
  _fetchProfile() async {
    return (await _apiClient.getProfile(_ssoAuth.currentUser.id));
  }

  /// Creates a new [Profile] for the current user.
  Future<bool> createProfile(List<String> hubLocations, List<String> workgroups, List<String> topics) async {
    final responseProfile = Profile((b) => b
      ..displayName = _ssoAuth.currentUser.displayName
      ..email = _ssoAuth.currentUser.email
      ..userlocation = _ssoAuth.currentUser.userlocation
      ..hubLocation.addAll(hubLocations)
      ..workgroup.addAll(workgroups)
      ..topics.addAll(topics));

    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      //'Authorization': 'Basic dG9yZWV0aGVyeXdoaW1hbmRpZmVyc2VlOjU1NjA4YmQzZTMyNTVmZTE4NTFkZTIyNWNlNTYyZDRjYWI3ZDhmYTI=',
      final body = jsonEncode({
        "aaId": _ssoAuth.currentUser.id,
        "preferences": {
          "userlocation": _ssoAuth.currentUser.userlocation,
          "hubLocation": hubLocations,
          "workgroup": workgroups,
          "topics": topics
        },
        "created": 1582726346,
        "updated": 1582726346
      });

      final rev_headers = {'Accept': 'application/json'};
      final res = await http.post('$apiEndpointInsert', headers: headers, body: body);
      if (res.statusCode > 299)
        throw Exception('get error: statusCode= ${res.statusCode}');
      print(res.body);
    } catch (e, s) {
      _log.severe('Failed to create profile:', e, s);
      return false;
    }
    _saveToCache(responseProfile);
    _profile.sendNext(responseProfile);
    return true;
  }

  /// Updates the [Profile] for the current user.
  Future<bool> updateProfile(Profile updatedProfile) async {

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      List<String> hubLocations = updatedProfile.hubLocation.asList();
      List<String> workgroups = updatedProfile.workgroup.asList();
      List<String> topics = updatedProfile.topics.asList();

      String strAAId = _ssoAuth.currentUser.id.toString();


      var rev_headers = {'Accept': 'application/json'};

      final response = await http.get(apiEndpointGetRev + "?aaId=" + strAAId , headers: rev_headers);
      String strRev = "";
      Map<String, dynamic> json = jsonDecode(response.body);

      print(json['docs'].toString());
      print(json['docs'][0].toString());
      //print(json['docs'][0]._rev.toString());

      if (json['docs'].length != 0) {
        Map<String, dynamic> revMap = json['docs'][0];
        strRev = revMap['_rev'];
      }

      //String _rev = rev_res.headers['etag'].replaceAll('"', '');
      var body = jsonEncode({
        "_id": strAAId,
        "_rev": strRev,
        "aaId": strAAId,
        "preferences": {
          "userlocation": _ssoAuth.currentUser.userlocation,
          "topics": topics,
          "workgroup": workgroups,
          "hubLocation": hubLocations,
        },
        "created": 1582726346,
        "updated": 1582726346
      });

      var res = await http.post(apiEndpointUpdate, headers: headers, body: body);
      if (res.statusCode > 299)
        throw Exception('get error: statusCode= ${res.statusCode}');
    } catch (e, s) {
      _log.severe('Failed to update profile:', e, s);
      return false;
    }
    _saveToCache(updatedProfile);
    _profile.sendNext(updatedProfile);
    return true;
  }

  /// Loads a preexisting [Profile] for the current user
//  Future<bool> loadProfile() async {
//    Profile responseProfile;
//
//    try {
//      responseProfile;
//    } catch (e, s) {
//      _log.severe('Failed to update profile:', e, s);
//    }
//    return true;
//  }

  Future<Profile> fetchActiveProfile() async {
    //blockingLatest: subscribes the observable at the time of this method is called and returns a Future of the latest emission of the Observable.
    return (await blockingLatest(profile));
  }

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}

/// Exception indicating that current user does not have a AAE profile.
class ProfileNotFoundException implements Exception {
  String message;
  ProfileNotFoundException([this.message]);
}
