import 'package:aae/common/widgets/placeholder/placeholder_screens.dart';
import 'package:aae/settings/workflow/modifying/modify_routes.dart';
import 'package:aae/settings/workflow/modifying/modify_state_machine.dart';
import 'package:flutter/material.dart';
import 'package:aae/workflow/common/workflow.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:aae/service_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/settings/page/component/preference_section/preference_component.dart';

final key = GlobalKey<NavigatorState>();

/// [ModifyWorkflow] handles the events route transitions and fires off \
/// opertaions for both updating on device Settings and AAE Preferenecs
class ModifyWorkflow extends StatelessWidget {
  final _routeTable = <String, WidgetBuilder>{
    //ModifyRoutes.
    ModifyRoutes.changeContentPreference: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement change content preferences',
        ),
    ModifyRoutes.changeLocationService: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement change location settings',
        ),
    ModifyRoutes.changeNotificationService: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement change notification settings',
        ),
    ModifyRoutes.changeTopicService: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement change topic service',
        ),
    ModifyRoutes.changeWorkgroup: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement change workgroup',
        ),
    ModifyRoutes.savePreferences: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement save to aaeserver',
        ),
    ModifyRoutes.saveSettings: (context) => AaePlaceholderScreens(
          screenAnnote: 'TODO: implement save to device',
        ),
  };

  @override
  Widget build(BuildContext context) => Workflow<WorkflowEvent>(
        factory: (context) =>
            ServiceProvider.serviceOf<ModifyStateMachineFactory>(context)
                .modifyStateMachine(),
        onGenerateRoute: _generatePage,
        navigatorKey: key,
      );

  WidgetBuilder _generatePage(RouteSettings settings) {
    if (settings.isInitialRoute) {
      //TODO (rpaglinawan): change this to build the view model for the
      //settings page
      return (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: AaeColors.white,
            elevation: 8,
            leading: CloseButton(color: AaeColors.gray),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    //MARK (rpaglinawan): Stubbed out for user preferences
                    TableHeader(
                      stringTitle: 'About Me',
                    ),
                    TableCellTitleValue(
                      boolBorderTop: true,
                      boolEnabled: false,
                      stringTitle: 'Name',
                      stringValue: 'American Employee',
                    ),
                    TableCellTitleValue(
                      boolShowDisclosureIndicator: true,
                      stringTitle: 'Location',
                      stringValue: 'Dallas/Fort Worth',
                      onTapAction: () {
                        // Present the Settings Location view
                      },
                    ),
                    //END MARK:
                    //MARK (rpaglinawan): Stubbed out for device preferences
                    TableHeader(
                      stringTitle: 'General',
                    ),
                    TableCellTitleValue(
                      boolBorderTop: true,
                      boolEnabled: false,
                      boolShowDisclosureIndicator: true,
                      stringTitle: 'Notifications',
                      stringValue: 'Off',
                    ),
                    // END MARK:
                    // MARK (rpaglinawan): Stubbed out for AAE Preferences
                    TableHeader(
                      stringTitle: 'Personal',
                    ),
                    PreferenceComponent(),
                    // END MARK
                    TableFooter(
                      stringMessage:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin mollis eget orci eu molestie.',
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          ));
    }
    final uri = Uri.parse(settings.name);

    return _routeTable[uri.path];
  }
}
