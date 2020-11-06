import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/tables/table_cell_title_value_hub.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';

import 'settings_list_bloc.dart';
import 'settings_list_view_model.dart';

/// A [Component] that ties together [SettingsListBloc] and
/// [SettingsListView].
class TopicsListComponent extends StatelessWidget {
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
                stringTitle: 'Select topic of interest',
              ),

              _buildTopics(context),
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
          TableCellTitleValueHub(
              onTapAction: () {
                //print(viewModel.topics[i]);
                viewModel.onTopicTapped(viewModel.topics[i]);
              },
              boolShowCheckmark:viewModel.selectedTopics.contains(viewModel.topics[i]),
              boolBorderTop: true,
              boolEnabled: true,
              boolShowDisclosureIndicator: true,
              stringTitle: viewModel.topics[i],
              stringValue: '')
      ],
    );
  }




}