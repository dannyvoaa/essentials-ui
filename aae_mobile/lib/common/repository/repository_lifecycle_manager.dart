import 'dart:collection';

import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/inject/annotations.dart';
import 'package:aae/sign_in/bloc/sign_in_bloc.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// Responsible for triggering mandatory actions on all repositories.
class RepositoryLifecycleManager {
  static final _log = Logger('RepositoryLifecycleManager');

  final UnmodifiableListView<Repository> _repositories;
  final SignInBloc _signInBloc;
  final CacheService _cacheService;

  bool _isStopped = true;

  @provide
  @singleton
  RepositoryLifecycleManager(
    this._signInBloc,
    @repositoryList this._repositories,
    this._cacheService,
  ) {
    _signInBloc.profileValidity.subscribe(onNext: _handleProfileValidityUpdate);
  }

  void _handleProfileValidityUpdate(bool profileIsValid) {
    if (profileIsValid) {
      _startRepos();
    } else {
      _stopRepos();
      _clearData();
    }
  }

  void _startRepos() {
    if (!_isStopped) return;
    _isStopped = false;
    _log.info('Starting all repositories');
    for (var repo in _repositories) {
      repo.start();
    }
  }

  void _stopRepos() {
    if (_isStopped) return;
    _isStopped = true;
    _log.info('Stopping all repositories');
    for (var repo in _repositories) {
      repo.stop();
    }
  }

  void _clearData() {
    _log.info('Clearing repository and user data');
    _cacheService.clear();
    for (var repo in _repositories) {
      repo.clear();
    }
  }
}
