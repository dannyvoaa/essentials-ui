import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/button/aee_button.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/list/padded_vertical_list.dart';
import 'package:aae/common/widgets/section/section_header.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

import 'settings_buttons_list_bloc.dart';
import 'settings_buttons_list_view_model.dart';

const _margin = AaeDimens.contentMargin;

/// A [Component] that ties together [SettingsButtonsListBloc] and
/// [SettingsButtonsListView].
class SettingsButtonsListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component<SettingsButtonsListBloc, SettingsButtonsListBlocFactory>(
      bloc: (factory) => factory.settingsButtonsListBloc(),
      builder: (context, bloc) {
        return SourceBuilder.of<SettingsButtonsListViewModel>(
          source: bloc.viewModel,
          builder: (snapshot) {
            if (snapshot.present) {
              return _SettingsButtonsListView(viewModel: snapshot.value);
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

/// A View that shows a list of buttons on the settings page..
///
class _SettingsButtonsListView extends StatelessWidget {
  final SettingsButtonsListViewModel viewModel;

  _SettingsButtonsListView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final widgets = viewModel.buttons
        .map((settingsButton) => _buildButton(context, settingsButton))
        .toList();

    return Container(
      child: ListView(
        children: [
          SectionHeader(title: 'Settings'),
          PaddedVerticalList(
            children: widgets,
          )
        ],
      ),
      constraints: BoxConstraints(maxWidth: 460.0),
      padding: EdgeInsets.symmetric(
        horizontal: _margin,
      ),
    );
  }

  Widget _buildButton(BuildContext context, SettingsButton settingsButton) {
    return AaeButton.secondaryRegular(
      text: settingsButton.text,
      icon: settingsButton.icon,
      onTapped: () {
        settingsButton.route(context);
      },
      width: double.infinity,
    );
  }
}
