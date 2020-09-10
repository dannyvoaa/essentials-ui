import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/sign_in/workflow/constants/sign_in_routes.dart';
import 'package:aae/workflow/common/workflow_state.dart';

/// States for the sign-in workflow.
///
/// Class exists for importing convenience.
class SignInStates {
  static final root = WorkflowState(
    name: 'root',
    children: {signIn, accountCreation},
    initial: signIn,
    routeSegment: routes.signIn,
    navigateOnTransition: false,
  );

  // Substates of root:

  /// State while the the user is signing in - the workflow will be in this
  /// state while there is not a valid signed in user.
  static final signIn = WorkflowState(
    name: 'SignIn',
    children: {silentSignIn, welcomePage, validityCheck, loginPage, failure},
    // Initial state is context-dependent; will need to be set manually.
    navigateOnTransition: false,
  );

  /// State while the user is creating an account - the workflow will enter this
  /// state if the account that signs in needs to create a AAE profile.
  static final accountCreation = WorkflowState(name: 'AccountCreation', children: {hubLocationsSelection, workgroupsSelection, topicsSelection},
    initial: hubLocationsSelection,
    navigateOnTransition: true,
  );

  // Substates of signIn:

  /// State while the app is attempting to sign in silently.
  static final silentSignIn = WorkflowState(
    name: 'SilentSignIn',
    navigateOnTransition: false,
  );

  /// State while the welcome page is displayed to the user.
  static final welcomePage = WorkflowState(
    name: 'WelcomePage',
    routeSegment: SignInRoutes.welcomeSegment,
    navigateOnTransition: true,
  );

  /// State while the app is checking whether the new signed in user is valid.
  static final validityCheck = WorkflowState(
    name: 'ValidityCheck',
    routeSegment: SignInRoutes.loadingSegment,
    navigateOnTransition: true,
  );

  /// State while the login page is displayed to the user.
  static final loginPage = WorkflowState(
    name: 'LoginPage',
    routeSegment: SignInRoutes.loginSegment,
    navigateOnTransition: true,
  );

  /// State when the user's sign in has failed.
  static final failure = WorkflowState(
    name: 'Failure',
    routeSegment: SignInRoutes.failedSegment,
    navigateOnTransition: true,
  );

  // Substates of accountCreation:

  /// State while the user is selecting topics
  static final topicsSelection = WorkflowState(
    name: 'TopicsSelection',
    routeSegment: SignInRoutes.topicsSelectionSegment,
    navigateOnTransition: true,
  );

  /// State while the user is selecting topics
  static final hubLocationsSelection = WorkflowState(
    name: 'HubLocationsSelection',
    routeSegment: SignInRoutes.hubLocationsSelectionSegment,
    navigateOnTransition: true,
  );

  /// State while the user is choosing workgroups.
  static final workgroupsSelection = WorkflowState(
    name: 'WorkgroupsSelection',
    routeSegment: SignInRoutes.workgroupsSelectionSegment,
    navigateOnTransition: true,
  );
}
