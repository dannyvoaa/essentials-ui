import 'dart:collection';
import 'dart:convert';

import 'package:aae/api/api_client.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/settings/page/component/preference_section/preference_section_view_model.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

class PreferenceServiceRepository implements Repository {
  static final _log =
      Logger(Repository.buildLogName('PreferenceServiceRepository'));
  static const cacheKey = 'PreferenceServiceRepository';

  final _preferenceListing =
      createBehaviorSubject<UnmodifiableListView<PreferenceSectionViewModel>>();

  final CacheService _cacheService;

  @provide
  @singleton
  PreferenceServiceRepository(this._cacheService) {
    _loadFromCache();
  }

  /// [_loadFromCache] will load the user's saved settings from AAE backend to
  /// populate their options in to the app options
  void _loadFromCache() {}

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void stop() {
    // TODO: implement stop
  }
}
