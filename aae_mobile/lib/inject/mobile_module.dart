import 'dart:collection';

import 'package:aae/api/api_client.dart';
import 'package:aae/api/hsm_state_machine.dart';
import 'package:aae/auth/sso_auth.dart';
import 'package:aae/bloc/bloc_factory.dart';
import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/repository/repository.dart';
import 'package:aae/common/repository/repository_lifecycle_manager.dart';
import 'package:aae/home/repository/news_feed_repository.dart';
import 'package:aae/inject/annotations.dart';
import 'package:aae/lifecycle_managed_service.dart';
import 'package:aae/logging/log_buffer.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/recognition/repository/recognition_repository.dart';
import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';
import 'package:aae/settings/modify/repository/modify_shared_data_repository.dart';
import 'package:aae/settings/modify/repository/preference_service_repository.dart';
import 'package:aae/settings/workflow/modifying/modify_state_machine.dart';
import 'package:aae/settings/workflow/modifying/modify_states.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_states.dart';
import 'package:aae/sign_in/workflow/sign_in_state_machine.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/workflow/common/workflow_state.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mobile_module.inject.dart' as generated;

/// Module to resolve inject.dart to resolve dependencies.
@module
class MobileModule {
  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  SSOAuth ssoAuth() => SSOAuth();

  @provide
  @singleton
  NewsServiceApi apiClient() => NewsServiceApi();

  @provide
  @singleton
  LogBuffer logBuffer() {
    return LogBuffer(loglimitBytes: 250000);
  }

  @provide
  @singleton
  @asynchronous
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();

  @provide
  @signInHsm
  Machine<WorkflowState, WorkflowEvent> signInStateMachine() {
    return Machine<WorkflowState, WorkflowEvent>(
      name: SignInStateMachine.name,
      rootId: SignInStates.root,
      log: Logger(SignInStateMachine.name),
    );
  }

  @provide
  @modifySettings
  Machine<WorkflowState, WorkflowEvent> modifyStateMachine() {
    return Machine<WorkflowState, WorkflowEvent>(
      name: ModifyStateMachine.name,
      rootId: ModifyStates.root,
      log: Logger(ModifyStateMachine.name),
    );
  }

  @provide
  @singleton
  @providedServiceList
  UnmodifiableListView<ProvidedService> services(
    NewsFeedRepository newsFeedRepository,
    RecognitionRepository recognitionRepository,
    PreferenceServiceRepository preferenceServiceProvider,
  ) =>
      UnmodifiableListView<ProvidedService>([
        newsFeedRepository,
        recognitionRepository,
        preferenceServiceProvider,
      ]);

  @provide
  @singleton
  @lifecycleServiceList
  UnmodifiableListView<LifecycleManagedService> lifecycleManagedServices(
    @providedServiceList UnmodifiableListView<ProvidedService> services,
  ) =>
      UnmodifiableListView<LifecycleManagedService>(
        List<LifecycleManagedService>.from(
          services.whereType<LifecycleManagedService>(),
        ),
      );

  @provide
  @singleton
  @repositoryList
  UnmodifiableListView<Repository> repositories(
    @providedServiceList UnmodifiableListView<ProvidedService> services,
  ) =>
      UnmodifiableListView<Repository>(
        List<Repository>.from(
          services.whereType<Repository>(),
        ),
      );
}

@Injector([
  MobileModule,
])
abstract class AppInjector implements BlocFactory {
  static final create = generated.AppInjector$Injector.create;

  @provide
  @providedServiceList
  UnmodifiableListView services();

  @provide
  @lifecycleServiceList
  UnmodifiableListView lifecycleManagedServices();

  @provide
  NewsServiceApi apiClient();

  @provide
  RepositoryLifecycleManager createRepositoryManager();

  @provide
  CacheService cacheService();

  @provide
  LogBuffer provideLogBuffer();
}
