import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';

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
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              TableHeader(
                stringTitle: 'About Me',
              ),
              TableCellTitleValue(
                boolBorderTop: true,
                boolEnabled: false,
                stringTitle: 'Name',
                stringValue: viewModel.displayName,
              ),
              TableCellTitleValue(
                boolShowDisclosureIndicator: true,
                stringTitle: 'Location',
                stringValue: viewModel.location,
                onTapAction: () {
                  // Present the Settings Location view
                },
              ),
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
              TableHeader(
                stringTitle: 'Following',
              ),
              _buildTopics(context),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _buildWorkgroups(context),
              ),
              TableFooter(
                stringMessage:
                    'Follow your topics and workgroup to improve your reading expereince.',
              ),
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
