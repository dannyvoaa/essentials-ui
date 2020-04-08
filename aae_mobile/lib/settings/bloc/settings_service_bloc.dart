// TODO: (rpaglinawan) add the additional components to change the
// values in app stack
import 'dart:collection';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/rx/behavior_subject.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:logging/logging.dart';
import 'package:inject/inject.dart';

class SettingsServiceBloc {
  static const settingsLog = 'SettingsServiceBloc.load';
  static final _log = Logger('SettingsServiceBloc');

  final ProfileRepository _profileRepository;
  final SignInSharedDataRepository _signInSharedDataRepository;
  final CacheService _cacheService;

  final _validitySubject = createBehaviorSubject<bool>();

  Observable<bool> get profileValidity =>
      _validitySubject.distinctUntilChanged();

  @provide
  @singleton
  SettingsServiceBloc(this._profileRepository, this._signInSharedDataRepository,
      this._cacheService) {}

  //TODO (rpaglinawan): implement a load from aaeserver
  Future<void> loadPreferences() {}

  //TODO (rpaglinawan): implement a load from user device
  Future<void> loadSettings() {}
}
