import 'package:aae/common/widgets/workflow_page/workflow_footer_button/workflow_footer_button_bloc.dart';
import 'package:aae/profile/repository/locations_repository.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/profile/repository/topics_repository.dart';
import 'package:aae/profile/repository/workgroups_repository.dart';
import 'package:aae/sign_in/bloc/create_profile_bloc.dart';
import 'package:aae/sign_in/bloc/sign_in_bloc.dart';
import 'package:aae/sign_in/component/failed/sign_in_failed_bloc.dart';
import 'package:aae/sign_in/component/login/login_bloc.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_bloc.dart';
import 'package:aae/sign_in/component/welcome/welcome_bloc.dart';
import 'package:aae/sign_in/component/hub_locations_selection/hub_locations_selection_bloc.dart';
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
        HubLocationsSelectionBlocFactory,
        TopicsSelectionBlocFactory,
        WorkflowFooterButtonBlocFactory {
  final SignInBloc _signInBloc;
  final CreateProfileBloc _createProfileBloc;
  final WelcomeBloc _welcomeBloc;
  final LoginBloc _loginBloc;
  final SignInFailedBloc _signInFailedBloc;
  final WorkgroupsSelectionBloc _workgroupsSelectionBloc;
  final HubLocationsSelectionBloc _hubLocationsSelectionBloc;
  final TopicsSelectionBloc _topicsSelectionBloc;
  final WorkflowFooterButtonBloc _workflowFooterButtonBloc;

  @provide
  SignInWorkflowBlocProvider(
    SignInSharedDataRepository sharedDataRepository,
    ProfileRepository profileRepository,
    TopicsRepository topicsRepository,
    HubLocationsRepository hubLocationsRepository,
    WorkgroupsRepository workgroupsRepository,
    this._signInBloc,
    this._welcomeBloc,
    this._loginBloc,
    this._signInFailedBloc,
    this._workflowFooterButtonBloc,
  )   : _createProfileBloc = CreateProfileBloc(profileRepository, sharedDataRepository),
        _workgroupsSelectionBloc = WorkgroupsSelectionBloc(sharedDataRepository, workgroupsRepository),
        _hubLocationsSelectionBloc = HubLocationsSelectionBloc(sharedDataRepository, hubLocationsRepository),
        _topicsSelectionBloc = TopicsSelectionBloc(sharedDataRepository, topicsRepository);

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
  HubLocationsSelectionBloc hubLocationsSelectionBloc() => _hubLocationsSelectionBloc;

  @override
  TopicsSelectionBloc topicsSelectionBloc() => _topicsSelectionBloc;

  @override
  WorkflowFooterButtonBloc workflowFooterButtonBloc() => _workflowFooterButtonBloc;
}
