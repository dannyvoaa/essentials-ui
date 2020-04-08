import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A Repository containing the most up to date version of the current user's
/// [Profile]. Handles caching and fetching the latest data when appropriate.
///
/// Used as a data source for BLoCs.
class ProfileRepository implements Repository {
  static final log = Logger(Repository.buildLogName('ProfileRepository'));

  static const cacheKey = 'ProfileRepository.Profile';

  final _profile = createBehaviorSubject<Profile>();
  final CacheService _cache;

  @provide
  @singleton
  ProfileRepository(this._cache) {
    //_loadFromCache();
  }

  ///Publishes the current logged in user's profile.
  Observable<Profile> get profile => _profile;

  /// Fetches the current user's profile to attempt to validate their identity.
  ///
  /// Throws [UserNotWhitelistedException] if the user is not allowed to create
  /// a Aae profile. Throws [ProfileNotFoundException] if the user needs
  /// to create a profile before they can use the app.
  Future<void> validateIdentity() async {}

  /// Creates a new [Profile] for the current user.
  Future<bool> createProfile(
    Topics topics,
    Workgroup workgroups,
  ) async {
    Profile responseProfile;
    try {
      responseProfile = responseProfile.rebuild((b) => b
        ..aaId = 'test'
        ..jiveId = 'test'
        ..profileImage =
            'https://en.wikipedia.org/wiki/Doug_Parker#/media/File:DougParker.jpg'
        ..topics.addAll(Iterable.empty())
        ..workgroup.addAll(Iterable.empty()));
    } catch (e, s) {
      log.severe('Failed to create profile:', e, s);
      return false;
    }
    return true;
  }

  /// Loads a preexisting [Profile] for the current user
  Future<bool> loadProfile() async {
    Profile responseProfile;

    try {
      responseProfile;
    } catch (e, s) {
      log.severe('Failed to load profile:', e, s);
      return false;
    }
    return true;
  }

  @override
  void start() {} // NO-OP
  @override
  void stop() {} // NO-OP
  @override
  void clear() {} // NO-OP
}
