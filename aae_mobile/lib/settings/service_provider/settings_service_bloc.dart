import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/rx/behavior_subject.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:pedantic/pedantic.dart';
import 'package:logging/logging.dart';

/// [SettingsServiceBloc] is used to observe any changes made in the
/// settings page and reverberate those changes through the app stack.
class SettingsServiceBloc implements Repository {
  /// [_cacheService] will store the changes for the user between application
  /// launches

  static const lastPermissionModified =
      'SettingsServiceProvider.lastModifiedSetting';
  static final _log =
      Logger(Repository.buildLogName('SettingsServiceProvider'));

  final CacheService _cacheService;

  @provide
  @singleton
  SettingsServiceBloc(this._cacheService) {
    //TODO: (rpaglinawan) address why this doesnt generate in function
  }

  /// [_permissionValidity] checks that the changes were made successfully
  final _permissionValidity = createBehaviorSubject<bool>();

  ///[changedPermissions] and [onPermissionChanged] sends a boolean value
  /// once there is an actual change
  Observable<bool> get changedPermissions =>
      _permissionValidity.distinctUntilChanged();

  void onPermissionChanged() => _permissionValidity.sendNext(true);

  /// [onStagnentPermission] is when permissions were not changed in execution
  void onStagnentPermission() {
    _cacheService.writeBool(lastPermissionModified, false);
    _permissionValidity.sendNext(false);
  }

  /// [attemptPermissionChange] attempts to write out changes to the cache
  void attemptPermissionChange() async {
    unawaited(_cacheService.writeBool(lastPermissionModified, false));
  }

  // TODO: (rpaglinawan) implement an inital check on app start
  @override
  void clear() {}

  @override
  void start() {}

  @override
  void stop() {}
}
