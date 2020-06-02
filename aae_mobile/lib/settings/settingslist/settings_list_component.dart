import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';

import 'settings_list_bloc.dart';
import 'settings_list_view_model.dart';
// test comment
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
      margin: EdgeInsets.all(16),
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
                stringValue: viewModel.location,
             //   onTapAction: () {
                  // Present the Settings Location view
              //  },
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: false,
                stringTitle: 'Workgroup',
                stringValue: viewModel.workgroup[1],
              ),

              TableHeader(
                stringTitle: 'Newsfeed preferences',
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: false,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Topics of interest',
                stringValue: 'Manage',
                onTapAction: () {
               //   navigateCommand(routes.buildTopicsPageRoute())(context);

                },

              ),
             //_buildTopics(context),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: false,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Workgroup news',
                stringValue: 'Manage',
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: false,
                boolShowDisclosureIndicator: true,
                stringTitle: 'Hub news',
                stringValue: 'Manage',
              ),
              TableHeader(
                stringTitle: 'Notifications',
              ),
              TableCellTitleValue(
                boolBorderTop: false,
                boolEnabled: false,
                boolShowDisclosureIndicator: false,
                stringTitle: 'Alert',
                stringValue: 'Off',
              ),
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

  Widget _buildTopics(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var i = 0; i < viewModel.topics.length; i++)
          TableCellTitleValue(
              onTapAction: () {
                print(viewModel.topics[i]);
                viewModel.onTopicTapped(viewModel.topics[i]);
              },
              boolShowCheckmark:
                  viewModel.selectedTopics.contains(viewModel.topics[i]),
              boolBorderTop: true,
              boolEnabled: true,
              boolShowDisclosureIndicator: false,
              stringTitle: viewModel.topics[i],
              stringValue: '')
      ],
    );
  }

  Widget _buildWorkgroups(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var i = 0; i < viewModel.workgroup.length; i++)
          TableCellTitleValue(
              onTapAction: () {
                print(viewModel.workgroup[i]);
                viewModel.onWorkgroupTapped(viewModel.workgroup[i]);
              },
              boolShowCheckmark:
                  viewModel.selectedWorkgroups.contains(viewModel.workgroup[i]),
              boolBorderTop: true,
              boolEnabled: true,
              boolShowDisclosureIndicator: false,
              stringTitle: viewModel.workgroup[i],
              stringValue: '')
      ],
    );
  }
}
