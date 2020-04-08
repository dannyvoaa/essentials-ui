import 'package:aae/common/commands/navigate_command.dart';
import 'package:aae/navigation/routes.dart' as routes;
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

import 'settings_buttons_list_view_model.dart';

/// BLoC for the [SettingsButtonsListComponent].
///
/// Exposes a [SettingsButtonsListViewModel] for that component to use.
class SettingsButtonsListBloc {
  Source<SettingsButtonsListViewModel> get viewModel =>
      toSource(Observable.just(_createViewModel()));

  @provide
  SettingsButtonsListBloc();

  SettingsButtonsListViewModel _createViewModel() =>
      SettingsButtonsListViewModel(
        buttons: [
          SettingsButton(
            text: 'Sign Out',
            icon: Icons.save_alt,
            route: navigateFromRootCommand(routes.buildSignInRoute()),
          ),
        ],
      );
}

/// Constructs new instances of [SettingsButtonsListBloc]s via the DI framework.
abstract class SettingsButtonsListBlocFactory implements ProvidedService {
  @provide
  SettingsButtonsListBloc settingsButtonsListBloc();
}
