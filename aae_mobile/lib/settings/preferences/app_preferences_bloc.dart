import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:aae/settings/listener/app_preferences_listener.dart';

// TODO: implement system to read and write preferences wrap around the top
// stack of the scaffold
class AppPreferencesBloc {
  Source<AppPreferencesListener> get listener =>
      toSource(Observable.just(_createListener()));

  @provide
  AppPreferencesBloc();

  AppPreferencesListener _createListener() {}
}

/// Constructs new instances of [AppPreferencesBloc]s via the DI framework.
abstract class AppPreferencesBlocFactory implements ProvidedService {
  @provide
  AppPreferencesBloc appPreferencesBloc();
}
