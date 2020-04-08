import 'package:aae/cache/cache_service.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';
import 'package:aae/settings/preferences/app_preferences_bloc.dart';
import 'package:aae/settings/settingsbuttonslist/settings_buttons_list_bloc.dart';
import 'package:aae/sign_in/bloc/create_profile_bloc.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_bloc.dart';
import 'package:aae/sign_in/component/workgroups_selection/workgroups_selection_bloc.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:inject/inject.dart';

class ModifySettingsBlocProvider
    implements
        ModifyPreferenceBlocFactory,
        WorkgroupsSelectionBlocFactory,
        TopicsSelectionBlocFactory,
        SettingsButtonsListBlocFactory,
        AppPreferencesBlocFactory {
  final WorkgroupsSelectionBloc _workgroupsSelectionBloc;
  final TopicsSelectionBloc _topicsSelectionBloc;
  final SettingsButtonsListBloc _settingsButtonsListBloc;
  final AppPreferencesBloc _appPreferencesBloc;
  final CreateProfileBloc _createProfileBloc;
  final ModifyPreferenceBloc _modifyPreferenceBloc;

  @provide
  ModifySettingsBlocProvider(
      ProfileRepository profileRepository,
      TopicsRepository topicsRepository,
      WorkgroupsRepository workgroupsRepository,
      SignInSharedDataRepository sharedDataRepository,
      CacheService cacheService,
      this._appPreferencesBloc,
      this._settingsButtonsListBloc,
      this._modifyPreferenceBloc)
      : _createProfileBloc =
            CreateProfileBloc(profileRepository, sharedDataRepository),
        _workgroupsSelectionBloc = WorkgroupsSelectionBloc(
          sharedDataRepository,
          workgroupsRepository,
          cacheService,
        ),
        _topicsSelectionBloc = TopicsSelectionBloc(
          sharedDataRepository,
          topicsRepository,
          cacheService,
        );

  @override
  ModifyPreferenceBloc preferenceBloc() => _modifyPreferenceBloc;

  @override
  AppPreferencesBloc appPreferencesBloc() => _appPreferencesBloc;

  @override
  CreateProfileBloc createProfileBloc() => _createProfileBloc;

  @override
  SettingsButtonsListBloc settingsButtonsListBloc() => _settingsButtonsListBloc;

  @override
  TopicsSelectionBloc topicsSelectionBloc() => _topicsSelectionBloc;

  @override
  WorkgroupsSelectionBloc workgroupsSelectionBloc() => _workgroupsSelectionBloc;
}
