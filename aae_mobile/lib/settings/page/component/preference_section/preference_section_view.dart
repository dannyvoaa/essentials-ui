import 'package:aae/settings/page/component/preference_section/preference_section_view_model.dart';
import 'package:flutter/material.dart';

class PreferenceSectionView extends StatelessWidget {
  final PreferenceSectionViewModel viewModel;

  PreferenceSectionView(this.viewModel);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          viewModel.table,
        ],
      );
}
