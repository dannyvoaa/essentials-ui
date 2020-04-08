import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:flutter/material.dart';

import 'sign_in_failed_bloc.dart';
import 'sign_in_failed_view.dart';
import 'sign_in_failed_view_model.dart';

/// Component for the sign in failure screen.
///
/// Ties together [SignInFailedBloc] and [SignInFailedView].
class SignInFailedComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Component<SignInFailedBloc, SignInFailedBlocFactory>(
        bloc: (factory) => factory.signInFailedBloc(),
        builder: (context, bloc) {
          return SourceBuilder.of<SignInFailedViewModel>(
            source: bloc.viewModel,
            builder: (snapshot) {
              if (snapshot.present) {
                return SignInFailedView(viewModel: snapshot.value);
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
