import 'package:aae/settings/page/component/preference_section/preference_section_view.dart';
import 'package:flutter/material.dart';
import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'preference_section_view_model.dart';
import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';

class PreferenceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Component<ModifyPreferenceBloc, ModifyPreferenceBlocFactory>(
        bloc: (factory) => factory.preferenceBloc(),
        builder: (context, bloc) =>
            SourceBuilder.of<PreferenceSectionViewModel>(
                source: bloc.viewModel,
                builder: (snapshot) {
                  if (snapshot.present) {
                    return PreferenceSectionView(snapshot.value);
                  } else {
                    return _buildLoadingState(context);
                  }
                }),
      );
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: AaeLoadingSpinner(),
    );
  }
}
