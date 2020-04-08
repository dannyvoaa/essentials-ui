import 'package:aae/common/widgets/placeholder/placeholder_functions.dart';
import 'package:aae/common/widgets/tables/table_cell_title_value.dart';
import 'package:aae/common/widgets/tables/table_components.dart';
import 'package:aae/settings/page/component/settings_section/settings_section_view_model.dart';
import 'package:flutter/material.dart';

class SettingsSectionView extends StatelessWidget {
  final SettingsSectionViewModel viewModel;

  SettingsSectionView(this.viewModel);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TableHeader(
            stringTitle: 'Settings',
          ),
        ],
      );
}
