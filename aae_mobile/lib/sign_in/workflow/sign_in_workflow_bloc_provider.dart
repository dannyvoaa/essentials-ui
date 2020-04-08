import 'package:aae/cache/cache_service.dart';
import 'package:aae/common/widgets/workflow_page/workflow_footer_button/workflow_footer_button_bloc.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
import 'package:aae/sign_in/bloc/create_profile_bloc.dart';
import 'package:aae/sign_in/bloc/sign_in_bloc.dart';
import 'package:aae/sign_in/component/failed/sign_in_failed_bloc.dart';
import 'package:aae/sign_in/component/login/login_bloc.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_bloc.dart';
import 'package:aae/sign_in/component/welcome/welcome_bloc.dart';
import 'package:aae/sign_in/component/workgroups_selection/workgroups_selection_bloc.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:inject/inject.dart';

/// Events for the sign-in workflow.
///
/// Class exists for importing convenience.

/// Provider for BLoCs needed in the SignInWorkflow.
class SignInWorkflowBlocProvider
    implements
        SignInBlocFactory,
        CreateProfileBlocFactory,
        WelcomeBlocFactory,
        LoginBlocFactory,
        SignInFailedBlocFactory,
        WorkgroupsSelectionBlocFactory,
        TopicsSelectionBlocFactory,
        WorkflowFooterButtonBlocFactory {
  final SignInBloc _signInBloc;
  final CreateProfileBloc _createProfileBloc;
  final WelcomeBloc _welcomeBloc;
  final LoginBloc _loginBloc;
  final SignInFailedBloc _signInFailedBloc;
  final WorkgroupsSelectionBloc _workgroupsSelectionBloc;
  final TopicsSelectionBloc _topicsSelectionBloc;
  final WorkflowFooterButtonBloc _workflowFooterButtonBloc;

  @provide
  SignInWorkflowBlocProvider(
    SignInSharedDataRepository sharedDataRepository,
    ProfileRepository profileRepository,
    TopicsRepository topicsRepository,
    WorkgroupsRepository workgroupsRepository,
    CacheService cacheService,
    this._signInBloc,
    this._welcomeBloc,
    this._loginBloc,
    this._signInFailedBloc,
    this._workflowFooterButtonBloc,
  )   : _createProfileBloc =
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
  SignInBloc signInBloc() => _signInBloc;

  @override
  CreateProfileBloc createProfileBloc() => _createProfileBloc;

  @override
  WelcomeBloc welcomeBloc() => _welcomeBloc;

  @override
  LoginBloc loginBloc() => _loginBloc;

  @override
  SignInFailedBloc signInFailedBloc() => _signInFailedBloc;

  @override
  WorkgroupsSelectionBloc workgroupsSelectionBloc() => _workgroupsSelectionBloc;

  @override
  TopicsSelectionBloc topicsSelectionBloc() => _topicsSelectionBloc;

  @override
  WorkflowFooterButtonBloc workflowFooterButtonBloc() =>
      _workflowFooterButtonBloc;
}
