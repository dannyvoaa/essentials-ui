import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'welcome_bloc.dart';
import 'welcome_view.dart';
import 'welcome_view_model.dart';

/// Displays a welcome splash screen to a new user.
///
/// Ties together [WelcomeBloc] and [WelcomeView].
class WelcomeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Component<WelcomeBloc, WelcomeBlocFactory>(
        bloc: (factory) => factory.welcomeBloc(),
        builder: (context, bloc) {
          return SourceBuilder.of<WelcomeViewModel>(
            source: bloc.viewModel,
            builder: (snapshot) {
              if (snapshot.present) {
                return WelcomeView(viewModel: snapshot.value);
              } else {
                return _buildLoadingState(context);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(child: AaeLoadingSpinner());
  }
}
