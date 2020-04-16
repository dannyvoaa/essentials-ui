import 'package:aae/bloc/source_builder.dart';
import 'package:aae/common/widgets/component/component.dart';
// import 'package:aae/common/widgets/error/error_dialog/dialog_error.dart';
import 'package:aae/common/widgets/loading/aae_loading_spinner.dart';
import 'package:aae/sign_in/component/login/login_bloc.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';
import 'login_view_model.dart';

/// Displays a login screen to a new user.
///
/// Ties together [LoginBloc] and [LoginView].
class LoginComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Component<LoginBloc, LoginBlocFactory>(
        bloc: (factory) => factory.loginBloc(),
        builder: (context, bloc) {
          return SourceBuilder.of<LoginViewModel>(
            source: bloc.viewModel,
            builder: (snapshot) {
              if (snapshot.present) {
                bool widgetFocus = true;
                return LoginView(
                  viewModel: snapshot.value,
                  textFocus: widgetFocus,
                );
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
