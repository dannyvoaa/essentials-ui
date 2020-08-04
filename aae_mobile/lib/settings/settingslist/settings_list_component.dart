import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/common/commands/navigate_command.dart';
import 'settings_list_bloc.dart';
import 'settings_list_view_model.dart';

/// A [Component] that ties together [SettingsListBloc] and
/// [SettingsListView].
class SettingsListComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Component<SettingsListBloc, SettingsListBlocFactory>(
      bloc: (factory) => factory.settingsListBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<SettingsListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _SettingsListView(viewModel: snapshot.value);
            } else {
              return _loadingState();
            }
          },
        );
      },
    );
  }

  Widget _loadingState() => Column();
}

/// A View that shows a list on the settings page.
///
class _SettingsListView extends StatelessWidget {
  final SettingsListViewModel viewModel;

  _SettingsListView({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              TableHeader(
                stringTitle: 'About me',
              ),
//              TableCellTitleValue(
//                boolBorderTop: true,
//                boolEnabled: false,
//                stringTitle: 'Name',
//                stringValue: viewModel.displayName,
//              ),
              TableCellTitleValue(
                boolShowDisclosureIndicator: false,
                stringTitle: 'Location',
                stringValue: viewModel.userlocation,
                //   onTapAction: () {
                // Present the Settings Location view
                //  },
              ),
              TableHeader(
                stringTitle: 'Newsfeed preferences',
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: true,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Hub news',
              //  stringValue: 'Manage',
                 txt: 'Manage',
                onTapAction: () {
                  navigateCommand(routes.buildHubLocationPageRoute())(context);

                },
              ),
              //_buildTopics(context),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: true,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Workgroup news',
                //  stringValue: 'Manage',
                txt: 'Manage',
                onTapAction: () {
                  navigateCommand(routes.buildWorkgroupPageRoute())(context);

                },
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: true,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Topics of interest',
                //  stringValue: 'Manage',
                txt: 'Manage',
                onTapAction: () {
                  navigateCommand(routes.buildTopicsPageRoute())(context);

                },
              ),

              //    TableHeader(
              //       stringTitle: 'Notifications',
              //      ),
              //    TableCellTitleValue(
              //    boolBorderTop: false,
              //        boolEnabled: false,
              //      boolShowDisclosureIndicator: false,
              //      stringTitle: 'Alert',
              //      stringValue: '⬤',
              //  ),
              //  _buildTopics(context),
//              Padding(
//                padding: const EdgeInsets.only(top:0),
//                child: _buildWorkgroups(context),
//              ),
//              TableFooter(
//                stringMessage:
//                    'Follow your topics and workgroup to improve your reading expereince.',
//              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
      ),
    );
  }



}
