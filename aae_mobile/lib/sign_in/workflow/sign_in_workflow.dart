import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/common/widgets/workflow_page/workflow_page_template.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/service_provider.dart';
import 'package:aae/sign_in/component/failed/sign_in_failed_component.dart';
import 'package:aae/sign_in/component/login/login_component.dart';
import 'package:aae/sign_in/component/topics_selection/topics_selection_component.dart';
import 'package:aae/sign_in/component/welcome/welcome_component.dart';
import 'package:aae/sign_in/component/workgroups_selection/workgroups_selection_component.dart';
import 'package:aae/sign_in/component/hub_locations_selection/hub_locations_selection_component.dart';
import 'package:aae/sign_in/workflow/sign_in_state_machine.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/workflow/common/workflow.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:flutter/material.dart';

import 'constants/sign_in_routes.dart';

final key = GlobalKey<NavigatorState>();

/// Guides the user through signing into the app.
///
/// This flow will be launched when the app starts up, and must be completed
/// before the user can get to the home page of the app.
///
/// This widget is responsible for defining how the workflow's [Navigator]
/// handles named routes. When a route is pushed, it will use the _generatePage
/// function to determine which component to display on the screen.
class SignInWorkflow extends StatelessWidget {
  final _routeTable = <String, WidgetBuilder>{
    SignInRoutes.welcome: (context) => WelcomeComponent(),
    SignInRoutes.login: (context) => LoginComponent(),
    SignInRoutes.loading: (context) => Center(child: AaeLoadingSpinner()),
    SignInRoutes.failed: (context) => SignInFailedComponent(),
    SignInRoutes.topicsSelection: (context) => TopicsSelectionComponent(),
    SignInRoutes.hubLocationsSelection: (context) => HubLocationsSelectionComponent(),
    SignInRoutes.workgroupsSelection: (context) => WorkgroupsSelectionComponent(),
    SignInRoutes.failed: (context) => _buildFailureScreen(),
  };

  SignInWorkflow();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await key.currentState.maybePop(),
      child: Workflow<WorkflowEvent>(
        factory: (context) =>
            ServiceProvider.serviceOf<SignInStateMachineFactory>(context)
                .signInStateMachine(),
        onGenerateRoute: _generatePage,
        navigatorKey: key,
      ),
    );
  }

  WidgetBuilder _generatePage(RouteSettings settings) {
    if (settings.name == routes.root) {
      return (context) => Center(child: AaeLoadingSpinner());
    }
    final uri = Uri.parse(settings.name);

    return _routeTable[uri.path];
  }

  static Widget _buildFailureScreen() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AaeDimens.noElevation,
      ),
      body: WorkflowPageTemplate(
        title: 'Could not create a profile. Please try again later.',
      ),
    );
  }
}
