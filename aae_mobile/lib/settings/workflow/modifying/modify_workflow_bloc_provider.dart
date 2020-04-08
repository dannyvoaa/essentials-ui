import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/widgets/workflow_page/workflow_footer_button/workflow_footer_button_bloc.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_bloc.dart';
import 'package:aae/sign_in/component/workgroups_selection/workgroups_selection_bloc.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:inject/inject.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/provided_service.dart';

class ModifyWorkflowBlocProvider
    implements
        WorkgroupsSelectionBlocFactory,
        TopicsSelectionBlocFactory,
        ModifyPreferenceBlocFactory {
  final ModifyPreferenceBloc _modifyPreferenceBloc;
  final WorkgroupsSelectionBloc _workgroupsSelectionBloc;
  final TopicsSelectionBloc _topicsSelectionBloc;
  final WorkflowFooterButtonBloc _workflowFooterButtonBloc;

  @provide
  ModifyWorkflowBlocProvider(
    SignInSharedDataRepository sharedDataRepository,
    ProfileRepository profileRepository,
    TopicsRepository topicsRepository,
    WorkgroupsRepository workgroupsRepository,
    CacheService cacheService,
    this._workflowFooterButtonBloc,
    this._modifyPreferenceBloc,
  )   : _workgroupsSelectionBloc = WorkgroupsSelectionBloc(
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
  WorkgroupsSelectionBloc workgroupsSelectionBloc() => _workgroupsSelectionBloc;

  @override
  TopicsSelectionBloc topicsSelectionBloc() => _topicsSelectionBloc;

  @override
  WorkflowFooterButtonBloc workflowFooterButtonBloc() =>
      _workflowFooterButtonBloc;

  @override
  ModifyPreferenceBloc preferenceBloc() => _modifyPreferenceBloc;
}

abstract class ModifyWorkflowBlocProviderFactory implements ProvidedService {
  @provide
  ModifyWorkflowBlocProvider modifyBloc();
}
